import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/commom/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_version2/models/page_manager.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:loja_virtual_version2/screens/login/login_screen.dart';
import 'package:loja_virtual_version2/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

/*
basicamente nesta tela temos todas as telas. Esta é a tela básica. 
Aqui é configurado o pagecontroller
*/


class BaseScreen extends StatelessWidget {

  final PageController pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(this.pageController),
      child: PageView(
      controller: pageController,
       physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Home"),
            ),
          ),
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Meus Produtos"),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text("Lojas"),
            ),
          ),
        ]
      ),
    );
  }
}