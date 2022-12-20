
import 'dart:async';
import 'dart:io';

import 'package:beauty_vendor/utils/Session.dart';
import 'package:beauty_vendor/utils/colors.dart';
import 'package:beauty_vendor/utils/common.dart';
import 'package:beauty_vendor/utils/constant.dart';
import 'package:beauty_vendor/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/platform_interface.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:sizer/sizer.dart';

class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen(this.url);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  int currentIndex=0;
  late WebViewController controller;
  bool isLoading=true;
  GlobalKey<ScaffoldState> scaffoldKey=new GlobalKey<ScaffoldState>();
  List<String> tabList=[
    "https://rasthetique.com/admin/dashboard",
    "https://rasthetique.com/admin/calendar",
    "https://rasthetique.com/admin/booking",
    "https://rasthetique.com/admin/gallery",
    "https://rasthetique.com/admin/salon",
  ];
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      setSnackbar("Press back again to exit", context);
      return Future.value(false);
    }
    exit(1);
  }

  Offset position =Offset(20.0, 20.0);
  bool  status=false;
 late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  setLoading(bool val) {
      setState(() {
        isLoading = val;

      });
  }
  setController(cont) {
    setState(() {
      controller = cont;
    });
  }

  void checkLogout(var url) async{
    print("check url $url");
    setState(() {
      widget.url = url;
    });
    await App.init();
    if (url.toString().contains("https://rasthetique.com/admin/login")) {
      App.localStorage.clear();
      setState(() {
        widget.url = "https://rasthetique.com/admin/login";
      });
    }
    if (url.toString().contains("https://rasthetique.com/admin/dashboard")) {
      App.localStorage.setString("userId", "1");
      setState(() {
        currentIndex= 0;
      });
    }
    if(url.toString().contains("profile/")){
      controller.loadUrl("https://rasthetique.com/admin/profile");
    }
    if(url.toString().contains("calendar")){
        setState(() {
          currentIndex= 1;
        });
    }
    if(url.toString().contains("booking")){
      setState(() {
        currentIndex= 2;
      });
    }
    if(url.toString().contains("gallery")){
      setState(() {
        currentIndex= 3;
      });
    }
    if(url.toString().contains("/salon")){
      setState(() {
        currentIndex= 4;
      });
    }
  }

  @override
  void dispose() {
   // timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
      return  WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body:  SafeArea(
            child: Container(
              color: Colors.white,
              width: double.maxFinite,
              height: double.infinity,
              child: Stack(
                children: [
                  WebView(
                    initialUrl: widget.url!=""?widget.url:tabList[currentIndex],
                    javascriptMode: JavascriptMode.unrestricted,
                    userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",

                    onWebResourceError: (WebResourceError err) {
                      print(
                          "onWebResourceError----------------${err}");
                    },
                    onWebViewCreated: (c) {
                      setController(c);
                    },
                    onPageFinished: (url) async {
                      setLoading(false);

                    },
                    onPageStarted: (url1) async {
                      print(tabList[currentIndex]);
                      setState(() {
                        isLoading = true;
                      });
                      checkLogout(url1);
                      print("1-------------------${url1}");
                    },
                  ),
                  isLoading
                      ? Center(
                    child: Container(
                      color: Colors.white,
                      width:
                      MediaQuery.of(context).size.width,
                      height:
                      MediaQuery.of(context).size.height,
                      child:  Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          )),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: isLoading||widget.url.toString().contains("login")?SizedBox():Container(
            width: getWidth(720),
            height: getHeight(110),
            color: MyColorName.appbarBg,
            padding: EdgeInsets.all(getWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tabItem(0,"Home","images/home.png"),
                tabItem(1,"Calender","images/calendar.png"),
                tabItem(2,"Booking","images/booking.png"),
                tabItem(3,"Gallery","images/gallery.png"),
                tabItem(4,"My Salon","images/client.png"),
              ],
            ),
          ),
        ),
      );
    }
  tabItem(int i, String s, String t) {
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = i;
          isLoading = true;
        });

        controller.loadUrl(tabList[currentIndex]);
      },
      child: Container(
        child: Column(
          children: [
            Image.asset(t,height: getHeight(36),width: getHeight(36),color: currentIndex==i?MyColorName.primaryLite:MyColorName.colorTextSecondary,),
            boxHeight(3),
            text(s,fontFamily: fontMedium,fontSize: 10.sp,textColor: currentIndex==i?MyColorName.primaryLite:MyColorName.colorTextSecondary),
          ],
        ),
      ),
    );
  }
  }


