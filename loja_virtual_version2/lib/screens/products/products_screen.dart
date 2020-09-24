import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/commom/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_version2/models/product_manager.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';
import 'package:loja_virtual_version2/screens/products/components/product_list_tile.dart';
import 'package:loja_virtual_version2/screens/products/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild ProductsScreen");
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text("Produtos");
            } else {
              return LayoutBuilder(
                builder: (_, contraints){
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                        context: context,
                        builder: (context) => SearchDialog(productManager.search),
                      );
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                      width: contraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      )
                    ),
                  );
              });
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                    tooltip: "Pesquisar produto",
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      final search = await showDialog<String>(
                        context: context,
                        builder: (context) => SearchDialog(productManager.search),
                      );
                      if (search != null) {
                        productManager.search = search;
                      }
                    });
              } else {
                return IconButton(
                  onPressed: () {
                    productManager.search = "";
                  },
                  tooltip: "Limpar pesquisa",
                  icon: Icon(Icons.close),
                );
              }
            },
          ),
          Consumer<UserManager>(
              builder: (_, userManager, __) {
                if(userManager.adminEnabled) {
                  return IconButton(
                    icon: Icon(Icons.add),
                    onPressed: (){
                      Navigator.of(context)
                        .pushReplacementNamed(
                          '/edit_product',
                        );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductListTile(filteredProducts[index]);
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');
          
        },
        child: Icon(Icons.shopping_cart,),
      ),
    );
  }
}
