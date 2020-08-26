import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:login/registeredusers.dart';

import 'crud.dart';
import 'imageDialog.dart';

class CustomCardCoursesDescription extends StatefulWidget {
  BuildContext c1;

  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCardCoursesDescription({@required this.title,
    @required this.description,
    //@required this.topic,
    @required BuildContext context,
    @required this.isAdmin1,
    @required this.edate,
    @required this.stime,
    @required this.url,
    @required this.type,
    @required this.venue,
    @required this.useremail,
    @required this.usercoursename,
    @required this.startdatetimestamp}) {
    c1 = context;
  }

  final title;
  final description;

  //final topic;
  final bool isAdmin1;
  final edate;
  final stime;
  final url;
  final type;
  final venue;
  final useremail;
  final usercoursename;
  final startdatetimestamp;

  @override
  _CustomCardCoursesDescriptionState createState() =>
      _CustomCardCoursesDescriptionState();
}

class _CustomCardCoursesDescriptionState
    extends State<CustomCardCoursesDescription> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool ispresent = false;

  @override
  void initState() {
    super.initState();
    checkIfLikedOrNot();
//        .then((dynamic data){
//      setState(() {
//        ispresent = data.ex;
//        print("data exists in initstate" + data.exists.toString());
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: FaIcon(Icons.arrow_back_ios),
                color: Colors.white,
                iconSize: 35,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      // backgroundColor: Colors.orangeAccent,
                    ),
                  ),
                ),
                background: GestureDetector(
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.fitHeight,
                  ),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) =>
                            ImageDialog(
                              url: widget.url,
                            ));
                  },
                ),
              ),
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 28),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Starts on: " + widget.stime,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.16,
                  ),
                  Text(
                    "Ends on: " + widget.edate,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  )
                ],
              ),
            ),
//            SizedBox(
//              height: 50,
//            ),
            Divider(
              thickness: 0.5,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: eventeVenue(),
            ),
            Divider(
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                widget.description,
                maxLines: null,
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 120),
              child: registration(),
            )
          ],
        ),
      ),
    );
  }

  Widget registration() {
    print("ispresent in registration data or not " + ispresent.toString());
    if (widget.isAdmin1 == true && ispresent == false) {
      return FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        elevation: 0.5,
        label: new Text(
          "Registered users",
          style: TextStyle(fontSize: 12),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisteredUsers(
                          usercoursename: widget.usercoursename,
                          useremail: widget.useremail,
                          description: widget.description)));
        },
      );
    } else if (widget.isAdmin1 != true && ispresent == false)
      return FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        elevation: 0.5,
        label: Text(
          "Register",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () async {
          await _showAlertDialog(widget.description);
        },
      );
    else
      return FloatingActionButton.extended(
        backgroundColor: Colors.grey,
        elevation: 0.5,
        label: Text(
          "Already Registered",
          style: TextStyle(fontSize: 10),
        ),
        onPressed: () async {
//            await _showAlertDialog(widget.description);
//            _scaffoldKey.currentState.showSnackBar(SnackBar(
//              content: Text("You have successfully Registered"),
//            ));
        },
      );
  }

  _showAlertDialog(String desc) async {
    showDialog<String>(
      context: widget.c1,
      builder: (BuildContext context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Register for the course?",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 40),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.red.shade400, fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            VerticalDivider(),
                            FlatButton(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 15),
                              ),
                              onPressed: () {
                                //Crud().deleteData(widget.desc);
                                Crud().addRegistrationData(widget.description,
                                    widget.useremail, widget.usercoursename);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "You have successfully Registered"),
                                ));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget eventeVenue() {
    if (widget.venue == "") {
      return FittedBox(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Online Event",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      );
    } else {
      return FittedBox(
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on, size: 18),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.venue,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      );
    }
  }

  checkIfLikedOrNot() async {
    DocumentReference ds = await Firestore.instance.collection("Courses")
        .document(widget.description).collection("Registration")
        .document(widget.useremail);
    Future<Null> snapshot = ds.get().then((DocumentSnapshot snapshot) {
      setState(() {
        ispresent = snapshot.data.containsValue(widget.useremail);
      });
    });
  }
//  dynamic data;
//
//  checkIfLikedOrNot() async {
//    final DocumentReference document = Firestore.instance
//        .collection('Courses')
//        .document(widget.description)
//          ..collection('Registration').document(widget.useremail);
//
//    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
//    });
//  }
}
