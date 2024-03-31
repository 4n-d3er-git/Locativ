import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:locative/ad_helper/ad_helper.dart';
import 'package:locative/services/firebase_auth_methods.dart';
import 'package:locative/ui/screens/signinscreen/signin.dart';

import '../../../screens/home/components/productHeading.dart';
import '../../../screens/yourlocation/yourlocation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
 
import 'package:provider/provider.dart';

import '../../../../provider/userProviders.dart';
import '../../../widgets/customCard.dart';
import '../../house/house.dart';
import '../../popularPage/popularHouse.dart';

import 'header.dart';
import 'menuHouses.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd2;
  bool _isBannerAdReady2 = false;
 
  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;

  void loadInterstitial() {
    InterstitialAd.load(
      
      adUnitId: 
      // "ca-app-pub-7229654893754092/8002622210",
      //test
      "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("InterstitialAd Loaded");
          setState(() {
            interstitialAd = ad;
            isInterstitialAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print("InterstitialAd Failed to Load");
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadInterstitial();
  }

  @override
  void initState() {
     addData();
    super.initState();
    // Load ads.
    print('initstate called');
    MobileAds.instance.initialize();

    _bannerAd2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady2 = true;
            print('banner 2 loaded');
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady2 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd2.load();
  }
 

  addData() async {
    UserProviders userProviders = Provider.of(context, listen: false);

    await userProviders.refreshUser();
  }

  

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 16.h,
              ),
              
                  menuButton(
                    iconData: Icons.house,
                    text: "Immobilier",
                    press: () {
                      if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HouseScreen(
                            pageInfo: "Immobilier",
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  menuButton(
                    iconData: Icons.car_rental,
                    text: "Engins Roulants",
                    press: () {
                      if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HouseScreen(
                                pageInfo: "Engins Roulants",
                              )));
                    },
                  ),
                  if (_isBannerAdReady2)
                    showBannerAds(
                        height: _bannerAd2.size.height.toDouble(),
                        width: _bannerAd2.size.width.toDouble(),
                        bannerAd: _bannerAd2), 
                  SizedBox(
                    height: 10.w,
                  ),
                  menuButton(
                    iconData: Icons.outdoor_grill,
                    text: "Equipements et Plein Air",
                    press: () {
                      if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HouseScreen(
                            pageInfo: "Equipements et Plein Air",
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height:10.w),
                   menuButton(
                    iconData: Icons.event_available,
                    text: "Fêtes et Evènementiels",
                    press: () {
                      if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HouseScreen(
                            pageInfo: "Fêtes et Evènementiels",
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.w,
                  ), 
                   menuButton(
                    iconData: Icons.more_horiz,
                    text: "Autres",
                    press: () {
                      if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HouseScreen(
                            pageInfo: "Autres",
                          ),
                        ),
                      );
                    },
                  ),
              
              SizedBox(
                height: 16.h,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class showBannerAds extends StatelessWidget {
  final double width;
  final double height;
  final BannerAd bannerAd;

  const showBannerAds(
      {Key? key,
      required this.width,
      required this.height,
      required this.bannerAd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: width,
        height: height,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}
