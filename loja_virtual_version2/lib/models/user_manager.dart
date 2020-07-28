import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual_version2/helpers/firebase_erros.dart';
import 'user.dart';


class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseUser user;
  bool _loading = false;
  bool get loading => _loading;
  

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
        //await Future.delayed(Duration(seconds: 10));  // delay programado
        this.user = result.user;
        onSuccess();
        print("POS LOGIN RETURN THIS USER: "+ result.user.uid);
    } on PlatformException catch (e){
      print("CATCH, RETURN THIS ERROR: "+ e.toString());
      await Future.delayed(Duration(seconds: 10));
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {

    loading = true;
    try {

      final AuthResult result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.id = result.user.uid;
      await user.saveData();        // comando que envia as informações para o firebase
      onSuccess();

    } on PlatformException catch(e){
      onFail(getErrorString(e.code));
    } 
    loading = false;

  }

  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if(currentUser != null){
      user = currentUser;
      print(" POS LAODCURRENTUSER, USUÁRIOS   ========= " + user.uid + currentUser.uid);
    }
    notifyListeners();
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

}