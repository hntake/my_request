import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Color primaryColor = HexColor('#f29429');
Color secondaryColor = HexColor('#f0bc81');
Color secondaryTextColor = HexColor('#658E92');

// API Url
String apiUrl='http://127.0.0.1:8000/api';

spancer({
  double w = 0,
  double h = 0,
}) {
  return SizedBox(
    height: h,
    width: w,
  );
}

EdgeInsets spacing({double h = 0, double v = 0}) {
  return EdgeInsets.symmetric(
    horizontal: h,
    vertical: v,
  );
}