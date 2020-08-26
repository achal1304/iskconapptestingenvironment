import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getflutter/getflutter.dart';

import 'coursedescription.dart';
import 'crud.dart';

class CustomCardCourses extends StatefulWidget {
  BuildContext c1;

  // GoogleSignIn _googleSignIn;
  // FirebaseUser _user;

  CustomCardCourses({@required this.title,
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
  _CustomCardCoursesState createState() => _CustomCardCoursesState();
}

class _CustomCardCoursesState extends State<CustomCardCourses> {
  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin1 == true) {
      return Slidable(
        actionExtentRatio: 0.25,
        child: Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.85,
                    child: Image.network(
                      widget.url,
                      fit: BoxFit.fitWidth,

                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CustomCardCoursesDescription(
                              title: widget.title,
                              description: widget.description,
                              //topic: document['Topic'],
                              context: context,
                              isAdmin1: widget.isAdmin1,
                              edate: widget.edate,
                              stime: widget.stime,
                              url: widget.url,
                              type: widget.type,
                              venue: widget.venue,
                              startdatetimestamp: widget.startdatetimestamp,
                              useremail: widget.useremail,
                              usercoursename: widget.usercoursename,
                            ),
                      ),
                    );
                  },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          FittedBox(
//                            child:
                          Text(
                            widget.title,
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000),
                            ),
//                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          eventVenue()
//                        FittedBox(
//                          child: Row(
//                            children: <Widget>[
//                              Icon(Icons.location_on),
//                              SizedBox(
//                                width: 5,
//                              ),
//                              Text(
//                                widget.venue,
//                                style: TextStyle(
//                                  fontSize: 20.0,
//                                  color: Color(0xFF000000),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Starts in",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF000000),
                              ).copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              widget.startdatetimestamp + " Days",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF000000),
                              ).copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
//            SizedBox(
//              height: MediaQuery
//                  .of(context)
//                  .size
//                  .height * 0.01,
//            ),
//            ListTile(
//              leading:GFAvatar(
//                shape: GFAvatarShape.standard,
//                size: 80,
//                //radius: 25,
//                backgroundImage: NetworkImage(widget.url),
//              ),
//              title: Text(widget.title),
//              subtitle: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(widget.edate),
//                  Text(widget.stime),
//                ],
//              ),

//            )
            ],
          ),
        ),
        actions: <Widget>[
          new IconSlideAction(
            caption: 'Delete',
            color: Colors.redAccent,
            icon: Icons.delete,
            onTap: () {
              _showAlertDialog(widget.description);
              //Crud().deleteData(widget.topic);
            },
          ),
        ],
        actionPane: SlidableDrawerActionPane(),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(top: 5.0),
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.85,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.fitWidth,

                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CustomCardCoursesDescription(
                          title: widget.title,
                          description: widget.description,
                          //topic: document['Topic'],
                          context: context,
                          isAdmin1: widget.isAdmin1,
                          edate: widget.edate,
                          stime: widget.stime,
                          url: widget.url,
                          type: widget.type,
                          venue: widget.venue,
                          startdatetimestamp: widget.startdatetimestamp,
                          useremail: widget.useremail,
                          usercoursename: widget.usercoursename,
                        ),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                          FittedBox(
//                            child:
                        Text(
                          widget.title,
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
//                            ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        eventVenue()
//                        FittedBox(
//                          child: Row(
//                            children: <Widget>[
//                              Icon(Icons.location_on),
//                              SizedBox(
//                                width: 5,
//                              ),
//                              Text(
//                                widget.venue,
//                                style: TextStyle(
//                                  fontSize: 20.0,
//                                  color: Color(0xFF000000),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Starts in",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF000000),
                            ).copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            widget.startdatetimestamp + " Days",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF000000),
                            ).copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
//            SizedBox(
//              height: MediaQuery
//                  .of(context)
//                  .size
//                  .height * 0.01,
//            ),
//            ListTile(
//              leading:GFAvatar(
//                shape: GFAvatarShape.standard,
//                size: 80,
//                //radius: 25,
//                backgroundImage: NetworkImage(widget.url),
//              ),
//              title: Text(widget.title),
//              subtitle: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(widget.edate),
//                  Text(widget.stime),
//                ],
//              ),

//            )
          ],
        ),
      );
    }
  }

  _showAlertDialog(String desc) {
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
                          "Delete the course?",
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
                                Crud().deleteCourseData(widget.description);
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

  Widget eventVenue() {
    if (widget.venue == "") {
      return FittedBox(
        child: Row(
          children: <Widget>[
            Icon(Icons.location_on),
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
            Icon(Icons.location_on),
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
}
