import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'crud.dart';

class ViewCoupons extends StatefulWidget {
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;

  ViewCoupons(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _ViewCouponsState createState() => _ViewCouponsState();
}

class _ViewCouponsState extends State<ViewCoupons> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String sdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  int prevbreak = 0;
  int prevlunch = 0;
  int prevdinn = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'View Coupons',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffdfcfa),
        child: FaIcon(
          FontAwesomeIcons.calendarAlt,
          color: Colors.black,
        ),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2040),
          ).then((date) {
            setState(() {
              sdate = DateFormat('dd-MM-yyyy').format(date);
            });
          });
        },
      ),
      body: Container(
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(widget._user.uid)
                .collection("Food Coupons")
                .document(sdate)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              } else if (snapshot.data.exists) {
                prevbreak = snapshot.data['Breakfast'];
                prevlunch = snapshot.data['Lunch'];
                prevdinn = snapshot.data['Dinner'];
                if (prevbreak == null)
                  setState(() {
                    prevbreak = 0;
                  });
                if (prevlunch == null)
                  setState(() {
                    prevlunch = 0;
                  });
                if (prevdinn == null)
                  setState(() {
                    prevdinn = 0;
                  });

                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        sdate,
                        style: TextStyle(fontSize: 24),
                      ),
                      Divider(
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Breakfast = ",
                            style: TextStyle(fontSize: 24),
                          ),
//                          SizedBox(
//                            width: MediaQuery.of(context).size.width * 0.5,
//                          ),
                          Text(
                            prevbreak.toString(),
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Lunch = ",
                            style: TextStyle(fontSize: 24),
                          ),
//                          SizedBox(
//                            width: MediaQuery.of(context).size.width * 0.5,
//                          ),
                          Text(
                            prevlunch.toString(),
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Dinner = ",
                            style: TextStyle(fontSize: 24),
                          ),
//                          SizedBox(
//                            width: MediaQuery.of(context).size.width * 0.5,
//                          ),
                          Text(
                            prevdinn.toString(),
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Container(
                child: Text("No coupons booked"),
              );
            }),
      ),
    );
  }
}
