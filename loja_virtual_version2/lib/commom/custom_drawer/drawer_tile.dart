import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final int curPage = context.watch<PageManager>().page;  // .WATCH usado dentro build.
    final primaryColor = Theme.of(context).primaryColor;
    
    return InkWell(
      onTap: (){
        context.read<PageManager>().setPage(page);        // .READ usado dentro de funções // quando clicado em um botão que estar drawer, é enviado para o PageManager a tela que foi clicada
        print("toquei $page");
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Icon(
                iconData,
                size: 32.0,
                color: curPage == page ? primaryColor : Colors.grey[800],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColor : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}