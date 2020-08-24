import 'package:flutter/material.dart';

Color color = Colors.orangeAccent;
List<String> fruitNames = [];
bool isChecked = false;
TextEditingController myController;
int x = 0;

class Fruits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruits'),
        backgroundColor: color,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'fruitList');
                    },
                    child: Text('Add fruits to the list'),
                    color: color,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Call vendor'),
                    color: color,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'onlineFruits');
                    },
                    child: Text('Order online'),
                    color: color,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}

class FruitList extends StatefulWidget {
  @override
  _FruitListState createState() => _FruitListState();
}

class _FruitListState extends State<FruitList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fruit list'),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        body: Column(children: [
          Flexible(
              child: ListView.builder(
            itemCount: fruitNames.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                    checkColor: color,
                    activeColor: Colors.white,
                  ),
                  Text(fruitNames[index])
                ],
              );
            },
          )),
          TextField(
            autofocus: true,
            controller: myController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.add, color: color),
                //contentPadding: EdgeInsets.only(left: 16),
                hintText: 'Enter fruit'),
            onSubmitted: (text) {
              if (text != null) fruitNames.add(text);
            },
          ),
        ]));
  }
}

class OnlineFruits extends StatefulWidget {
  @override
  _OnlineFruitsState createState() => _OnlineFruitsState();
}

class _OnlineFruitsState extends State<OnlineFruits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order fruits'),
        backgroundColor: color,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            elevation: 1.0,
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/orange.jpg'),
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
                      color: color,
                      onPressed: () {
                        setState(() {
                          x++;
                          Row(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    x--;
                                  });
                                },
                                child: Text('-'),
                              ),
                              Text('$x'),
                              RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    x++;
                                  });
                                },
                                child: Text('+'),
                              )
                            ],
                          );
                        });
                      },
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
      ),
    );
  }
}
