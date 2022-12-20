import 'dart:async';

import 'package:beauty_vendor/utils/common.dart';
import 'package:beauty_vendor/web.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url="";
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData()async{
    await App.init();
    if(App.localStorage.getString("userId")!=null){
      setState(() {
        url = "https://rasthetique.com/admin/login";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Beauty Salon Vendor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        initialRoute: "/",
        home: SplashScreen(),
        // home: TermsAndCondition(),
      );
    });
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String url="";
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage()async {
    await App.init();
    if(App.localStorage.getString("userId")==null){
      setState(() {
        url = "https://rasthetique.com/admin/login";
      });
    }
    print("Web Url" + url);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => WebViewScreen(url)));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: new Container(
          padding: EdgeInsets.only(bottom: 50),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('images/splash.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

}
