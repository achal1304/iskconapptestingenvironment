import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisteredUsers extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  RegisteredUsers({
    @required this.usercoursename,
    @required this.useremail,
    //@required this.topic,
    @required this.description,
  });

  final usercoursename;
  final description;

  //final topic;
  final useremail;
  String usersregis = "0";

  @override
  Widget build(BuildContext context) {
    return
//      Container(
//      color: Colors.white,
//      child: Column(
//        children: <Widget>[
        Container(
            color: Colors.white,
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('Courses')
                    .document(description)
                    .collection('Registration')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text(
                        'Loading...',
                        style: TextStyle(decoration: TextDecoration.none,
                            fontSize: 18,
                            color: Colors.black54),
                      );
                    default:
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Text(
                              "Users Registered: " +
                                  snapshot.data.documents.length.toString(),
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 24,
                                  color: Colors.black54),
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                          Expanded(
                              child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return Card(
                                color: Color(0xffffffff),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(document['Useremail']),
                                      subtitle: Text(document['Username']),
                                    )
                                  ],
                                ),
                              );
//                          usersregis = document.data.length.toString();
//                          return checkUser(document);
//                  Card(
//                    color: Color(0xffffffff),
//                    child: Column(
//                      children: <Widget>[
//                        ListTile(
//                          title: Text(document['Useremail']),
//                          subtitle: Text(document['Username']),
//                        )
//                      ],
//                    ),
//                  );
                            }).toList(),
                          ))
                        ],
                      );
//              Expanded(
//                  child: ListView(
//                shrinkWrap: true,
//                children:
//                    snapshot.data.documents.map((DocumentSnapshot document) {
//                  return Card(
//                    color: Color(0xffffffff),
//                    child: Column(
//                      children: <Widget>[
//                        ListTile(
//                          title: Text(document['Useremail']),
//                          subtitle: Text(document['Username']),
//                        )
//                      ],
//                    ),
//                  );
//                          usersregis = document.data.length.toString();
//                          return checkUser(document);
//                  Card(
//                    color: Color(0xffffffff),
//                    child: Column(
//                      children: <Widget>[
//                        ListTile(
//                          title: Text(document['Useremail']),
//                          subtitle: Text(document['Username']),
//                        )
//                      ],
//                    ),
//                  );
//                }).toList(),
//              ));
//          }
//        },
//      ),
////          )
////        ],
////      ),
//    );
//    return Container(
//      color: Colors.white,
//      child: StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance
//            .collection('Courses')
//            .document(description)
//            .collection('Registration')
//            .snapshots(),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//          switch (snapshot.connectionState) {
//            case ConnectionState.waiting:
//              return Text(
//                'Loading...',
//                style: TextStyle(decoration: TextDecoration.none),
//              );
//            default:
//              return Expanded(
//                  child: ListView(
//                shrinkWrap: true,
//                children:
//                    snapshot.data.documents.map((DocumentSnapshot document) {
//                  return Card(
//                    color: Color(0xffffffff),
//                    child: Column(
//                      children: <Widget>[
//                        ListTile(
//                          title: Text(document['Useremail']),
//                          subtitle: Text(document['Username']),
//                        )
//                      ],
//                    ),
//                  );
//                          usersregis = document.data.length.toString();
//                          return checkUser(document);
//                  Card(
//                    color: Color(0xffffffff),
//                    child: Column(
//                      children: <Widget>[
//                        ListTile(
//                          title: Text(document['Useremail']),
//                          subtitle: Text(document['Username']),
//                        )
//                      ],
//                    ),
//                  );
//                }).toList(),
//              ));
//          }
//        },
//      ),
//    );
//    return Container(
//      color: Colors.white,
//      padding: const EdgeInsets.all(10.0),
//      child: StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance
//            .collection('Courses')
//            .document(description)
//            .collection('Registration')
//            .snapshots(),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//          switch (snapshot.connectionState) {
//            case ConnectionState.waiting:
//              return Text(
//                'Loading...',
//                style: TextStyle(decoration: TextDecoration.none),
//              );
//            default:
//              return ListView(
//                children:
//                    snapshot.data.documents.map((DocumentSnapshot document) {
//                  usersregis = document.data.length.toString();
//                  return checkUser(document);
////                  Card(
////                    color: Color(0xffffffff),
////                    child: Column(
////                      children: <Widget>[
////                        ListTile(
////                          title: Text(document['Useremail']),
////                          subtitle: Text(document['Username']),
////                        )
////                      ],
////                    ),
////                  );
//                }).toList(),
//              );
//          }
//        },
//      ),
//    );
                  }
                }));
  }
}

//  Widget checkUser(DocumentSnapshot snapshot) {
//    if (snapshot.data.length == null) {
//      return Container(height: 0.0,width: 0.0,);
//    } else
//      return Card(
//        color: Color(0xffffffff),
//        child: Column(
//          children: <Widget>[
//            ListTile(
//              title: Text(snapshot['Useremail']),
//              subtitle: Text(snapshot['Username']),
//            )
//          ],
//        ),
//      );
//  }
