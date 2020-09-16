class SectionItem {

  SectionItem.fromMap(Map<String, dynamic> map){
    this.image = map["image"] as String;
    this.product = map["product"]  as String;
  }

  String image;
  String product;

  @override

  String toString() {
    return 'Section{image: $image, product: $product}';
  }

}