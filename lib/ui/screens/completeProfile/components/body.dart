import 'package:locative/ui/screens/signinscreen/signin.dart';
import 'package:locative/ui/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../screens/completeProfile/components/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);
final String url = 'https://drive.google.com/file/d/1KEpR8nt-uFtyiXb-dU_6fX-_a94qeD__/view?usp=drivesdk'; // Remplacez par votre lien

    _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, ),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                const CompleteStats(),
                SizedBox(
                  height: 16.h,
                ),
                const form(),
                // bottom message
                SizedBox(
                  height: 16.h,
                ),
                const Text(
                  "En continuant vous acceptez nos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                
                footer(
                text: "",
                press: () {
                  _launchURL();
                },
                linkText: "conditions d'utilisation",
                color: Colors.grey,
                linkColor: const Color(0xff023020),
              ),
              SizedBox(
                  height: 8.h,
                ),
                footer(
                text: "Vous avez déjà un compte ? ",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
                },
                linkText: "Connectez-vous",
                color: Colors.grey,
                linkColor: const Color(0xff023020),
              ),
              const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
