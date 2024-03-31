import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/footer.dart';
import '../../../widgets/sociallinks.dart';
import '../../forgot/forgotPassword.dart';
import '../../signupscreen/components/form.dart';
import '../../signinscreen/signin.dart';




class SignupBody extends StatelessWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 24.h),
              child: Image.asset("assets/signup.png"),
            ),
            Text(
              "Créer un Compte",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SignFormFields(),
            SizedBox(
              height: 14.h,
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(ForgotScreen.routeName);
            //   },
            //   child: Text(
            //     "Mot de Pass Oublié ?",
            //     style: TextStyle(
            //       color: Color(0xff023020),
            //       fontWeight: FontWeight.w700,
            //       fontSize: 17.sp,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 16.h,
            // ),
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
            //     Text("ou continuer avec"),
            //     SizedBox(
            //       width: 10.w,
            //     ),
            //     Expanded(
            //       child: Divider(
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 24.h,
            // ),
            // SocialLinks(),

            // SizedBox(
            //   height: 5.h,
            // ),
            footer(
              text: "Vous avez déjà un compte ? ",
              press: () {
                Navigator.of(context).pushNamed(Signin.routeName);
              },
              linkText: "Connectez-vous",
              color: Colors.grey,
              linkColor: Color(0xff023020),
            )
          ],
        ),
      ), 
    );
  }
}
