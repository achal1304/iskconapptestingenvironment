import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FoodCoupon extends StatefulWidget {
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;

  FoodCoupon(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _FoodCouponState createState() => _FoodCouponState();
}

class _FoodCouponState extends State<FoodCoupon> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic data;
  int couponsavail = 0;

  Future<dynamic> getUserProgress() async {
    final DocumentReference document =
        Firestore.instance.collection("users").document(widget._user.uid);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data;
      });
    });
  }

  void initState() {
    getUserProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    couponsavail = data['FoodCoupons'];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Book Coupons',
          style: TextStyle(color: Colors.black),
          textScaleFactor: 1.2,
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: FaIcon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            ),
            Text(
              "Coupons Available : " + couponsavail.toString(),
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 24,
                  color: Colors.black54),
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
