import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:loja_virtual_version2/models/user.dart';
import 'package:loja_virtual_version2/models/user_manager.dart';
import 'cart_product.dart';

class CartManager extends ChangeNotifier {

  List<CartProduct> items = [];
  
  User user;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager){ 
    user = userManager.user;      // user logado
    items.clear();

    if(user != null){
      _loadCartItems();
    }
  }
  bool get hasProductCart {
    if(items.length == 0) return false;
    return true;
  }

  Future<void> _loadCartItems() async {  // get cart firebase, add on items
    final QuerySnapshot cartSnap =  await user.cartReference.getDocuments();

    items = cartSnap.documents.map(
        (d) => CartProduct.fromDocument(d)..addListener( _onItemUpdated )
    ).toList();
  }
  
  void addToCart(Product product) { // analyzes equal products and increment,  add cart product
    final CartProduct cartProduct = CartProduct.fromProduct(product);
    try {
      final CartProduct e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      cartProduct..addListener( _onItemUpdated );
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap()).then(
        (doc) => cartProduct.id = doc.documentID);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct) { // remoce items, delete firebase, remove listeners,
    items.removeWhere((cP) => cP.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener( _onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated() {   // update increment CartProduct, remove increment = 0
    productsPrice = 0.0;
    for(int i = 0; i<items.length; i++) {
      final CartProduct cartProduct = items[i];
      if(cartProduct.quantity == 0){
        removeOfCart(cartProduct);
        i--; 
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  

  void _updateCartProduct(CartProduct cartProduct) { // atualiza dados do cartProduct no firebase
  if(cartProduct.id != null)
    user.cartReference.document(cartProduct.id).updateData(cartProduct.toCartItemMap());
  }

  bool get isCartValid {
    for(final cartProduct in items) {
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }
} 