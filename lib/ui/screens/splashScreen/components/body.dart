
import 'package:locative/ui/screens/completeProfile/completeProfile.dart';

import '../../../screens/splashScreen/components/splashstats.dart';
import '../../../screens/splashScreen/components/splastDots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/default.dart';
import '../../signupscreen/signup.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;

  List<Map<String, String>> items = [
    {
      "title": "Trouvez Votre Chez-Vous Idéal",
      "desc":
          "Explorez notre selection d'appartements, maisons et espaces uniques à louer.",
      "imageURL": "assets/apartment.png",
    },
    {
      "title": "Voyagez en Toute Liberté",
      "desc":
          "Louez des véhicules adaptés à vos escapades. Des voitures élégantes aux vélos électriques, trouvez le compagnon parfait pour chaque aventure",
      "imageURL": "assets/vehicle.png",
    },
    {
      "title": "Explorez l'extérieur avec les meilleurs équipements",
      "desc":
          "Louez des équipements de sport et de plein air de haute qualité. Trouvez tout ce dont vous avez besoin.",
      "imageURL": "assets/gym.png",
    },
    {
      "title": "Fêtez en grand style",
      "desc":
          "Organisez des événements inoubliables avec nos articles de fête et événementiels. Créez des moments mémorables avec notre sélection de location.",
      "imageURL": "assets/fete.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              // height: 1.h,
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: items.length,
                itemBuilder: (context, index) => splashStats(
                  title: items[index]["title"].toString(),
                  desc: items[index]["desc"].toString(),
                  imageURL: items[index]["imageURL"].toString(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      items.length,
                      (index) =>
                          splashDots(index: index, currentIndex: currentIndex),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  currentIndex == 3
                      ? Container()
                      : TextButton(
                          onPressed: () {
                            // Navigator.of(context)
                            //     .pushNamedAndRemoveUntil(CompleteProfle.routeName,(route) => false,);
                                Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteProfle()));
                          },
                          child: Text(
                            "Sauter",
                            style: TextStyle(
                              color: Color(0xff023020),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: currentIndex == 3
                        ? defaultButton(
                            press: () {
                               Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteProfle()));
                            },
                            text: "Créer un Compte")
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.green[900],
                                shape: StadiumBorder(),
                                padding: EdgeInsets.all(12),
                                minimumSize: Size(double.infinity, 40.h),
                              ),
                              onPressed: null,
                              child: Text(
                                "Créer un Compte",
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
