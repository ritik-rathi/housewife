import 'package:flutter/material.dart';
import 'package:fun_app/records/screens/budget.dart';
import 'package:fun_app/splash_screens/splash_screens.dart';
import 'package:fun_app/todo_list/completed.dart';
import 'package:fun_app/todo_list/newtask.dart';
import 'package:fun_app/todo_list/todo_list.dart';
import 'help_screens/fruits.dart';
import 'login_new.dart';
import 'onlineShop/home.dart';
import 'records/records_list.dart';
import 'records/screens/maid.dart';
import 'records/screens/new_record.dart';

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
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomeShop(),
      // initialRoute: '.',
      routes: {
        '.': (context) => SplashScreens(),
        '/todo':(context)=> TodoList(),
        '/homeshop':(context)=>HomeShop(),
        '/records':(context)=> Records(),
        'home': (context) => FunApp(),
        'fruits': (context) => Fruits(),
        'fruitList': (context) => FruitList(),
        'onlineFruits': (context) => OnlineFruits(),
        'maid': (context) => Maid(),
        '/newTask':(context)=>NewTask(),
        '/completed':(context) => Completed(),
        '/addRecord': (context) => NewRecord()
      },
    );
  }
}

List<Color> color = [
  Colors.green,
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.yellow
];

class FunApp extends StatefulWidget {
  @override
  _FunAppState createState() => _FunAppState();
}

class _FunAppState extends State<FunApp> {
  final items = List<String>.generate(5, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Fun App'),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: Container(
            height: 65,
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Image(
                          image: AssetImage('assets/grocery.png'),
                          height: 40,
                          width: 30),
                      onPressed: () {},
                    ),
                    Text('GROCERY', style: TextStyle(color: color1))
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Image(
                          image: AssetImage('assets/maid.png'),
                          height: 40,
                          width: 30),
                      onPressed: () {},
                    ),
                    Text('MAID', style: TextStyle(color: color1))
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Image(
                          image: AssetImage('assets/milk.png'),
                          height: 40,
                          width: 30),
                      onPressed: () {},
                    ),
                    Text('MILK', style: TextStyle(color: color1))
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Image(
                          image: AssetImage('assets/fruits.png'),
                          height: 40,
                          width: 30),
                      onPressed: () {},
                    ),
                    Text('FRUITS', style: TextStyle(color: color1))
                  ],
                )
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text("Today's Tasks: "),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  // Specify the direction to swipe and delete
                  direction: DismissDirection.up,
                  key: Key(item),
                  onDismissed: (direction) {
                    // Removes that item the list on swipwe
                    setState(() {
                      items.removeAt(index);
                    });
                    // Shows the information on Snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("$item dismissed")));
                  },
                  background: Container(
                    color: Colors.red,
                    height: 50,
                    width: 100,      
                  ),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 200,
                    width: 150,
                    child: Card(
                      color: color[index],
                      elevation: 5,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text('Task $index'),
                      ),
                    ),
                  ),
                );
              },
            )),
          ]),
        ));
  }
}
