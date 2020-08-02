import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ReceivedFeedBack extends StatefulWidget {
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;

  ReceivedFeedBack(FirebaseUser user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  _ReceivedFeedBackState createState() => _ReceivedFeedBackState();
}

class _ReceivedFeedBackState extends State<ReceivedFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Feedback',
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
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('Feedbacks')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
              default:
                return ListView(
                  children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    return Card(
                      color: Color(0xffffffff),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(document['Feedback']),
                            subtitle: Text(document['EmailID']),
//                            onTap: () {
//
//                            },
                          )
                        ],
                      ),
//                      child: CustomCard(
//                        title: document['Title'],
//                        description: document['Body'],
//                        //topic: document['Topic'],
//                        context: context,
//                        isAdmin: false,
//                        ndate: document['Date'],
//                        stime: document['Time'],
//                        url: document['URL'],
//                        desc: document['Description'],
//                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
