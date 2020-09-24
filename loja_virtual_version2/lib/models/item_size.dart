class ItemSize {
  // uso o fromMap quando usar um construtor receberá dados de um map.
  // uso o fromDocument quando o meu construtor receber informações de um document(classe)

  ItemSize({
    this.name,
    this.price,
    this.stock,
  });
  ItemSize.fromMap(Map<String, dynamic> map){
    this.name = map["name"] as String;
    this.price = map["price"] as num;
    this.stock = map["stock"] as int;
  }

  
  String name;
  num price; // valor quebrado or valor inteiro
  int stock;

  ItemSize clone(){
    return ItemSize(
      name: name,
      price: price,
      stock: stock,
    );
  }

  bool get hasStock => stock > 0;
  // @override
  // String toString() {
  //   return "ItemSize{name: $name, price: $price, stock: $stock}";
  // }

}