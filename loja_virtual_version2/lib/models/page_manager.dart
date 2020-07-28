import 'package:flutter/cupertino.dart';

class PageManager {

  PageManager(this._pageController);
  final PageController _pageController;
  int page = 0;         // page que estou, inicialmente é configurando como 0 = Home
  void setPage(int value){
    if (value == page) return null;
    page = value;
    _pageController.jumpToPage(value);
  }

}