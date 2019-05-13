import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'addExpenses.dart';

final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

List<CircularStackEntry> data = <CircularStackEntry>[
  new CircularStackEntry(
    <CircularSegmentEntry>[
      new CircularSegmentEntry(500.0, Colors.red, rankKey: 'Q1'),
      new CircularSegmentEntry(1000.0, Colors.green, rankKey: 'Q2'),
      new CircularSegmentEntry(2000.0, Colors.blue, rankKey: 'Q3'),
      new CircularSegmentEntry(1000.0, Colors.yellow, rankKey: 'Q4'),
    ],
    rankKey: 'Quarterly Profits',
  ),
];
class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> with TickerProviderStateMixin {
  AnimationController _controller;
  TabController tabController;
  static const header_height = 400.0;  

  Animation<RelativeRect> getAniamtionPanel(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final top = height - header_height;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
      begin: RelativeRect.fromLTRB(20.0, top, 20.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 20.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void initState() {
    tabController = new TabController(vsync: this, length: 2);
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    // controller.forward();
    return Scaffold(
      body: new Container(
        child: new Stack(
          children: <Widget>[
            FirstPanel(),
            PositionedTransition(
              rect: getAniamtionPanel(constraints),
              child: new Material(
                elevation: 20,
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      height: 30.0,
                      child: new Center(
                          child: IconButton(
                        onPressed: () {
                          _controller.fling(
                              velocity: isPanelVisible ? -1.0 : 1.0);
                        },
                        icon: Icon(Icons.maximize),
                        iconSize: 40.0,
                        color: Color(0xFFAEA6C4),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(color: Colors.white),
                          child: TabBar(
                            controller: tabController,
                            indicatorColor: Color(0xff101285),
                            indicatorWeight: 3.0,
                            unselectedLabelColor: Color(0xffB6C4D3),
                            labelColor: Color(0xff101285),
                            labelStyle: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            tabs: <Widget>[
                              Tab(
                                text: 'Expenses',
                              ),
                              Tab(
                                text: 'Income',
                              )
                            ],
                          )),
                    ),
                    Container(
                      height: header_height,
                      child: TabBarView(controller: tabController, children: <
                          Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(child: _buildListOfTransactions(context)),
                            Container(
                              width: 300.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(color: Colors.white)),
                              child: RaisedButton(
                                color: Color(0xff599ACB),
                                child: Text('Add Expenses',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 3.0)),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddExpenses())),
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.blue,

                        )
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListOfTransactions(BuildContext context) {
    void chooseIconBasedOnColor(){}
    return StreamBuilder(
        stream: Firestore.instance.collection("user/phone/budget").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  int red = ds["color"]["r"];
                  int green = ds["color"]["g"];
                  int blue = ds["color"]["b"];
                  return Container(
                    height: 100.0,
                    width: double.infinity,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(red, green, blue, 1)),
                                child: Icon(
                                  Icons.ac_unit,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: 30.0,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  ds["title"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  ds["time"],
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15.0),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 60.0,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '\$${ds["amount"]}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w800),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });    
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}

class FirstPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // build budget and chart
          _buildTopRow()
          //build expense % thing
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Padding(
      padding: EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '\$1345',
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w600),
          ),
          AnimatedCircularChart(
            key: _chartKey,
            size: Size(120.0 , 120.0),
            initialChartData: data,
            chartType: CircularChartType.Radial,
          )
          // Container(
          //   width: 120.0,
          //   height: 120.0,
          //   decoration:
          //       BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          // )
        ],
      ),
    );
  }
}
