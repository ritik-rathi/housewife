import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class RecDet {
  String record;
  RecDet({this.record});
}

List records = [
  new RecDet(record: 'Maid'),
  new RecDet(record: 'Milk'),
  new RecDet(record: 'Dhobi'),
  new RecDet(record: 'Maid 2'),
  new RecDet(record: 'Budget')
];

class RecCard extends StatelessWidget {
  final RecDet rec;
  RecCard({this.rec});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 60,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'maid');
        },
        child: GradientCard(
          gradient: LinearGradient(
              colors: [Colors.white, Color(0xff1034a6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          child: Center(
            child: Text(rec.record,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    ));
  }
}
