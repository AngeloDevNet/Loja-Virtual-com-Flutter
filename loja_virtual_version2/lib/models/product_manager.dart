import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_version2/models/product.dart';

class ProductManager extends ChangeNotifier {

  // busca todos os produtos no firebase, e tambem atualiza um produto
  ProductManager(){
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<Product> allProducts = [];

  String _search = '';
  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {

    final List<Product> filteredProducts = [];
    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where(
        (p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  _loadAllProducts() async {
    final QuerySnapshot snapProducts = 
      await firestore.collection("products").getDocuments();

    for(DocumentSnapshot doc in snapProducts.documents){
      print(doc.data["name"] + "\n");
      print(doc.data["description"] + "\n");
    }
    this.allProducts = snapProducts.documents.map(
      (p) => Product.fromDocument(p) ).toList();      // .map transforma cada um dos documentos em obejtos do tipo Product depois transformando em uma lista de produtos
    
    notifyListeners();      // notificar ouvintes.  
  }

}