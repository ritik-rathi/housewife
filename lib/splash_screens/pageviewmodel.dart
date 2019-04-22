import 'package:flutter/material.dart';

var pageList = [
  PageViewModel(
      // number: 0,
      imgPath: 'assets/images/todo.png',
      title: 'TODO',
      description: 'Manage your day the right way',
      gradients: gradients[0]),
  PageViewModel(
      title: 'Shopping',
      imgPath: 'assets/images/shopping.png',
      description: 'Shop your daily needs',
      gradients: gradients[1]),
  PageViewModel(
      title: 'Records',
      imgPath: 'asssts/images/management.png',
      description: 'Keep track of anything and everything',
      gradients: gradients[2])
];

List<List<Color>> gradients = [
  [Colors.pink[100], Colors.pink[300], Colors.pink[700]],
  [Colors.green[200], Colors.greenAccent[400], Colors.green[700]],
  [Colors.amber[100], Colors.amber[400], Colors.amber[700]]
];

class PageViewModel {
  int number;
  String title;
  String description;
  String imgPath;
  List<Color> gradients = [];

  PageViewModel(
      {this.number,
      this.title,
      this.description,
      this.gradients,
      this.imgPath});
}
