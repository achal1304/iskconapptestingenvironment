import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';

import 'crud.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm(String text, {@required this.descript});
  final descript;
  @override
  _RegistrationFormState createState() => _RegistrationFormState(

  );
}

class _RegistrationFormState extends State<RegistrationForm> {
  List<String> strings = ["Name", "Address", "Age", "Contact No."];
  List<String> reqfields = [];
  Icon registbutton = Icon(Icons.add);
  Color _iconColor = Colors.grey;
  bool value1 = false;
  bool value2 = false;

  //bool ispressed = true;
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
@override
void initState() {
    setState(() {
      value1 = false;
      value2 = false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Registration Form',
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
        child: Column(
          children: <Widget>[
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
            for (var elem in reqfields) Text(elem),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: GFButton(
                onPressed: () async {
                  Crud().updateArr1(widget.descript, reqfields);
                },
                text: "Upload Form",
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
            ),

//            Column(
//                children: strings
//                    .map((item) => new TextFormField(
//                          enabled: false,
//                          decoration: InputDecoration(
//                              hintText: item,
//                              suffixIcon: IconButton(
//                                icon: registbutton,
//                                color: _iconColor,
//                                onPressed: () {
//                                  setState(() {
//                                    _iconColor = Colors.red;
//                                    print("This is " + item);
//                                    reqfields.add(item);
//                                    print(reqfields);
////                            registbutton = Icon(Icons.minimize);
//                                  });
//                                  Crud().updateArr1(widget.descript, reqfields);
//                                },
//                              )),
//                        ))
//                    .toList()),
//            Column(
//                children: reqfields
//                    .map((item) => new TextFormField(
//                          enabled: false,
//                          decoration: InputDecoration(
//                              hintText: item,
//                              suffixIcon: IconButton(
//                                icon: registbutton,
//                                color: _iconColor,
//                                onPressed: () {
//                                  setState(() {
////                            _iconColor = Colors.red;
////                            print("This is " + item);
////                            reqfields.add(item);
////                            print(reqfields);
////                            registbutton = Icon(Icons.minimize);
//                                  });
//                                },
//                              )),
//                        ))
//                    .toList())
          ],
        ),
      ),
    );
  }

//  Widget getTextWidgets(List<String> strings) {
//    Color _iconColor = Colors.grey;
//    return new Column(
//        children: strings
//            .map((item) => new TextFormField(
//                  enabled: false,
//                  decoration: InputDecoration(
//                      hintText: item,
//                      suffixIcon: IconButton(
//                        icon: registbutton,
//                        color: _iconColor,
//                        onPressed: (){
//                          setState(() {
//                            _iconColor = Colors.red;
//                            print("This is " + item);
////                            registbutton = Icon(Icons.minimize);
//
//                          });
//                        },
//                      )
//                  ),
//                ))
//            .toList());
//  }
}
