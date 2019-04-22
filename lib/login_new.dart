import 'package:flutter/material.dart';
import 'main.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

String _email, _name, _phone;

class LoginNew extends StatefulWidget {
  @override
  _LoginNewState createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {
  final GlobalKey<FormState> _newKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bck.jpg'), fit: BoxFit.cover)
            // gradient: LinearGradient(
            //     colors: [Colors.white, color3],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter),
            ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 250),
            Container(
              margin: EdgeInsets.all(20),
              height: 320,
              width: double.infinity,
              child: GradientCard(
                  gradient: Gradients.coldLinear,
                  // shape: BeveledRectangleBorder(
                  //     borderRadius: BorderRadius.circular(3)),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'LOGIN',
                          //shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Form(
                          key: _newKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                onSaved: (value) => _name = value,
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(color: Colors.white),
                                    ),
                                  ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                onSaved: (value) => _email = value,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                onSaved: (value) => _phone = value,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  border: new OutlineInputBorder(
                                    
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(height: 10),
            GradientButton(
              callback: () {},
              child: Text(
                'Send OTP',
              ),
              gradient: Gradients.coldLinear,
            )
          ],
        ),
      ),
    );
  }
}
