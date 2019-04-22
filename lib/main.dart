import 'package:flutter/material.dart';
import 'package:fun_app/splash_screens/splash_screens.dart';
import 'login.dart';
import 'help_screens/fruits.dart';

Color color1 = Colors.blue[500];
Color color2 = Colors.blue[700];
Color color3 = Colors.blue[900]; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeMaker',
      debugShowCheckedModeBanner: false,
      home: SplashScreens(),
      // initialRoute: '.',
      routes: {
        '.': (context) => Login(),
        'home': (context) => FunApp(),
        'fruits': (context) => Fruits(),
        'fruitList': (context) => FruitList(),
        'onlineFruits': (context) => OnlineFruits()
      },
    );
  }
}

class FunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[ 
            ListTile(
              title: Text("Today's work"),
            ),
            ListTile(
              title: Text('Fruits'),
              onTap: () => Navigator.pushNamed(context, 'fruits'),
            ),
            ListTile(
              title: Text('Vegetables'),
            ),
            ListTile(
              title: Text('Maid'),
            ),
            ListTile(
              title: Text('Milkman'),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Fun App'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
                color: Colors.white,
                margin: EdgeInsets.only(left: 40, right: 40, top: 16),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('30th March, 2019'),
                      SizedBox(height: 10),
                      Text('Tasks -'),
                      SizedBox(height: 10),
                      Text('1. asdfg \n 2. fghjk \n 3. bgajdk'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.orangeAccent,
                            onPressed: () {},
                            child: Text('Add more'),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
