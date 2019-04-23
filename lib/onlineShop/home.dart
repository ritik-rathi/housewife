import 'package:flutter/material.dart';

class HomeShop extends StatefulWidget {
  @override
  _HomeShopState createState() => _HomeShopState();
}

int x = 0;

class _HomeShopState extends State<HomeShop> {
  int currentIndex = 0;
  List<Widget> tabs = [
    TabScreen(ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          elevation: 1.0,
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/orange.jpg'),
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  Text('Rs. 70'),
                  SizedBox(height: 5),
                  Text('Orange'),
                  SizedBox(height: 5),
                  Text('1 kg'),
                  SizedBox(width: 30),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[Icon(Icons.add), Text('ADD')],
                    ),
                  ),
                  Text('$x')
                ],
              )
            ],
          ),
        );
      },
    )),
    TabScreen(ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          elevation: 1.0,
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/fruits.png'),
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  Text('Rs. 70'),
                  SizedBox(height: 5),
                  Text('Orange'),
                  SizedBox(height: 5),
                  Text('1 kg'),
                  SizedBox(width: 30),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[Icon(Icons.add), Text('ADD')],
                    ),
                  ),
                  Text('$x')
                ],
              )
            ],
          ),
        );
      },
    )),
    TabScreen(ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          elevation: 1.0,
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/grocery.png'),
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: <Widget>[
                  Text('Rs. 70'),
                  SizedBox(height: 5),
                  Text('Orange'),
                  SizedBox(height: 5),
                  Text('1 kg'),
                  SizedBox(width: 30),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[Icon(Icons.add), Text('ADD')],
                    ),
                  ),
                  Text('$x')
                ],
              )
            ],
          ),
        );
      },
    ))
  ];
  _onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order now'),
        centerTitle: true,
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/fruits.png'),
                height: 30,
                width: 30,
              ),
              title: Text('Fruits')),
          BottomNavigationBarItem(
              icon: Image(
                height: 30,
                width: 30,
                image: AssetImage('assets/images/fruits.png'),
              ),
              title: Text('Vegetables')),
          BottomNavigationBarItem(
              icon: Image(
                height: 30,
                width: 30,
                image: AssetImage('assets/images/grocery.png'),
              ),
              title: Text('Grocery')),
        ],
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final Widget order;
  TabScreen(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: order,
    );
  }
}
