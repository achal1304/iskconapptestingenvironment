import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/crud.dart';
import 'package:login/homeS.dart';
import 'package:login/normalusers.dart';
import 'package:login/signupeditprofile.dart';
import 'package:random_color/random_color.dart';

import 'adminpage.dart';

class PremiumCode extends StatefulWidget {
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;

  PremiumCode(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _PremiumCodeState createState() => _PremiumCodeState();
}

class _PremiumCodeState extends State<PremiumCode> {
  StreamSubscription<DocumentSnapshot> subscription;

  AsyncSnapshot<DocumentSnapshot> snapshot1;
  dynamic data;
  bool prem = false;
  bool pcheck = false;
  String couppp = "";
  TextEditingController coup = TextEditingController();

  void addOnStart(dynamic data, bool prem) {
    //if (data == true)
    Crud().storeData1(widget._user, data, prem);
    // else
    //   Crud().storeData(widget._user);
  }

  Future<dynamic> getUserProgress() async {
    final DocumentReference document =
        Firestore.instance.collection("users").document(widget._user.uid);

    await document.get().then<dynamic>((DocumentSnapshot snapshot1) async {
      setState(() {
        data = snapshot1.data['admin'];
        prem = snapshot1.data['premium'];
      });
    });
  }

  @override
  void initState() {
    addOnStart(data, prem);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor1 = RandomColor();
    Color _color1 = _randomColor1.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.multiple(colorHues: <ColorHue>[ColorHue.blue]));

    MyColor _myColor1 = getColorNameFromColor(_color1);
    print(_myColor1.getName);

    RandomColor _randomColor2 = RandomColor();
    Color _color2 = _randomColor2.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.multiple(colorHues: <ColorHue>[ColorHue.red]));
    MyColor _myColor2 = getColorNameFromColor(_color2);
    print(_myColor2.getName);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: /*[Colors.orange.shade300, Colors.orange.shade800]*/ [
            _color1,
            _color2
          ],
        ),
      ),
      child: showthis(),
    );
  }

  Widget showthis() {
    return new Scaffold(
      body: StatefulBuilder(builder: (context, setState) {
        if (prem == false) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: coup,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.person),
                    hintText: "Please Enter Coupon code",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 32.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                GFButton(
                  onPressed: () {
                    setState(() {
                      couppp = coup.text;
                    });
                    checkprem(couppp);
                    addOnStart(data, pcheck);
                    if(pcheck == true){
                      Timer(Duration(seconds: 1), () {
                        // 5s over, navigate to a new page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageS(
                              widget._user,
                              widget._googleSignIn,
                            ),
                          ),
                        );
                      });
                    }
                  },
                  text: "Verify",
                  shape: GFButtonShape.pills,
                  size: GFSize.LARGE,
                ),
                couponcheck(),
              ],
            ),
          );
        } else {
          return Text("Already registered");
        }
      }),
    );
  }

  Widget couponcheck() {
    if (pcheck == true) {
      return Text("Coupon Verified");
    } else
      return Text("Please enter a valid coupon code");
  }

  checkprem(String premcoupon) {
    final DocumentReference documentReference =
        Firestore.instance.collection('PremiumCoupons').document(premcoupon);
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          pcheck = true;
        });
      } else if (!datasnapshot.exists) {
        setState(() {
          pcheck = false;
        });
      }
    });
//    StreamBuilder<DocumentSnapshot>(
//        stream: Firestore.instance
//            .collection('PremiumCoupons')
//            .document(premcoupon)
//            .snapshots(),
//        builder:
//            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//          print("snapshot has value *******" + snapshot.data.toString());
//          if (snapshot.hasError) {
//            return Text('Error : ${snapshot.error}');
//          } else if (snapshot.data.exists) {
//            print(
//                "Visited here************************************************");
//            pcheck = true;
//            setState(() {
//              pcheck = true;
//            });
//          }
//          return Text("Wrong Coupon code");
//        });
  }
}
