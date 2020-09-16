import "package:flutter/material.dart";
import 'package:loja_virtual_version2/models/item_size.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:provider/provider.dart';


class SizeWidget extends StatelessWidget {

  const SizeWidget({this.size});
  final ItemSize size;              // size construido

  @override
  Widget build(BuildContext context){
    print("rebuild SizeWidget");
    final product = context.watch<Product>();         // usado pra rebuidar o widget inteiro. Apenas uma parte = consumer
    final selected = size == product.selectedSize;        // comparação de objetos. return bool

    Color color;
    if(!size.hasStock)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else 
      color = Colors.grey[600];

    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                "R\$ ${size.price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}