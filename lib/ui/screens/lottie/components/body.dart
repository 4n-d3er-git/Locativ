import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';

import '../../feed/feedScreen.dart';
import '../../splashScreen/splashscreen.dart'; 

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
//   // Animation controller
//   late AnimationController _animationController;
//   bool isloading = false;
//   @override
//   void initState() {
//     _animationController = AnimationController(
//         vsync: this,
//         duration: Duration(
//           seconds: 5,
//         ));

//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           isloading = true;
//         });
//         User? firebaseUser = FirebaseAuth.instance.currentUser;
//         Widget firstWidget;

//         if (firebaseUser != null) {
//           firstWidget = FeedScreen();
//         } else {
//           firstWidget = SplashScreen();
//         }
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => firstWidget),
//         );
//       }
//       ;
//       setState(() {
//         isloading = false;
//       });
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Image.asset("assets/LOCATIVE.gif"),
//           Lottie.asset(
//             // "assets/lottie/house.json",
//             "assets/LOCATIVE.mp4.lottie.json",
//             fit:  BoxFit.cover,
//             controller: _animationController,
//             height: 300.h,
//             width: 300.w,
//             onLoaded: (compostion) {
//               _animationController.forward();
//             },
//           ),
//           // SizedBox(
//           //   height: 16.h,
//           // ),
//           // Center(
//           //     child: CupertinoActivityIndicator(
//           //   color: Colors.brown,
//           // )),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // video controller
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/locative.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    // playing video
    _controller.play();

    //add delay till video is complite
    await Future.delayed(const Duration(seconds: 5));
User? firebaseUser = FirebaseAuth.instance.currentUser;
        Widget firstWidget;

        if (firebaseUser != null) {
          firstWidget = FeedScreen();
        } else {
          firstWidget = SplashScreen();
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => firstWidget),
        );
      }
      
    // navigating to home screen
  //   Navigator.pushReplacement(context, MaterialPageRoute(
  //     builder: (BuildContext context) => FeedScreen(),
  //   ),
  // );
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              )
            : Center(
              child: Image.asset("assets/LOCATIVE.png", fit: BoxFit.cover,),
            ),
      ),
    );
  }
}