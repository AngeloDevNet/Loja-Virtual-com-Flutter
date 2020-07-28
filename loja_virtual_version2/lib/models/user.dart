import "package:cloud_firestore/cloud_firestore.dart";

class User {

  User({this.email, this.password, this.name, this.id});

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  DocumentReference get firestoreRef =>  Firestore.instance.document("users/$id");
  //Firestore.instance.collection("users").document(id);

  Future<void> saveData() async {
    await firestoreRef.setData(
      toMap()
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "name": this.name,
      "email": this.email,
      "passDebug": this.password,
    };
  }
}