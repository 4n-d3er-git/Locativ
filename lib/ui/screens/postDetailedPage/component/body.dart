import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:locative/ad_helper/ad_helper.dart';
import 'package:locative/models/posts.dart';
import 'package:locative/models/users.dart';
import 'package:locative/provider/userProviders.dart';
import 'package:locative/ui/screens/postDetailedPage/component/vues.dart';
import 'package:locative/ui/screens/postDetailedPage/component/likes.dart';
import 'package:locative/ui/screens/postDetailedPage/detail.dart';
import 'package:locative/ui/screens/profile/profilAutre.dart';
import 'package:locative/ui/screens/profile/profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:intl/intl.dart';

import '../../../../services/firestore_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:readmore/readmore.dart';
class Body extends StatefulWidget {
  final snap;
  Body({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _callPhoneNumber() async {
  String phoneNumber = widget.snap!["contact"];
  var url = 'tel:$phoneNumber';
  launchUrlString(url);
}
  
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

  @override
  Widget build(BuildContext context) {
    var creaditials = Provider.of<UserProviders>(context).getUser;

    UserCreaditials userCreaditials =
        Provider.of<UserProviders>(context).getUser;

    DateTime dateTime = widget.snap!["datePublication"].toDate();
DateFormat dateFormat = DateFormat('d MMMM yyyy', 'fr_FR');
String formattedDate = dateFormat.format(dateTime);


DateTime now = DateTime.now();
Duration difference = now.difference(dateTime);

String timeAgo;
if (difference.inDays > 365) {
  final years = (difference.inDays / 365).floor();
  timeAgo = '$years ${years == 1 ? 'an' : 'ans'} ';
} else if (difference.inDays > 30) {
  final months = (difference.inDays / 30).floor();
  timeAgo = '$months ${months == 1 ? 'mois' : 'mois'} ';
} else if (difference.inDays > 7) {
  final weeks = (difference.inDays / 7).floor();
  timeAgo = '$weeks ${weeks == 1 ? 'semaine' : 'semaines'} ';
} else if (difference.inDays > 0) {
  timeAgo = '${difference.inDays} ${difference.inDays == 1 ? 'jour' : 'jours'} ';
} else if (difference.inHours > 0) {
  timeAgo = '${difference.inHours} ${difference.inHours == 1 ? 'heure' : 'heures'} ';
} else if (difference.inMinutes > 0) {
  timeAgo = '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ';
} else {
  timeAgo = "un instant";
}
PosteVue posteVue = PosteVue(id: widget.snap!["postId"], vues: widget.snap!["vue"],);
String formatVues(int vues) {
  if (vues >= 1000000) {
    return '${(vues / 1000000).toStringAsFixed(1)}m';
  } else if (vues >= 1000) {
    return '${(vues / 1000).toStringAsFixed(1)}k';
  } else {
    return '$vues';
  }
}
    
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
            Container(
              height: 300.h,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageZoom(
                        texte: widget.snap!["titre"],
                        imageUrl: widget.snap!["postURL"],
                      ),
                    ),
                  );
                },
                child: 
                    CachedNetworkImage(
                      imageUrl: widget.snap!["postURL"],
                    ),
                    
                  
              ), 
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white.withOpacity( 0.5),
                         borderRadius: BorderRadius.circular(50.r),
                       ),
                        
                        child: IconButton(icon: Icon(CupertinoIcons.left_chevron),
                        onPressed: (){Navigator.pop(context);},
                        ),
                      ),
            ),
          ],
        ),
        //!

        //!
        SizedBox(
          height: 16.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.green)),
                      child: Text(
                        widget.snap!["locationType"],
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "le ",
                          
                        ),
                        TextSpan(
                          text:  formattedDate,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    )
                  )
                  // Text("il y a "+timeAgo),
                  // Row(children: [
                  //   Text("${formatVues(posteVue.vues)}"),
                  //   SizedBox(width: 4,),
                  //           Icon(Icons.remove_red_eye, color: Colors.brown,),
                  // ],)
                  //Row(
                   // children: [
                      //Poste(
                        //id: widget.snap!["postId"],
                        //likes: widget.snap!["likes"],
                      //),
                      // Icon(
                      //   Icons.star,
                      //   color: Colors.yellow,
                      // ),
                      // SizedBox(
                      //   width: 8.w,
                      // ),
                      // likes(),
                   // ],
                  //),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                widget.snap!["titre"],
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(widget.snap!["localite"]),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     statsHouse(
              //         iconData: Icons.bed,
              //         items: widget.snap!["beds"],
              //         title: "Beds"),
              //     statsHouse(
              //         iconData: Icons.bathroom,
              //         items: widget.snap!["rooms"],
              //         title: "Rooms"),
              //     statsHouse(
              //         iconData: Icons.expand,
              //         items: widget.snap!["sqft"],
              //         title: "sqft"),
              //   ],
              // ),
              SizedBox(
                height: 8.h,
              ),
              Divider(),
              if (_isBannerAdReady2)
                showBannerAds(
                    height: _bannerAd2.size.height.toDouble(),
                    width: _bannerAd2.size.width.toDouble(),
                    bannerAd: _bannerAd2),
              SizedBox(
                height: 8.h,
              ),
              
              GestureDetector(
                child: Container(
                  child: ListTile(
                    onTap: userCreaditials.uid == widget.snap!["uid"] ?
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    }:
                    () {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute( 
                          builder: (context) => ProfiAute(
                            uid: widget.snap!["uid"], snap: widget.snap,
                          ),
                        ),
                      );
                    },
                    leading: 
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => ImageZoom(
                    //           texte: widget.snap!["userName"] + " " + widget.snap!["nom"],
                    //           imageUrl: widget.snap!["photoProfil"],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   child: 
                      CircleAvatar(
                        // radius: 50,
                        backgroundImage: NetworkImage(widget.snap!["photoProfil"]),
                      ),
                    // ),
                    title: Row(
                      children: [
                        Text(widget.snap!["userName"]+ " " + widget.snap!["nom"], style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 5,
                        ),
                        // userCreaditials.afficherIconeCertification(),
                        // IconButton(onPressed: (){}, icon: ), 
                        if (widget.snap!["certification"] == "oui")
                          Icon(
                            Icons.verified,
                            color: Colors.blue[500],
                            size: 20,
                          )
                      ],
                    ),
                    // subtitle: Text(widget.snap!["useremail"]),
                    // trailing: Icon(Icons.email_outlined),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              ReadMoreText(
                trimLines: 3,
                trimMode: TrimMode.Line,
                trimCollapsedText: '   LIRE PLUS',
                trimExpandedText: '   LIRE MOINS',
                // colorClickableText: Colors.brown,
                // moreStyle: TextStyle(
                //   fontSize: 14.sp,
                //   fontWeight: FontWeight.bold,
                //   // color: Colors.brown,
                // ),
                widget.snap!["description"],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Text(
              //       "Status",
              //       style: TextStyle(fontSize: 16.sp),
              //     ),
              //     Text(widget.snap!["houseStatus"]),
              //   ],
              // ),
              // SizedBox(
              //   height: 8.h,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Contact", style: TextStyle(fontSize: 16.sp)),
                  GestureDetector(
                    child: Text(widget.snap!["contact"]),
                    onTap: 
                      _callPhoneNumber
                    
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget likes() {
    setState(() {});
    return Text("${widget.snap!["likes"].length} Likes");
  }

  Widget statsHouse({
    required IconData iconData,
    required String items,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.04),
            shape: BoxShape.circle,
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.green,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text("$items $title"),
      ],
    );
  }
}

class ImageZoom extends StatelessWidget {
  final String imageUrl;
  final String texte;

  const ImageZoom({super.key, required this.imageUrl, required this.texte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => PostDetailedPage(),
            //   ),
            // );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.brown,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          texte,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
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
