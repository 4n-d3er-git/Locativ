import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/screens/completeProfile/completeProfile.dart';
import 'package:locative/ui/screens/forgot/forgotPassword.dart';
import 'package:locative/ui/screens/smsOTP/smsOTP.dart';

import '../../../widgets/footer.dart';
import '../../../widgets/sociallinks.dart';
import '../../signinscreen/components/form.dart';
import '../../signupscreen/signup.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 4,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 24.h),
                child: Image.asset("assets/login.png"),
              ),
              Text(
                "Se Connecter",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              const FormFields(),
              SizedBox(
                height: 16.h,
              ),
              TextButton(
                // onPressed: () {
                //   Navigator.of(context).pushNamed(ForgotScreen.routeName);
                // },
                onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SmsOtpScreen(value: 2)));
              },
                child: Text(
                  "Mot de Pass Oublié ?",
                  style: TextStyle(
                    color: Color(0xff023020),
                    fontWeight: FontWeight.w700,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(
              height: 8.h,
            ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Divider(
              //         color: Colors.grey,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10.w,
              //     ),
              //     //!
                  // Text("ou continuer avec"),
                  // SizedBox(
                  //   width: 10.w,
                  // ),
                  // Expanded(
                  //   child: Divider(
                  //     color: Colors.grey,
                  //   ),
                  // ),
              //   ],
              // ),
              // SizedBox(
              //   height: 16.h,
              // ),
              // const SocialLinks(),
              // SizedBox(
              //   height: 16.h,
              // ),
              footer(
                text: "Vous n'avez pas de compte ? ",
                press: () {
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompleteProfle()));
                },
                linkText: "Créer un Compte",
                color: Colors.grey,
                linkColor: Color(0xff023020),
              ),
              SizedBox(
                    height: 10.h,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
