import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_version2/models/section_item.dart';

class Section {

  Section.fromDocument(DocumentSnapshot document){
    this.name = document.data["name"] as String;
    this.type = document.data["type"] as String;
    items = (document.data["items"] as List).map(
      (item) => SectionItem.fromMap(item as Map<String, dynamic>)).toList();
    print("DADOS "+items.toString());
  }

  String name;
  String type;
  List<SectionItem> items;

}