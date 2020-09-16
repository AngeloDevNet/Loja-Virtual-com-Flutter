import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_version2/models/section.dart';

class HomeManager extends ChangeNotifier {

  HomeManager(){
    _loadSection();
  }

  List<Section> sections = [];
  final firestore = Firestore.instance;

  Future <void> _loadSection() async {
    firestore.collection("home").snapshots().listen((snapshot) {
      sections.clear();
      for(final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocument(document)); 
      }
      notifyListeners();
    });
  }

}