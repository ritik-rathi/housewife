import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

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
        return Container(
          height: 150,
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          width: double.infinity,
          child: Card(
              elevation: 2,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    left: 10,
                    bottom: 10,
                    child: Image(
                      image: AssetImage('assets/images/orange.jpg'),
                      // height: 100,
                      // width: 100,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 150,
                    child: GradientText('ORANGE',
                        gradient: Gradients.coldLinear,
                        style: TextStyle(fontSize: 15)),
                  ),
                  Positioned(
                    top: 35,
                    left: 150,
                    child: GradientText('Rs. 70',
                        gradient: Gradients.coldLinear,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                  Positioned(
                    top: 65,
                    left: 150,
                    child: GradientText('1 kg', gradient: Gradients.coldLinear, style: TextStyle(fontSize: 15),)
                  ),
                  Positioned(
                    top: 80,
                    right: 20,
                    child: GradientButton(
                      gradient: Gradients.coldLinear,
                      callback: () {
                        
                      },
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5,),
                          Icon(Icons.add),
                          SizedBox(
                            width: 10,
                          ),
                          Text('ADD')
                        ],
                      ),
                    ),
                  )
                ],
              )),
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
        title: Text('Order now', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),),
        backgroundColor: Color(0xfff20BDFF),
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
