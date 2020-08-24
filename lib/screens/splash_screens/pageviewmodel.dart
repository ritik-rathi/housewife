import 'package:flutter/material.dart';

var pageList = [
  PageViewModel(
      // number: 0,
      imgPath: 'assets/images/todo.png',
      title: 'TODO',
      heroPath: 'Transition1',
      description: 'Manage your day the right way',
      gradients: gradients[0],
      screenPath: '/todo'),
  PageViewModel(
      title: 'Shopping',
      imgPath: 'assets/images/shopping.png',
      description: 'Shop your daily needs',
      heroPath: 'Transition2',
      gradients: gradients[1],
      screenPath: '/homeshop'),
  PageViewModel(
      imgPath: 'assets/images/bck.jpg',
      title: 'Manage',
      heroPath: 'Transition3',
      description: 'Keep track of everything',
      gradients: gradients[2],
      screenPath: '/records'),
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
  String screenPath;
  String heroPath;
  List<Color> gradients = [];

  PageViewModel(
      {this.number,
      this.title,
      this.description,
      this.heroPath,
      this.gradients,
      this.imgPath,
      this.screenPath});
}
