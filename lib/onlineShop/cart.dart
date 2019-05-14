import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('user/phone/cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  // if ((snapshot.data.documents[0]['name'] == null) ||
                  //     (snapshot.data.documents[0]['price'] == null) ||
                  //     (snapshot.data.documents[0]['image']) == null ||
                  //         (snapshot.data.documents.length < 2)) {
                  //   return Center(
                  //     child: Text('Your cart is empty'),
                  //   );
                  // }
if (snapshot.data.documents.length >= 2)
                   { 
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length-1,
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData)
                        return Center(
                          child: Text('Your cart is empty'),
                        );
                        else{
                      return buildItem(context, snapshot.data.documents[index+1]);}
                    },
                  );
                }
                else{
                   return Center(
                      child: Text('Your cart is empty'),
                    );

                }
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text('ORDER'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    String name = document['name'];
    int count = document['quantity'];
    return Card(
      margin: EdgeInsets.all(8),
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
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                document['name'],
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.clip,
              ),
              Text(document['price'], style: TextStyle(fontSize: 20), overflow: TextOverflow.clip,)
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Qty: $count'),
              IconButton(
                onPressed: () {
                  setState(() {
                    Firestore.instance
                        .collection('user/phone/cart')
                        .document(name)
                        .updateData({'quantity': count + 1});
                  });
                },
                icon: Icon(Icons.add),
              ),
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
                icon: Icon(Icons.minimize),
              )
            ],
          ),
          IconButton(
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
            iconSize: 40,
          )
        ],
      ),
    );
  }
}
