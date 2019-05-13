import 'package:flutter/material.dart';

List<String> list = [];

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
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text(list[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: FloatingActionButton.extended(
              onPressed: (){},
              label: Text('ORDER'),
            ),
          )
        ],
      ),
    );
  }
}
