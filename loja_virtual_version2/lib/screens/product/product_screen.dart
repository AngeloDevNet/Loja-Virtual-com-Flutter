import 'package:carousel_pro/carousel_pro.dart';
import "package:flutter/material.dart";
import 'package:loja_virtual_version2/models/cart_manager.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';
import 'package:loja_virtual_version2/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    print("rebuild ProductScreen");
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      // .value passa valor jpa carregado, create: carrega algo
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if(userManager.adminEnabled) {
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context)
                        .pushReplacementNamed(
                          '/edit_product',
                          arguments: product,
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
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((urlImageProduct) {
                  return NetworkImage(urlImageProduct);
                }).toList(),
                // Image.network(product.images[0]),
                // Image.network(product.images[1]),
                // Image.network(product.images[0]),
                dotSize: 5,
                moveIndicatorFromBottom: 100,
                noRadiusForIndicator: true,
                showIndicator: true,
                overlayShadow: true,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                borderRadius: true,
                dotColor: primaryColor,
                autoplay: false,
                animationDuration: Duration(seconds: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[700],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("A partir de: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[500],
                        )),
                  ),
                  Text(
                    "R\$ ${product.basePrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Tamanhos",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: product.sizes.map((s) {
                      return SizeWidget(
                        size: s,
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //if(product.hasStock)
                  Consumer2<UserManager, Product>(
                      builder: (_, userManager, product,__) {
                    return SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed:
                            product.selectedSize != null
                                ? () {
                                    if (userManager.isLoggedIn){
                                      context.read<CartManager>().addToCart(product);
                                      Navigator.of(context).pushNamed('/cart');
                                      } else {
                                      Navigator.of(context).pushNamed("/login");
                                    }
                                  }
                                : null,
                        color: primaryColor,
                        textColor: Colors.white,
                        child: userManager.isLoggedIn
                            ? Text(
                                product.hasStock
                                    ? "Adcionar ao carrinho"
                                    : "Sem estoque",
                                style: TextStyle(fontSize: 18),
                              )
                            : product.hasStock
                                ? Text(
                                    "Entre para comprar",
                                    style: TextStyle(fontSize: 18),
                                  )
                                : Text(
                                    "Sem estoque",
                                    style: TextStyle(fontSize: 18),
                                  ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
