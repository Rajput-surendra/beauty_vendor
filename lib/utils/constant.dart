/*fonts*/
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 34.0;

/* margin */

const spacing_control_half = 2.0;
const spacing_control = 4.0;
const spacing_standard = 8.0;
const spacing_middle = 10.0;
const spacing_standard_new = 16.0;
const spacing_large = 24.0;
const spacing_xlarge = 32.0;
const spacing_xxLarge = 40.0;


final int timeOut = 50;
const int perPage = 10;

final String appName = 'Urban Food';

final String packageName = 'com.urban_food.urban';
const String languageCode = 'languageCode';
// final String baseUrl = 'https://urban.alphawizztest.tk/Admin/api-firebase/';

final String baseUrl = 'https://rasthetique.com/public/api/';

String? curUserId;
String? curTikId = '';
String? fcmToken;
String? term = "";
String? privacy = '';
String? returned = "";
String? delivery = "";


double getHeight(double height){
  double tempHeight = 0.0;
  tempHeight = ((height * 100)/1280).h;
  return tempHeight;
}
double getWidth(double width){
  double tempWidth = 0.0;
  tempWidth = ((width * 100)/720).w;
  return tempWidth;
}
Widget boxWidth(double width){
  return SizedBox(width: getWidth(width),);
}

Widget boxHeight(double height){
  return SizedBox(height: getHeight(height),);
}
navigateScreen(BuildContext context,Widget widget){
  Navigator.push(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      ));
}
navigateBackScreen(BuildContext context,Widget widget){
  Navigator.pushReplacement(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      ));
}
back(BuildContext context){
  Navigator.pop(context);
}
