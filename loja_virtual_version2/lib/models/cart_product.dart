import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'item_size.dart';

/*
esta clase monta um product da loja em um product para cartProduct. Basicamente é uma conversora. Este objeto vai para lista de cartProduct em cartManager
*/
class CartProduct extends ChangeNotifier {
  //
  CartProduct.fromProduct(this.product) { //first constructor
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }
  
  CartProduct.fromDocument(DocumentSnapshot document) { // constructor from cartManager
    id = document.documentID;
    productId = document.data["pid"] as String;
    quantity = document.data["quantity"] as int;
    size = document.data["size"] as String;

    firestore.document('products/$productId').get().then(
      (doc){
        product = Product.fromDocument(doc);
        notifyListeners();
      });
  }
  final Firestore firestore = Firestore.instance;
  
  String id;  //id cartProdutc
  String productId;   // corresponde ao product. é a referencia
  int quantity;
  String size;      // name: p or g or gg

  Product product;

  ItemSize get itemSize {
    if(product == null ) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if(product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap(){
    return {
      "pid": this.productId,
      "quantity": this.quantity,
      "size": this.size,
    };
  }

  bool stackable(Product product){ 
    return product.id == this.productId && product.selectedSize.name == this.size;
  }

  void increment(){
    this.quantity++;
    notifyListeners();
  }

  void decrement(){
    this.quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final ItemSize size = itemSize;
    if(size == null) return false;
    return size.stock >= quantity;
  }

}