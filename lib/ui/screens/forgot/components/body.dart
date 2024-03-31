import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/default.dart';
import '../../smsOTP/smsOTP.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Veuillez selectionner la methode par laquelle vous souhaitez réinitialiser votre mot de pass. ",
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          OutlinedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 24.h, horizontal: 0),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SmsOtpScreen(value: 1)));
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.04),
                    ),
                    child: Icon(
                      Icons.messenger_sharp,
                      color: Color(0xff023020),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "par SMS:",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "+224620878831",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          OutlinedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 24.h, horizontal: 0),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SmsOtpScreen(value: 2)));
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.04),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Color(0xff023020),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "par EMAIL:",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "ex********@gmail.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          defaultButton(text: "Continuer", press: () {}),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
