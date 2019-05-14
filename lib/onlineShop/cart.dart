import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';



class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

int count = 1;

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
                stream: Firestore.instance.collection('cart').snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData) return const Text('Cart is empty');
                      return buildItem(context, snapshot.data.documents[index]);
                    },
                  );
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
    return Card(
      margin: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.network(
              document['image'],
              fit: BoxFit.contain,
            ),
            height: 150,
            width: 150,
          ),
          SizedBox(width: 10),
          Column(
            children: <Widget>[
              Text(
                document['name'],
                style: TextStyle(fontSize: 20),
              ),
              Text(document['price'], style: TextStyle(fontSize: 20))
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: <Widget>[
              Text('Qty: $count'),
              IconButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: (){
                  if(count > 1){
                    setState(() {
                     count --; 
                    });
                  }
                },
                icon: Icon(Icons.minimize),
              )
            ],
          )
        ],
      ),
    );
  }
}
