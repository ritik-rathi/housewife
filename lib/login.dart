import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

String _name, _email, _phone, _password, _smsCode, _verificationId, _message;

class Login extends StatefulWidget {
  final ScaffoldState scaffold;

  const Login({this.scaffold});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color1, color2, color3])),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100),
                  TextFormField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white)),
                    onSaved: (value) => _name = value,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value.isEmpty) return ('Enter valid email please!');
                    },
                    onSaved: (value) => _email = value,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(color: Colors.white)),
                    onSaved: (value) => _phone = value,
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    color: Colors.white,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      _verifyPhoneNumber();
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    color: Colors.white,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      _signInWithPhoneNumber();
                    },
                    child: Text('Sign in with phone number'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _message,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          )),
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

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      widget.scaffold.showSnackBar(SnackBar(
        content:
            const Text('Please check your phone for the verification code.'),
      ));
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
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

//   Future<void> phoneVer() async {
//     final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
//       _verificationId = verId;
//     };

//     final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
//       _verificationId = verId;
//       smsCodeDialog(context).then((value) {
//         print('Signed In');
//       });
//     };

//     final PhoneVerificationCompleted verifiedSucc = (FirebaseUser user) {
//       print('Verified');
//     };

//     final PhoneVerificationFailed verifiedFail = (AuthException e) {
//       print(e.message);
//     };

//     await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: _phone,
//         codeAutoRetrievalTimeout: autoRetrieve,
//         codeSent: smsCodeSent,
//         timeout: const Duration(seconds: 8),
//         verificationCompleted: verifiedSucc,
//         verificationFailed: verifiedFail);
//   }

//   Future<bool> smsCodeDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new AlertDialog(
//             title: Text('enter SMS code'),
//             content: TextField(
//               onChanged: (value) => _smsCode = value,
//             ),
//             contentPadding: EdgeInsets.all(10),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Done'),
//                 onPressed: () {
//                   FirebaseAuth.instance.currentUser().then((user) {
//                     if (user != null) {
//                       Navigator.of(context).pop();
//                       Navigator.pushReplacementNamed(context, 'home');
//                     } else {
//                       Navigator.of(context).pop();
//                       _signInWithPhoneNumber();
//                     }
//                   });
//                 },
//               )
//             ],
//           );
//         });
//   }

//   void _signInWithPhoneNumber() async {
//     final AuthCredential credential = PhoneAuthProvider.getCredential(
//       verificationId: _verificationId,
//       smsCode: _smsCode,
//     );
//     // final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
//     final FirebaseUser user =
//         await FirebaseAuth.instance.linkWithCredential(credential);
//     final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//     assert(user.uid == currentUser.uid);
//     setState(() {
//       if (user != null) {
//         Navigator.pushReplacementNamed(context, 'home');
//       } else {
//         return 'Sign in failed';
//       }
//     });
//   }

//   // String uid = '';
//   // void initState(){
//   //   this.uid = '';
//   //   FirebaseAuth.instance.currentUser().then((val){
//   //     setState(() {
//   //      this.uid = val.uid;
//   //     });
//   //   }).catchError((e){
//   //     print(e);
//   //   });
//   //   super.initState();
//   // }
// }
