import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        centerTitle: true,
        backgroundColor: Color(0xff2A33C3)
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('₹ 600', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            Divider(),
            Text('Transactions', style: TextStyle(fontSize: 35)),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 3,
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('400', style: TextStyle(fontSize: 20)),
                          Text('to', style: TextStyle(fontSize: 20)),
                          Text('Kanta Ben', style: TextStyle(fontSize: 20)) 
                        ],
                      ),
                    ),  
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}