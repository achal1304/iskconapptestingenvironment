import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/crud.dart';
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
  AsyncSnapshot<DocumentSnapshot> snapshot1;
  dynamic data;
  bool prem = false;
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
                checkprem(coup.text);
              },
              text: "Verify",
              shape: GFButtonShape.pills,
              size: GFSize.LARGE,
            ),
          ],
        ),
      );
    } else
      return Text("Already registered");
  }

  checkprem(String premcoupon) {
    StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('PremiumCoupons')
            .document(premcoupon)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          } else if (snapshot.data.exists) {
            return Text("Coupon Code verified");
          }
          return Text("Wrong Coupon code");
        });
  }
}
