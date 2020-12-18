import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:random_color/random_color.dart';

class ExistanceCheck extends StatefulWidget {
  @override
  _ExistanceCheckState createState() => _ExistanceCheckState();
}

class _ExistanceCheckState extends State<ExistanceCheck> {
  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor1 = RandomColor();
    Color _color1 = _randomColor1.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.multiple(colorHues: <ColorHue>[ColorHue.blue]));

    MyColor _myColor1 = getColorNameFromColor(_color1);
    // print(_myColor1.getName);

    RandomColor _randomColor2 = RandomColor();
    Color _color2 = _randomColor2.randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorHue: ColorHue.multiple(colorHues: <ColorHue>[ColorHue.red]));
    MyColor _myColor2 = getColorNameFromColor(_color2);
    // print(_myColor2.getName);
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: /*[Colors.orange.shade300, Colors.orange.shade800]*/ [
              _color1,
              _color2
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have already registered !',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: 300,
                child: OutlineButton(
                  shape: StadiumBorder(),
                  textColor: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(null, null),
                          fullscreenDialog: true,
                        ));
                  },
                  child: Text('Go to Login Page'),

                  //child: Text('Google Sign-up'),
                ),
              ),
            ],
          ),
        ));
  }
}
