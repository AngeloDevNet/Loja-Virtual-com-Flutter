import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/commom/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_version2/models/home_manager.dart';
import 'package:loja_virtual_version2/screens/home/components/section_staggered.dart';
import 'package:provider/provider.dart';
import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 211, 118, 130),
                  Color.fromARGB(255, 253, 181, 168),
                ],

              )
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                snap: true,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("Loja do Willys"),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/cart');
                    },
                  )
                ], 
              ),

              Consumer<HomeManager>(
                builder: (_, homeManager,__) {
                  final List<Widget> children = homeManager.sections.map<Widget>(
                    (section) {
                      switch(section.type) {
                        case "List":
                          return SectionList(section);
                        case 'Staggered':
                          return SectionStaggered(section);
                        default:
                          return Container();
                      }
                    }
                  ).toList();
                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                }
              ),
            ],
          ),
        ],
      )
    );
  }
}