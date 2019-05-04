import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fun_app/splash_screens/splash_screens.dart';
import 'main.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


String _email, _name, _phone, _message, _verificationId, _smsCode;

class LoginNew extends StatefulWidget {
  final ScaffoldState scaffold;

  const LoginNew({this.scaffold});
  @override
  _LoginNewState createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> with TickerProviderStateMixin {

  TextEditingController ph = new TextEditingController();

  final GlobalKey<FormState> _newKey = GlobalKey<FormState>();

  Future<void> _uploadData() async{
    
  }

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    // animation = Tween<double>(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
    //     parent: animationController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                                    borderSide:
                                        new BorderSide(color: Colors.white),
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
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: ph,
                                style: TextStyle(color: Colors.white),
                                onSaved: (value) => _phone = value,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    borderSide:
                                        new BorderSide(color: Colors.white),
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
              callback: () {
                // setState(() {
                //   animationController.forward();
                //   if (animationController.isAnimating) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => FadeTransition(
                //                   opacity: animationController,
                //                   child: SplashScreens(),
                //                 )));
                //   } else if (animationController.isCompleted) {
                //     setState(() {
                //       animationController.reset();
                //     });
                //   }
                // });
                _verifyPhoneNumber();
              },
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

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      setState(() {
        _message = 'signInWithPhoneNumber auto succeeded: $user';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
    };

    Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('enter SMS code'),
            content: TextField(
              onChanged: (value) => _smsCode = value,
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '.');
                    } else {
                      Navigator.of(context).pop();
                      _signInWithPhoneNumber();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      _verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed In');
      });
    };

    // final PhoneCodeSent codeSent =
    //     (String verificationId, [int forceResendingToken]) async {
    //   widget.scaffold.showSnackBar(SnackBar(
    //     content:
    //         const Text('Please check your phone for the verification code.'),
    //   ));
    //   _verificationId = verificationId;
    // };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${ph.text}",
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );
    final FirebaseUser user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
      } else {
        _message = 'Sign in failed';
      }
    });
  }
}
