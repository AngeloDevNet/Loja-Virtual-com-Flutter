import 'package:carousel_pro/carousel_pro.dart';
import "package:flutter/material.dart";
import 'package:loja_virtual_version2/models/product.dart';

class ProductScreen extends StatelessWidget{

  const ProductScreen(this.product);
  final Product product;
  
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: [
                Image.network(product.images[0]),
                Image.network(product.images[1]),
                Image.network(product.images[0]),
                // product.images.map((url){
                //   return NetworkImage(url);
                // }).toList(),
              ],
              dotSize: 5,
              moveIndicatorFromBottom: 100,
              noRadiusForIndicator: true,
              showIndicator: true,              
              overlayShadow: true,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              borderRadius: true,
              dotColor: primaryColor,
              autoplay: true,
              animationDuration: Duration(seconds: 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "A partir de: ",
                    style: TextStyle(
                      fontSize: 13, 
                      color: Colors.grey[500],
                    )
                  ),
                ),
                Text(
                  "R\$ 19.99",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
