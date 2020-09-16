import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_version2/models/user.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {

  List<User> users = [];

  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscripition;

  void updateUser( UserManager userManager) { 
    _subscripition?.cancel();
    if( userManager.adminEnabled ) {
      _listenToUsers();
   } else {
     users.clear();
     notifyListeners();
   }
  }

  void _listenToUsers() async {
      _subscripition = firestore.collection("users").snapshots().listen((snapshot){
      users = snapshot.documents.map((users) => User.fromDocument(users)).toList();
      users.sort(
        (userA, userB) => userA.name.toLowerCase().compareTo(userB.name.toLowerCase()));
    notifyListeners();
    });
    
  }

  List<String> get names => users.map((user) => user.name ).toList();
  @override 
  void dispose() {
    _subscripition?.cancel();
    super.dispose();
  }
}