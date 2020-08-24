import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeShop extends StatefulWidget {
  @override
  _HomeShopState createState() => _HomeShopState();
}

String rs = '₹';

class _HomeShopState extends State<HomeShop> {
  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _generatorWidget({
          "fruits": Color(0xff9388FF),
          "vegetables": Color(0xff6B77E0),
          "grocery": Color(0xFF50CDFF)
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget itemCount(){
    int c = 0;
    return StreamBuilder(
      stream: Firestore.instance.collection('user/phone/cart').snapshots(),
      builder: (context, snapshot) {
        for (int i = 1; i < snapshot.data.documents.length; i++) {
          int b = snapshot.data.documents[i]['quantity'];
          c = c+ b;
        }
        int m = c;
        c = 0;
        return Text('$m', style: TextStyle(color: Colors.white));
      },
    );
  }

  // _tabChange(int index, bool isChange) {
  //   print("index:$index--isChange:$isChange");
  //   if (isChange) {
  //     _controller.jumpToPage(index);
  //     _currentIndex = index;
  //     print("_currentIndex:$_currentIndex");
  //     setState(() {});
  //   }
  // }

  List<Widget> _generatorWidget(Map<String, Color> map) {
    List<Widget> list = [];
    map.forEach((title, color) {
      list.add(Scaffold(
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
                  top: 10,
                  right: 10,
                  child: IconButton(
                    iconSize: 35,
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.account_balance_wallet),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pushNamed(context, '/wallet');
                    },
                  ),
                ),
                Positioned(
                  top: 13,
                  right: 20,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(140),
                        color: color),
                    child: Center(child: itemCount()),
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
            child: ecommCard(title),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: Image.asset('assets/images/offer.jpg', fit: BoxFit.cover),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          ),
        ]),
      ));
    });
    return list;
  }

  Widget ecommCard(String collection) {
    return prefix0.StreamBuilder(
        stream: Firestore.instance.collection(collection).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return Dismissible(
                  background: Container(
                    color: Colors.green,
                    child: Icon(Icons.add_shopping_cart  , color: Colors.white, size: 50.0,),
                  ),
                  onDismissed: (direction) {
                    Firestore.instance
                        .collection('user/phone/cart')
                        .document(snapshot.data.documents[index]['name'])
                        .setData({
                      "name": snapshot.data.documents[index]['name'],
                      'price': snapshot.data.documents[index]['price'],
                      'image': snapshot.data.documents[index]['image'],
                      'quantity': 1,
                      'per': snapshot.data.documents[index]['per']
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  direction: prefix0.DismissDirection.up,
                  key: new UniqueKey(),
                  child: Container(
                      margin: EdgeInsets.only(left: 5, right: 1),
                      width: 190,
                      height: 250,
                      child:
                          buildItem(context, snapshot.data.documents[index])),
                );
              },
            );
          }
        });
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    var price = document['price'].toString();
    String per = document['per'];
    return Card(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 3,
      child: Column(
        children: <Widget>[
          prefix0.Container(
            height: 150,
            padding: const EdgeInsets.only(top: 20),
            child: CachedNetworkImage(
              imageUrl: document['image'],
              fit: BoxFit.contain,
            )
          ),
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                document['name'],
                style: TextStyle(fontSize: 17),
              ),
              Text(
                '$rs$price$per',
                style: TextStyle(fontSize: 17),
              )
            ],
          )
        ],
      ),
    );
  }
}
