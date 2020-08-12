import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product();
  Product.fromDocument(DocumentSnapshot document){
    this.id = document.documentID;
    this.name = document["name"] as String;
    this.description = document["description"] as String;
    this.images = List<String>.from(document["images"] as List<dynamic>);
    
  }

  String id;
  String name;
  String description;
  List<String> images;

}
