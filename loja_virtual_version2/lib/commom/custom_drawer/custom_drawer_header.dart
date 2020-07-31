import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 200,                               
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Loja do \nWillys",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Olá ${userManager.user?.name ?? ""}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                onPressed: (){
                  if(userManager.isLoggedIn){
                    userManager.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(            
                  userManager.isLoggedIn
                      ? "Deslogar-se"
                      : "Entre ou cadastre-se >",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(                      
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
              Divider(thickness: 0.3,),
            ],
          );
        },
      ),
    );
  }
}