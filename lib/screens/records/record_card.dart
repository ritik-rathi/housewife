import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
        // decoration: BoxDecoration(
        //     border: Border.all(color: Color(0xfff20BDFF)),
        //     borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 20),
        height: 70,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'maid');
            },
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                Image(
                  image: AssetImage('assets/images/maid.png'),
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 20),
                Column(
                  children: <Widget>[
                    Text(rec.record, style: TextStyle(fontSize: 20)),
                    GestureDetector(
                      onTap: (){
                        launch("tel://9990637630");
                      },
                      child: Text('990090909', style: TextStyle(fontSize: 15, color: Colors.grey)),
                    )
                  ],
                ),
                SizedBox(width: 120),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 20,
                  onPressed: () => Navigator.pushNamed(context, 'maid'),
                ),
                Divider(
                  color: Colors.blue,
                )
              ],
            )),
            // Divider(
            //   color: Color(0xfff20BDFF),
            // )
          ],
        ));
  }
}
