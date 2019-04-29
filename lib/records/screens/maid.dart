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
      body: Container(
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [
                Colors.white,
                Color(0xfff20BDFF),
                //Color(0xff1034a6)
              ])),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 60, left: 60, bottom: 20),
                child: Text('Maid Account',
                    style:
                        TextStyle(color: Colors.white, fontSize: 40, shadows: [
                      Shadow(color: Colors.black, offset: Offset(-1.0, 2.0)),
                      Shadow(color: Colors.black, offset: Offset(-2.0, -2.0)),
                      Shadow(color: Colors.black, offset: Offset(1.0, -2.0))
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
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
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xfff20BDFF),
                ),
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                        image: AssetImage('assets/images/maid_leave.png'),
                        height: 30,
                        width: 30),
                    Text('Number of leaves: $x',
                        style: TextStyle(fontSize: 20)),
                    IconButton(
                      icon: Icon(Icons.add_box),
                      onPressed: () {
                        setState(() {
                          x++;
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xfff20BDFF),
                ),
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                        image: AssetImage('assets/images/bill.png'),
                        height: 30,
                        width: 30),
                    Text('Monthly bill: Rs. 2000',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
