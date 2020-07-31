import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_version2/helpers/firebase_erros.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  User user;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;      // returna valor logico se usuario estar logado ou não
  
  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
        //await Future.delayed(Duration(seconds: 1x'0));  // delay programado
        await _loadCurrentUser(firebaseUser: result.user);
        onSuccess();
        print("POS LOGIN RETURN THIS USER: "+ result.user.uid);
    } on PlatformException catch (e){
      print("CATCH, RETURN THIS ERROR: "+ e.toString());
      //await Future.delayed(Duration(seconds: 10));
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {

    loading = true;
    try {

      final AuthResult result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();        // comando que envia as informações para o firebase
      onSuccess();

    } on PlatformException catch(e){
      onFail(getErrorString(e.code));
    } 
    loading = false;

  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser(); // ser "firebaseUser" != de nulo então usa variavel firebaseuser
    if(currentUser != null){
      final DocumentSnapshot docUser = await firestore.collection("users").document(currentUser.uid).get();
      user = User.fromDocument(docUser);
      print("____________________ ${user.name} ____________________  " + user.email + "____________________");
      notifyListeners();
    }
    
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

}