import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class HomeShop extends StatefulWidget {
  @override
  _HomeShopState createState() => _HomeShopState();
}

class _HomeShopState extends State<HomeShop> {
  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  // List<Widget> tabs = [
  //   TabScreen(ListView.builder(
  //     itemBuilder: (context, index) {
  //       return Container(
  //         height: 150,
  //         margin: EdgeInsets.only(left: 16, right: 16, top: 8),
  //         width: double.infinity,
  //         child: Card(
  //             elevation: 2,
  //             child: Stack(
  //               children: <Widget>[
  //                 Positioned(
  //                   top: 10,
  //                   left: 10,
  //                   bottom: 10,
  //                   child: Image(
  //                     image: AssetImage('assets/images/orange.jpg'),
  //                     // height: 100,
  //                     // width: 100,
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 10,
  //                   left: 150,
  //                   child: GradientText('ORANGE',
  //                       gradient: Gradients.coldLinear,
  //                       style: TextStyle(fontSize: 15)),
  //                 ),
  //                 Positioned(
  //                   top: 35,
  //                   left: 150,
  //                   child: GradientText('Rs. 70',
  //                       gradient: Gradients.coldLinear,
  //                       style: TextStyle(
  //                           fontSize: 20, fontWeight: FontWeight.w500)),
  //                 ),
  //                 Positioned(
  //                     top: 65,
  //                     left: 150,
  //                     child: GradientText(
  //                       '1 kg',
  //                       gradient: Gradients.coldLinear,
  //                       style: TextStyle(fontSize: 15),
  //                     )),
  //                 Positioned(
  //                   top: 80,
  //                   right: 20,
  //                   child: GradientButton(
  //                     gradient: Gradients.coldLinear,
  //                     callback: () {},
  //                     child: Row(
  //                       children: <Widget>[
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         Icon(Icons.add),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Text('ADD')
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             )),
  //       );
  //     },
  //   )),
  //   TabScreen(ListView.builder(
  //     itemBuilder: (context, index) {
  //       return Card(
  //         margin: EdgeInsets.only(left: 16, right: 16, top: 8),
  //         elevation: 1.0,
  //         child: Row(
  //           children: <Widget>[
  //             Image(
  //               image: AssetImage('assets/images/fruits.png'),
  //               height: 100,
  //               width: 100,
  //             ),
  //             SizedBox(
  //               width: 50,
  //             ),
  //             Column(
  //               children: <Widget>[
  //                 Text('Rs. 70'),
  //                 SizedBox(height: 5),
  //                 Text('Orange'),
  //                 SizedBox(height: 5),
  //                 Text('1 kg'),
  //                 SizedBox(width: 30),
  //                 RaisedButton(
  //                   color: Colors.blue,
  //                   onPressed: () {},
  //                   child: Row(
  //                     children: <Widget>[Icon(Icons.add), Text('ADD')],
  //                   ),
  //                 ),
  //                 Text('$x')
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   )),
  //   TabScreen(ListView.builder(
  //     itemBuilder: (context, index) {
  //       return Card(
  //         margin: EdgeInsets.only(left: 16, right: 16, top: 8),
  //         elevation: 1.0,
  //         child: Row(
  //           children: <Widget>[
  //             Image(
  //               image: AssetImage('assets/images/grocery.png'),
  //               height: 100,
  //               width: 100,
  //             ),
  //             SizedBox(
  //               width: 50,
  //             ),
  //             Column(
  //               children: <Widget>[
  //                 Text('Rs. 70'),
  //                 SizedBox(height: 5),
  //                 Text('Orange'),
  //                 SizedBox(height: 5),
  //                 Text('1 kg'),
  //                 SizedBox(width: 30),
  //                 RaisedButton(
  //                   color: Colors.blue,
  //                   onPressed: () {},
  //                   child: Row(
  //                     children: <Widget>[Icon(Icons.add), Text('ADD')],
  //                   ),
  //                 ),
  //                 Text('$x')
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   ))
  // ];
  // _onTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Order now',
      //     style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
      //   ),
      //   backgroundColor: Color(0xfff20BDFF),
      //   centerTitle: true,
      // ),
      body: PageView(
        controller: _controller,
        children: _generatorWidget({
          "Fruits": Colors.pink,
          "Vegetables": Colors.green[400],
          "Grocery": Colors.yellow[300]
        }),
      ),
      // bottomNavigationBar: NavigationBar(
      //   tabchange: _tabChange,
      //   items: [
      //     BottomNaviItem(title: 'Fruits', color: Colors.pink, icon: Icons.home),
      //     BottomNaviItem(
      //         title: 'Vegetables', color: Colors.green[400], icon: Icons.home),
      //     BottomNaviItem(
      //         title: 'Grocery', color: Colors.yellow[300], icon: Icons.home)
      //   ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _onTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Image(
      //           image: AssetImage('assets/images/fruits.png'),
      //           height: 30,
      //           width: 30,
      //         ),
      //         title: Text('Fruits')),
      //     BottomNavigationBarItem(
      //         icon: Image(
      //           height: 30,
      //           width: 30,
      //           image: AssetImage('assets/images/fruits.png'),
      //         ),
      //         title: Text('Vegetables')),
      //     BottomNavigationBarItem(
      //         icon: Image(
      //           height: 30,
      //           width: 30,
      //           image: AssetImage('assets/images/grocery.png'),
      //         ),
      //         title: Text('Grocery')),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _tabChange(int index, bool isChange) {
    print("index:$index--isChange:$isChange");
    if (isChange) {
      _controller.jumpToPage(index);
      _currentIndex = index;
      print("_currentIndex:$_currentIndex");
      setState(() {});
    }
  }

  List<Widget> _generatorWidget(Map<String, Color> map) {
    List<Widget> list = [];
    map.forEach((title, color) {
      list.add(Scaffold(
        // appBar: AppBar(
        //   title: Text(title),
        //   backgroundColor: color,
        // ),
        body: ListView(children: <Widget>[
          Container(
            height: 160.0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: color,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 80.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: color,
                            ),
                            onPressed: () {},
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: "Search",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: color,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: color,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: Image.asset('assets/images/offer.jpg', fit: BoxFit.cover),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 250,
            child: ecommCard(),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: Image.asset('assets/images/offer.jpg', fit: BoxFit.cover),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
        ]),

        // Container(
        //   //margin: EdgeInsets.all(8),
        //   child: ListView(
        //     children: <Widget>[

        //     ],
        //   ),
        // )
        // Container(
        //   margin: EdgeInsets.all(8),
        //   child: ListView(
        //     scrollDirection: Axis.vertical,
        //     children: <Widget>[
        //       Container(
        //         height: 300,
        //         decoration:
        //             BoxDecoration(border: Border.all(color: Colors.black)),
        //       ),
        //       Container(
        //         child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: 5,
        //           itemBuilder: (context, index) {
        //             return ecommCard();
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ));
    });
    return list;
  }

  Widget ecommCard() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: prefix0.DismissDirection.up,
          key: new UniqueKey(),
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 1),
            width: 190,
            height: 250,
            child: Card(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 3,
              child: Column(
                children: <Widget>[
                  prefix0.Container(
                    height: 150,
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'assets/images/orange.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Orange',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        'Rs. 70/kg',
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class TabScreen extends StatelessWidget {
//   final Widget order;
//   TabScreen(this.order);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: order,
//     );
//   }
// }
