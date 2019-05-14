import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

String rs = '₹';

class _CartState extends State<Cart> {
  // int t = 0;
  @override
  void initState() {
    this.bill();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), backgroundColor: Color(0xff2A33C3)),
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('user/phone/cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data.documents.length >= 2) {
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length - 1,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData)
                          return Center(
                            child: Text('Your cart is empty'),
                          );
                        else {
                          return buildItem(
                              context, snapshot.data.documents[index + 1]);
                        }
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Your cart is empty'),
                    );
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Text('Total price:'),
                bill(),
                Spacer(),
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text('ORDER'),
                  backgroundColor: Color(0xff2A33C3),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bill() {
    int t = 0;
    int m = 0;
    print(t);
    int a = 0, b = 0;
    return StreamBuilder(
      stream: Firestore.instance.collection('user/phone/cart').snapshots(),
      builder: (context, snapshot) {
        for (int i = 1; i < snapshot.data.documents.length; i++) {
          a = snapshot.data.documents[i]['price'];
          b = snapshot.data.documents[i]['quantity'];
          t = t + (a * b);
        }
        m = t;
        t = 0;
        return Text('$m');
      },
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    String name = document['name'];
    int count = document['quantity'];
    var price = document['price'];
    String per = document['per'];
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.all(8),
        height: 150,
        child: Row(
          children: <Widget>[
            Container(
              child: Image.network(
                document['image'],
                fit: BoxFit.contain,
              ),
              height: 120,
              width: 120,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$rs$price$per',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(height: 10),
                Text(
                  document['name'],
                  style: TextStyle(fontSize: 17),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        if (count > 1) {
                          setState(() {
                            Firestore.instance
                                .collection('user/phone/cart')
                                .document(name)
                                .updateData({'quantity': count - 1});
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                      iconSize: 30,
                      color: Color(0xff2A33C3),
                    ),
                    Text(
                      '$count',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          Firestore.instance
                              .collection('user/phone/cart')
                              .document(name)
                              .updateData({'quantity': count + 1});
                        });
                      },
                      icon: Icon(Icons.add_circle_outline),
                      color: Color(0xff2A33C3),
                      iconSize: 30,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: IconButton(
                onPressed: () {
                  Firestore.instance
                      .collection('user/phone/cart')
                      .document(name)
                      .delete();
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text('$name removed'),
                  ));
                },
                icon: Icon(Icons.delete),
                color: Color(0xff2A33C3),
                iconSize: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
