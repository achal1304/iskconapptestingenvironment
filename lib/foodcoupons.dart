import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FoodCoupon extends StatefulWidget {
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  final int initNumber;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;

  FoodCoupon(FirebaseUser user, GoogleSignIn signIn,
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback}) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _FoodCouponState createState() => _FoodCouponState();
}

class _FoodCouponState extends State<FoodCoupon> {
  int _currentCount = 0;
  int _currentCountDinn = 0;
  int _currentCountBrake = 0;
  int couponsavail = 24;

  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  dynamic data;

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
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
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
              height: MediaQuery.of(context).size.height * 0.02,
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
            Container(
              decoration: BoxDecoration(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Avialable coupon  :" + couponsavail.toString(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("lunch Copoun")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _createIncrementDicrementButton(
                            Icons.remove, () => _dicrement()),
                        Text(_currentCount.toString()),
                        _createIncrementDicrementButton(
                            Icons.add, () => _increment()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Diner Coupon")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _createIncrementDicrementButton(
                            Icons.remove, () => _dicrementDin()),
                        Text(_currentCountDinn.toString()),
                        _createIncrementDicrementButton(
                            Icons.add, () => _incrementDin()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Brakefast Copoun")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _createIncrementDicrementButton(
                            Icons.remove, () => _dicrementBra()),
                        Text(_currentCountBrake.toString()),
                        _createIncrementDicrementButton(
                            Icons.add, () => _incrementBra()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _increment() {
    setState(() {
      _currentCount++;
      couponsavail--;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 0) {
        _currentCount--;
        couponsavail++;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  void _incrementDin() {
    setState(() {
      _currentCountDinn++;
      couponsavail--;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrementDin() {
    setState(() {
      if (_currentCountDinn > 0) {
        _currentCountDinn--;
        couponsavail++;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  void _incrementBra() {
    setState(() {
      _currentCountBrake++;
      couponsavail--;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrementBra() {
    setState(() {
      if (_currentCountBrake > 0) {
        _currentCountBrake--;
        couponsavail++;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }
  //void coupon() {
  //setState(() {});
  //}

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.deepOrangeAccent,
      child: Icon(
        icon,
        color: Colors.black,
        size: 12.0,
      ),
      shape: CircleBorder(),
    );
  }
}
