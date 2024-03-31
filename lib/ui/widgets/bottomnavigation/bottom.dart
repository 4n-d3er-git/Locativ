import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/firebase_auth_methods.dart';
import '../customSnakeBar.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget bottom(BuildContext context, var snap) {
  // var creaditials = Provider.of<UserProviders>(context).getUser;
  void callPhoneNumber() async {
    String phoneNumber = snap!["contact"];
    var url = 'tel:$phoneNumber';
    launchUrlString(url);
  }

  void sendSMS() async {
    final Uri phoneNumber =Uri(
        scheme: 'sms', path: snap!["contact"],
        queryParameters:{'body': "Salut j'ai trouvé ceci dans l'application Locative et je suis ininteressé(e) " +" "+snap!["titre"]} ,
        );
    launchUrlString(phoneNumber.toString());
  }

  void sendEmail() async {
final Uri email  = Uri(scheme: 'mailto', path: snap!["useremail"],
    queryParameters: {'subject':"Vu de location dans l'application Locative", 'body': "Salut j'ai trouvé ceci dans l'application Locative et je suis ininteressé(e) " +" "+snap!["titre"]},
    );
    launchUrlString(email.toString());
  }
  

  void openWhatsapp() async {
    final Uri waphoneNumber = Uri(scheme:'https', host: 'wa.me', path:snap!["contact"],
    queryParameters:{'text': "Salut j'ai trouvé ceci dans l'application Locative et je suis ininteressé(e) " +" "+snap!["titre"]} ,
    );
    await launchUrlString(waphoneNumber.toString());
  }

  void openFacebook() async {
    final String faceurl= snap!["lienfacebook"];
    if (await canLaunchUrlString(faceurl)) {
      await launchUrlString(faceurl);
    } else {
      Navigator.pop(context);
      showSnakeBar("Impossible d'ouvrir ce lien: $faceurl", context);
    }
  }


  return InkWell(
    onTap: () {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) =>
            CupertinoActionSheet(title: Text("Contacter par"), actions: [
          CupertinoActionSheetAction(
              onPressed: callPhoneNumber,
              child: Text(
                "Appel",
                style: TextStyle(color: Colors.black),
              )),
          CupertinoActionSheetAction(
              onPressed: sendSMS,
              child: Text(
                "SMS",
                style: TextStyle(color: Colors.black),
              )),
          CupertinoActionSheetAction(
              onPressed: openWhatsapp,
              child: Text(
                "WhatsApp",
                style: TextStyle(color: Colors.black),
              )),
          CupertinoActionSheetAction(
              onPressed: 
                sendEmail,
              
              child: Text(
                "Mail",
                style: TextStyle(color: Colors.black),
              )),
          CupertinoActionSheetAction(
              onPressed: openFacebook,
              child: Text(
                "Facebook",
                style: TextStyle(color: Colors.black),
              )),
        ]),
      );
    },
    // _callPhoneNumber,

    child: Container(
      height: 60.h,
      width: 180.w,
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "Contacter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
    ),
  );
}
