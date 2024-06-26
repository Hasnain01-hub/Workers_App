import 'package:flutter/material.dart';

ThemeData basicTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      //textTheme: Typography().white,
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      primaryColor: Color(0xff7e22ce),
      indicatorColor: Color(0xFF807A6B),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      accentColor: Color(0xFFFFF8E1),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 20.0,
      ),
      buttonColor: Colors.white,
      backgroundColor: Colors.white,
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Color(0xffce107c),
        unselectedLabelColor: Colors.grey,
      ));
}
