import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/commom/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_version2/models/admin_users_manager.dart';
import 'package:provider/provider.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Consumer<AdminUsersManager>(
        builder: (context, adminUsersManager, child) {
          return AlphabetListScrollView(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
            highlightTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        }
      ),
    );
  }
}