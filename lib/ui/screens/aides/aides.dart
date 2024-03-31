import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/screens/aides/apropos.dart';
import 'package:locative/ui/screens/aides/condition.dart';
import 'package:locative/ui/screens/aides/contactez_nous.dart';
import 'package:locative/ui/screens/aides/partager.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';


class Aides extends StatelessWidget {
    final String url = 'https://drive.google.com/file/d/1KEpR8nt-uFtyiXb-dU_6fX-_a94qeD__/view?usp=drivesdk'; // Remplacez par votre lien

    _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le lien $url';
    }
  }

  const Aides({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
        child: Column(children: [
          customListTIle(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Contacts(),
                    ),
                  );
                },
                leading: Icons.contact_phone_rounded,
                text: "Contactez-nous",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
               const Divider(),
              customListTIle(
                press: () {
                  showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) => RatingDialog(
                              initialRating: 4.0,
                              // your app's name?
                              title: const Text(
                                'Locative',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // encourage your user to leave a high rating?
                              message: const Text(
                                "Appuyez sur  l'étoile pour définir votre note.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                              // your app's logo?
                              // image: 'assets/images/monkolo1.png',
                              image: Image.asset("assets/L.png"),
                              submitButtonText: 'Noter',

                              commentHint: 'Ajoutez votre avis ici',
                              onCancelled: () => print('cancelled'),
                              onSubmitted: (response) async {
                                print(
                                    'rating: ${response.rating}, comment: ${response.comment}');

                                // TODO: add your own logic
                                if (response.rating < 3.0) {
                                  // send their comments to your email or anywhere you wish
                                  // ask the user to contact you instead of leaving a bad review
                                } else {
                                  final _inAppReview = InAppReview.instance;

                                  if (await _inAppReview.isAvailable()) {
                                    print('request actual review from store');
                                    _inAppReview.requestReview();
                                  } else {
                                    print('open actual store listing');
                                    // TODO: use your own store ids
                                    _inAppReview.openStoreListing(
                                      appStoreId: '5172574618966502885',
                                      microsoftStoreId:
                                          '<your microsoft store id>',
                                    );
                                  }
                                }
                              },
                            ));
                },
                leading: Icons.rate_review_rounded,
                text: "Nous Noter",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              const Divider(),
              customListTIle(
                press: () {
                  share();
                },
                leading: Icons.ios_share,
                text: "Partager",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              customListTIle(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Condition(),
                    ),
                  );
                },
                leading: Icons.add,
                text: "Conditions d'utilisation",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              customListTIle(
                press: () {
                  _launchURL();
                },
                leading: Icons.help,
                text: "Polititque de Confidentialité",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              const Divider(),
              customListTIle(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const APropos(),
                    ),
                  );
                },
                leading: Icons.info,
                text: "A Propos",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
        ]),
      ),
    );
  }
  Widget customListTIle({
    required IconData leading,
    required String text,
    required IconData? trailing,
    required VoidCallback press,
  }) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 14.h),
        child: ListTile(
          leading: Container(
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: text == "Déconnexion"
                  ? Colors.red[300]
                  : Colors.brown.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: Icon(
              leading,
              color: text == "Déconnexion" ? Colors.white : Colors.brown,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          trailing: Icon(
            trailing,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}