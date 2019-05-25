import 'package:flutter/material.dart';
import 'package:lamp/lamp.dart';

void main() => runApp(new MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasFlash = false;
  bool _isOn = false;
  double _intensity = 1.0;
   
  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool hasFlash = await Lamp.hasLamp;
    print("Device has flash ? $hasFlash");
    setState(() { _hasFlash = hasFlash; });
  }
  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Torch',
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation:  10 ,
            backgroundColor: Colors.transparent,
            title: Text('Flutter Torch'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
              Icons.info,
              color: Colors.white,
              ),
              onPressed: () {
              showinfo(context);
              } 
            ),
            ),
        body: new Center(
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ButtonTheme(
            minWidth: 150.0,
            height: 40.0,       
            child  : new RaisedButton(
            child: Text('Flash is on: $_isOn'),
            color: Theme.of(context).accentColor,
            elevation: 10.0,
            splashColor: Colors.blueGrey,
            onPressed:  _turnFlash,
            textColor: Colors.yellowAccent,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
          ),    
     new Text('Device has flash: $_hasFlash',),
          ]),
        ),
        ),
      ),
      
    );
  }
  void showinfo(BuildContext context){
  var alertDialog = AlertDialog(
    title: Text('About Flutter Torch'),
    content: Text('app made by alik kumar ghosh'),
  );
  showDialog(
    context: context,
    builder: (BuildContext context){
      return alertDialog;
    }
  );
}
 Future _turnFlash() async {
    _isOn ? Lamp.turnOff() : Lamp.turnOn(intensity: _intensity);
    var f = await Lamp.hasLamp;
    setState((){
      _hasFlash = f;
      _isOn = !_isOn;
    });
 }
}
