import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:login/registeredusers.dart';

import 'coursepayment.dart';
import 'crud.dart';
import 'imageDialog.dart';

class CustomCardCoursesDescription extends StatefulWidget {
  BuildContext c1;

  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCardCoursesDescription(
      {@required this.title,
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
      @required this.startdatetimestamp,
      @required this.registrationform,
      @required this.payamount}) {
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
  final registrationform;
  final int payamount;

  @override
  _CustomCardCoursesDescriptionState createState() =>
      _CustomCardCoursesDescriptionState();
}

class _CustomCardCoursesDescriptionState
    extends State<CustomCardCoursesDescription> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController mailid = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController contact2 = TextEditingController();
  TextEditingController mailid2 = TextEditingController();
  TextEditingController name3 = TextEditingController();
  TextEditingController address3 = TextEditingController();
  TextEditingController contact3 = TextEditingController();
  TextEditingController mailid3 = TextEditingController();
  TextEditingController name4 = TextEditingController();
  TextEditingController address4 = TextEditingController();
  TextEditingController contact4 = TextEditingController();
  TextEditingController mailid4 = TextEditingController();
  TextEditingController na = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String result = "";
  bool ispresent = false;
  String cname = "";
  String caddress = "";
  String ccontact = "";
  int participants = 1;
  int amount;
  int totalamount;
  String _selectedparticipants;
  String paymentstaus = "";
  List<String> _particip = ["1", "2", "3", "4"];

//  List<TextEditingController> name =
//      List.generate(3, (i) => TextEditingController());
//  List<TextEditingController> address =
//      List.generate(3, (i) => TextEditingController());
//  List<TextEditingController> contact =
//      List.generate(3, (i) => TextEditingController());
//  List<TextEditingController> mailid =
//      List.generate(3, (i) => TextEditingController());
  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  void initState() {
    _selectedparticipants = "1";
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
                        builder: (_) => ImageDialog(
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
                    width: MediaQuery.of(context).size.width * 0.16,
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: paidcourse(),
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
                  builder: (context) => RegisteredUsers(
                        usercoursename: widget.usercoursename,
                        useremail: widget.useremail,
                        description: widget.description,
                      )));
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
    List<dynamic> arr = widget.registrationform;
    showDialog<String>(
        context: widget.c1,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  content: SingleChildScrollView(
                    child: Container(
//                  height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Select Participants"),
                                DropdownButton(
                                  // Not necessary for Option 1
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedparticipants = newValue;
                                    });
                                  },
                                  value: _selectedparticipants,
                                  items: _particip.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(location),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                                _participant(_selectedparticipants, arr),
//                            _buildchild(arr,name,address,contact,mailid),
                                paymentstatus(),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Text(
                                  "Register for Course",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 40),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 15),
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
                                      onPressed: () async {
                                        setState(() {
                                          cname = name.text;
                                          caddress = address.text;
                                          ccontact = contact.text;
                                        });
                                        await _updateRegisteredUser();
//                                        if (_formKey.currentState.validate() &&
//                                            result ==
//                                                "UpiTransactionStatus.Success") {
//                                          await _storedData(
//                                              _selectedparticipants);
//                                          _scaffoldKey.currentState
//                                              .showSnackBar(
//                                            SnackBar(
//                                              content:
//                                                  Text('You have registered!'),
//                                              duration: Duration(seconds: 3),
//                                            ),
//                                          );
//                                          Navigator.pop(context);
//                                        }
//                                        if (_formKey.currentState.validate() &&
//                                            result == "") {
//                                          _scaffoldKey.currentState
//                                              .showSnackBar(
//                                            SnackBar(
//                                              content: Text(
//                                                  'Please complete payment'),
//                                              duration: Duration(seconds: 3),
//                                            ),
//                                          );
//                                        }

//                            Crud().addRegistrationData(widget.description,
//                                widget.useremail, widget.usercoursename);
//                            _scaffoldKey.currentState.showSnackBar(SnackBar(
//                              content: Text("You have successfully Registered"),
//                            ));
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
                  ));
            }));
  }

  Widget paidcourse() {
    if (widget.payamount == 0) {
      return Text("Free Course");
    } else
      return Text("Course Fees : Rs." +
          widget.payamount.toString() +
          " per participant");
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
    DocumentReference ds = await Firestore.instance
        .collection("Courses")
        .document(widget.description)
        .collection("Registration")
        .document(widget.useremail);
    Future<Null> snapshot = ds.get().then((DocumentSnapshot snapshot) {
      setState(() {
        ispresent = snapshot.data.containsValue(widget.useremail);
      });
    });
  }

  _updateRegisteredUser() async {
    if (widget.payamount == 0) {
      if (_formKey.currentState.validate()) {
        await _storedData(_selectedparticipants);
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('You have registered!'),
            duration: Duration(seconds: 3),
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          _scaffoldKey.currentState.hideCurrentSnackBar();
        });
        Navigator.pop(context);
      }
    } else {
      if (_formKey.currentState.validate() &&
          result == "UpiTransactionStatus.success") {
        await _storedData(_selectedparticipants);
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('You have registered!!'),
            duration: Duration(seconds: 3),
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          _scaffoldKey.currentState.hideCurrentSnackBar();
        });
        Navigator.pop(context);
      }
      if (_formKey.currentState.validate() && result == "") {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Please complete payment'),
            duration: Duration(seconds: 3),
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          _scaffoldKey.currentState.hideCurrentSnackBar();
        });
      }
    }
  }

  Widget paymentstatus() {
    if (widget.payamount == 0)
      return Container(
        height: 0.0,
        width: 0.0,
      );
    else
      return FlatButton(
        color: Colors.blueAccent,
        child: Text(
          "Complete Payment",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          int totamount = calculatepayment(_selectedparticipants);
          _navigateAndDisplayStatus(totamount);
        },
      );
  }

  int calculatepayment(String pp) {
    amount = int.parse(pp);
    totalamount = amount * widget.payamount;
    return totalamount;
  }

  _navigateAndDisplayStatus(int t_amount) async {
    result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseFees(totalamount: t_amount),
      ),
    );
    if (result == "UpiTransactionStatus.success") {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Payment successful!"),
        duration: Duration(seconds: 2),
      ));
      Future.delayed(Duration(seconds: 2), () {
        _scaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
    if (result == "UpiTransactionStatus.submitted") {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Payment submitted!"),
        duration: Duration(seconds: 2),
      ));
      Future.delayed(Duration(seconds: 2), () {
        _scaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
    if (result == "UpiTransactionStatus.failure") {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Payment Failed.Retry!"),
        duration: Duration(seconds: 2),
      ));
      Future.delayed(Duration(seconds: 2), () {
        _scaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
  }

  Widget _participant(String _sp, List<dynamic> arr) {
    return Container(
      child: Column(
        children: <Widget>[
          if (_sp == "1") _buildchild(arr, name, address, contact, mailid, _sp),
          if (_sp == "2")
            Column(
              children: <Widget>[
                _buildchild(arr, name, address, contact, mailid, "1"),
                _buildchild(arr, name2, address2, contact2, mailid2, "2"),
//                  _buildchild(arr, name2, address2, contact2, mailid2, _sp),
              ],
            ),
          if (_sp == "3")
            Column(
              children: <Widget>[
                _buildchild(arr, name, address, contact, mailid, "1"),
                _buildchild(arr, name2, address2, contact2, mailid2, "2"),
                _buildchild(arr, name3, address3, contact3, mailid3, "3"),
//                  _buildchild(arr, name2, address2, contact2, mailid2, _sp),
              ],
            ),
          if (_sp == "4")
            Column(
              children: <Widget>[
                _buildchild(arr, name, address, contact, mailid, "1"),
                _buildchild(arr, name2, address2, contact2, mailid2, "2"),
                _buildchild(arr, name3, address3, contact3, mailid3, "3"),
                _buildchild(arr, name4, address4, contact4, mailid4, "4"),
//                  _buildchild(arr, name2, address2, contact2, mailid2, _sp),
              ],
            )
          else
            Container(
              height: 0.0,
              width: 0.0,
            )
        ],
      ),
    );
  }

  _storedData(String _selectedp) async {
    if (_selectedp == "1") {
      await Crud().addRegistrationData(widget.description, widget.useremail,
          address.text, contact.text, name.text);
    }
    if (_selectedp == "2") {
      await Crud().addRegistrationData(widget.description, widget.useremail,
          address.text, contact.text, name.text);
      await Crud().addRegistrationData(widget.description, mailid2.text,
          address2.text, contact2.text, name2.text);
    }
    if (_selectedp == "3") {
      await Crud().addRegistrationData(widget.description, widget.useremail,
          address.text, contact.text, name.text);
      await Crud().addRegistrationData(widget.description, mailid2.text,
          address2.text, contact2.text, name2.text);
      await Crud().addRegistrationData(widget.description, mailid3.text,
          address3.text, contact3.text, name3.text);
    }
    if (_selectedp == "4") {
      await Crud().addRegistrationData(widget.description, widget.useremail,
          address.text, contact.text, name.text);
      await Crud().addRegistrationData(widget.description, mailid2.text,
          address2.text, contact2.text, name2.text);
      await Crud().addRegistrationData(widget.description, mailid3.text,
          address3.text, contact3.text, name3.text);
      await Crud().addRegistrationData(widget.description, mailid4.text,
          address4.text, contact4.text, name4.text);
    }
  }

  Widget _buildchild(
      List<dynamic> arr,
      TextEditingController name,
      TextEditingController address,
      TextEditingController contact,
      TextEditingController mailid,
      String _sp) {
    return Container(
        child: Column(
      children: <Widget>[
        Text("Participant :" + _sp),
        if (_sp != "1")
          TextFormField(
            controller: mailid,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail_outline),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                  borderRadius: BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            validator: (mailid) {
              if (!emailRegex.hasMatch(mailid)) {
                return 'Please enter valid Email';
              }
              return null;
            },
          ),
        SizedBox(
          height: 5.0,
        ),
        if (arr.contains("Name"))
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Name",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                  borderRadius: BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            validator: (name) {
              if (name.isEmpty) {
                return 'Please enter Name';
              }
              return null;
            },
          ),
        SizedBox(
          height: 5.0,
        ),
        if (arr.contains("Address"))
          TextFormField(
            controller: address,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.my_location),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Address",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                  borderRadius: BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            validator: (address) {
              if (address.isEmpty) {
                return 'Please enter Address';
              }
              return null;
            },
          ),
        SizedBox(
          height: 5.0,
        ),
        if (arr.contains("Contact No."))
          TextFormField(
            controller: contact,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.contact_phone),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Contact No",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                  borderRadius: BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 32.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            validator: (address) {
              if (address.length != 10) {
                return 'Please enter valid Contact No.';
              }
              return null;
            },
          ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          thickness: 0.5,
        ),
        if (arr.length == 0)
          Container(
            height: 0.0,
            width: 0.0,
          )
      ],
    ));
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
