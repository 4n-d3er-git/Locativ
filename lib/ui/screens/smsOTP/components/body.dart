import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/widgets/customSnakeBar.dart';

import '../../../../services/firebase_auth_methods.dart';
import '../../../widgets/customOutlineBorder.dart';
import '../../../widgets/default.dart';

class Body extends StatefulWidget {
  final int value;
  const Body({Key? key, required this.value}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _userNumberController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    _userNumberController.dispose();
    _userEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // forgotPasswordByEmail() async {
    //   String res = await FirebaseAuthMethods().forgotPassword(
    //     context: context,
    //     email: _userEmailController.text,
    //   );
    //   setState(() {
    //   _isloading = true;
    // });
    //   if (res == "success") {
    //     setState(() {
    //       _isloading = false;
    //     });
    //     showSnakeBar("Mail de réinitialisation envoyé.", context);
    //   }
    //   else {
    //     setState(() {
    //       _isloading = false;
    //     });
    //     showSnakeBar(res, context);
    //   }
    // }

    forgotPasswordByEmail() async {
  setState(() {
    _isloading = true;
  });
  try {
    String res = await FirebaseAuthMethods().forgotPassword(
      context: context,
      email: _userEmailController.text,
    );

    if (res == "success") {
      setState(() {
        _isloading = false;
      });
      showSnakeBar("Mail de réinitialisation envoyé.", context);
    } else {
      setState(() {
        _isloading = false;
      });
      showSnakeBar(res, context);
    }
  } catch (e) {
    // Gérer les erreurs ici
  }
}
    

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Column(
              children: [
                widget.value == 1
                    ? Text(
                        "Entrez le numéro sur lequel nous enverrons le lien de ré. ",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      )
                    : Column(
                      children: [
                        Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 24.h),
              child: Image.asset("assets/forgotmdp.png"),
            ),
                        Text(
                            "Entrez votre email, nous vous enverrons un mail de réinitilisation. ",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                      ],
                    ),
                SizedBox(
                  height: 24.h,
                ),
                widget.value == 1
                    ? TextFormField(
                        controller: _userNumberController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                          hintText: "entrez le numero de téléphone ici",
                          enabledBorder: customOutlineBorder(),
                          suffixIcon: null,
                          prefixIcon: Icon(Icons.phone),
                          focusedBorder: customOutlineBorder(),
                          border: customOutlineBorder(),
                        ),
                      )
                    : TextFormField(
                        controller: _userEmailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                          hintText: "entrez votre email ici",
                          enabledBorder: customOutlineBorder(),
                          suffixIcon: null,
                          prefixIcon: Icon(Icons.email),
                          focusedBorder: customOutlineBorder(),
                          border: customOutlineBorder(),
                        ),
                      ),
                SizedBox(
                  height: 20.h,
                ),
                _isloading
                    ? const CupertinoActivityIndicator(
                        color: Colors.brown,
                      )
                    :
                defaultButton(
                    text: "Envoyer",
                    press: () {
                      forgotPasswordByEmail();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
