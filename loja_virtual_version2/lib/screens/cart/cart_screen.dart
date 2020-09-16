import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/commom/price_card.dart';
import 'package:loja_virtual_version2/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  print("CART_MANAGER");
  return Scaffold(
    appBar: AppBar(
      title: const Text("Carrinho"),
      centerTitle: true,
    ),
    body: Consumer<CartManager>(
      builder: (_, cartManager, __) {
        return ListView(children: <Widget>[
          Column(
            children: cartManager.items
              .map((cartProduct) => CartTile(cartProduct))
              .toList(),
          ),
          cartManager.hasProductCart
            ? PriceCard(
                buttonText: "Continuar para entrega",
                onpressed: cartManager.isCartValid ? () {} : null,
              )
            : Center(
                child: SizedBox(
                  height: 50,
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange[900],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(child: Icon(Icons.remove_shopping_cart, color: Colors.white)),
                      Text(
                        "Carrinho vazio",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
              ),
                ))
        ]);
      },
    ),
  );
}
}
