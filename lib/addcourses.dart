import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:login/crud.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'registrationform.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class AddCourses extends StatefulWidget {
  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  DateTime _startdate = DateTime.now();
  DateTime _enddate = DateTime.now().add(Duration(days: 7));
  String sdate = "";
  String edate = "";
  String imgUrl = "";
  String ctitle = "";
  String cdesc = "";
  String iurl = "";
  String radioButtonItem = 'Online';
  String offevent = "";
  int id = 1;
  bool value1;
  bool value2;
  List<String> reqfields = [];

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File sampleImage;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController offlineevent = TextEditingController();

  @override
  void initState() {
    value1 = false;
    value2 = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Courses',
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
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Course Title",
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
                    validator: (title) {
                      if (title.isEmpty) {
                        return 'Please enter some title';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    controller: description,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Course description",
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormField(
                    //controller: address,
                    onTap: () async {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(new FocusNode());

                      final List<DateTime> picked =
                          await DateRangePicker.showDatePicker(
                        context: context,
                        initialFirstDate: _startdate,
                        initialLastDate: _enddate,
                        firstDate: DateTime(DateTime.now().year - 50),
                        lastDate: DateTime(DateTime.now().year + 50),
                      );
                      if (picked != null && picked.length == 2) {
                        setState(() {
                          _startdate = picked[0];
                          _enddate = picked[1];
                          sdate = DateFormat('MM/dd/yyyy').format(_startdate);
                          edate = DateFormat('MM/dd/yyyy').format(_enddate);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: '''Course start date : $sdate
Course end date : $edate''',
                      hintMaxLines: 2,
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
                    validator: (_startdate) {
                      if (sdate.isEmpty && edate.isEmpty) {
                        return 'Please select dates';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Online';
                              id = 1;
                            });
                          },
                        ),
                        Text(
                          'Online',
                          style: new TextStyle(fontSize: 17.0),
                        ),
                        Radio(
                          value: 2,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Offline';
                              id = 2;
                            });
                          },
                        ),
                        Text(
                          'Offline',
                          style: new TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                offlineEvent(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: CupertinoButton(
                    //elevation: 7.0,
                    child: Text('Upload Image'),
                    //textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      getImage().then((v) => setState(() {
                            imgUrl = v;
                          }));
                    },
                  ),
                ),
                Divider(thickness: 0.5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                imageCheck(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Divider(thickness: 0.5),
                Container(
                  child: Column(children: <Widget>[
                    Text("Registration Form : ",textAlign: TextAlign.left,),
                    MergeSemantics(
                      child: ListTile(
                        title: Text('Name'),
                        trailing: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: value1,
                            onChanged: (bool value) {
                              setState(() {
                                value1 = value;
                                _savenswitchValue1(value1,"Name");
                              });
                            }
                        ),
                        onTap: () {
                          setState(() {
                            value1 = !value1;
                          });
                        },
                      ),
                    ),
                    MergeSemantics(
                      child: ListTile(
                        title: Text('Address'),
                        trailing: CupertinoSwitch(
                            activeColor: Colors.blue,
                            value: value2,
                            onChanged: (bool value) {
                              setState(() {
                                value2 = value;
                                _savenswitchValue1(value2,"Address");
                              });
                            }
                        ),
                        onTap: () {
                          setState(() {
                            value2 = !value2;
                          });
                        },
                      ),
                    ),
                  ],),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GFButton(
                    onPressed: () async {
                      ctitle = title.text;
                      cdesc = description.text;
                      offevent = offlineevent.text;
                      if (_formKey.currentState.validate() && imgUrl != "") {
                        await checkAndUpdate();
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Course Uploaded!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else if (imgUrl == "") {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Please select an image'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } //Navigator.pop(context);
                    },
                    text: "Upload Course",
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            )),
      ),

//      floatingActionButton: FloatingActionButton.extended(
//        backgroundColor: Colors.blueAccent,
//        label: Text(
//          "Make Registration form",
//          style: TextStyle(
//              decoration: TextDecoration.none,
//              fontSize: 14,
//              color: Colors.white),
//        ),
//        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => RegistrationForm(
//                description.text
//              ),
//            ),
//          );
//        },
//      ),
    );
  }

  checkAndUpdate() async {
    Crud().addCourseData(ctitle, cdesc, sdate, edate, radioButtonItem, offevent,
        imgUrl, _startdate,reqfields);
  }

  Widget offlineEvent() {
    if (radioButtonItem == 'Offline') {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: TextFormField(
          controller: offlineevent,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Venue for the event",
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                borderRadius: BorderRadius.circular(25.0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 32.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          validator: (offlineevent) {
            if (offlineevent.isEmpty) {
              return 'Please select dates';
            }
            return null;
          },
        ),
      );
    } else
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0,
      );
  }
  _savenswitchValue1(bool value1,String name) async {
    if(value1 == true){
      setState(() {
        reqfields.add(name);
      });
    }
    else setState(() {
      reqfields.remove(name);
    });
  }

  Future<String> getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('/events/${Path.basename(sampleImage.path)}');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);

    if (task.isInProgress) CircularProgressIndicator();
    await task.onComplete;

    print('File Uploaded');
    final StorageTaskSnapshot downloadUrl = (await task.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    //print('URL Is $url');

    return url;
  }

  Widget imageCheck() {
    if (imgUrl == "") {
      return Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Text("Please select an Image"));
    } else
      return Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            fit: BoxFit.fitWidth,
          ));
  }
}
