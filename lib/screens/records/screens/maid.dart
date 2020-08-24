import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class Maid extends StatefulWidget {
  @override
  _MaidState createState() => _MaidState();
}

class _MaidState extends State<Maid> {
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,        
        centerTitle: true,
        title: Text('Maid Account',
            style: TextStyle(
              color: Colors.black, fontSize: 30,
              // shadows: [
              //   Shadow(color: Colors.black, offset: Offset(-1.0, 2.0)),
              //   Shadow(color: Colors.black, offset: Offset(-2.0, -2.0)),
              //   Shadow(color: Colors.black, offset: Offset(1.0, -2.0))
              // ]
            )),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child:
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         end: Alignment.topCenter,
            //         begin: Alignment.bottomCenter,
            //         colors: [
            //       Colors.white,
            //       Colors.black,
            //       //Color(0xff1034a6)
            //     ])),
            ListView(
          children: <Widget>[
            // Container(
            //   height: 150,
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           end: Alignment.centerLeft,
            //           begin: Alignment.centerRight,
            //           colors: [
            //         Colors.white,
            //         Colors.black,
            //         //Color(0xff1034a6)
            //       ])),
            //   child: Center(
            //     child: Text('Maid Account',
            //         style:
            //             TextStyle(color: Colors.white, fontSize: 40, shadows: [
            //           Shadow(color: Colors.black, offset: Offset(-1.0, 2.0)),
            //           Shadow(color: Colors.black, offset: Offset(-2.0, -2.0)),
            //           Shadow(color: Colors.black, offset: Offset(1.0, -2.0))
            //         ])),
            //   ),
            // ),
            SizedBox(height: 30),
            Card(
                elevation: 5,
                margin: EdgeInsets.only(left: 10, right: 10),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(5),
                        ),
                    child: CalendarCarousel(
                      width: double.infinity,
                      height: 400,
                      // markedDatesMap: EventList(events: <DateTime, List<dynamic>>{
                      //   new DateTime(2019, 3, 15): ["Party"]
                      // }),
                      markedDateShowIcon: false,
                      markedDateIconBorderColor: Colors.red,
                      todayButtonColor: Colors.blue,
                      todayBorderColor: Colors.black,
                      daysHaveCircularBorder: true,
                    ))),
            // Container(
            //   height: 60,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: Colors.black, width: 3),
            //     //color: Colors.black,
            //   ),
            //   margin: EdgeInsets.only(top: 20, left: 16, right: 16),
            //   child:
            SizedBox(height: 30),
            Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(width: 30),
                      Image(
                          image: AssetImage('assets/images/maid_leave.png'),
                          height: 30,
                          width: 30),
                      SizedBox(width: 20,),
                      Text('Number of leaves: $x',
                          style: TextStyle(
                              fontSize: 20, color: Colors.black)),
                      IconButton(
                        icon: Icon(Icons.add_box,
                            color: Colors.black, size: 35),
                        onPressed: () {
                          setState(() {
                            x++;
                          });
                        },
                      )
                    ],
                  ),
            SizedBox(height: 30),
            Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Image(
                        image: AssetImage('assets/images/bill.png'),
                        height: 30,
                        width: 30),
                    SizedBox(width: 20,),
                    Text('Monthly bill: Rs. 2000',
                        style:
                            TextStyle(fontSize: 20, color: Colors.black)),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
