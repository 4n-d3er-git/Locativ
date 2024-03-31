import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppbar() {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(
      "Publier",
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
      ),
    ),
  );
}
