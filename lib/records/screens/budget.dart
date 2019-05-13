import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> with TickerProviderStateMixin {
  AnimationController _controller;
  TabController tabController;
  static const header_height = 300.0;

  Animation<RelativeRect> getAniamtionPanel(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final top = height - header_height;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, top, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 20.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void initState() {
    tabController = new TabController(vsync: this , length: 2);
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
                          // indicatorPadding: EdgeInsets.only(bottom: 100.0),
                          labelColor: Color(0xff101285),
                          labelStyle: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.w500),
                          tabs: <Widget>[
                            Tab(
                              text: 'Expenses',
                            ),
                            Tab(text: 'Income',)
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: _buildListOfTransactions,
                        itemCount: 7,
                      ),
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

  Widget _buildListOfTransactions(BuildContext context, int index) {
    return Container(
      height: 100.0,
      width: double.infinity,
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        margin: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.ac_unit),
            SizedBox(
              width: 50.0,
            ),
            Column(
              children: <Widget>[
                Text('Electricity'),
                Divider(
                  color: Colors.yellow,
                  height: 3.0,
                ),
                Text('\$625')
              ],
            )
          ],
        ),
      ),
    );
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
      padding: EdgeInsets.only(top: 50.0, right: 15.0 , left: 15.0),
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
          // _pieChart()
          Container(
            width: 60.0,
            height: 60.0,
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
