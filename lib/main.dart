
import 'package:double_back_to_exit/non_web_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:locative/provider/userProviders.dart';
import 'package:locative/ui/screens/completeProfile/completeProfile.dart';
import 'package:locative/ui/screens/feed/feedScreen.dart';
import 'package:locative/ui/screens/lottie/splash.dart';
import 'package:locative/ui/widgets/customSnakeBar.dart';

import 'package:provider/provider.dart';
import 'core/routes.dart';
import 'package:upgrader/upgrader.dart';
import 'package:locative/ui/widgets/connexion/dep_injec.dart';
import 'package:double_back_to_exit/double_back_to_exit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( 
    // name: "Locative",
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting().then((_){
  runApp(const MyApp());
    DependencyInjection.init();

  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
               ChangeNotifierProvider(
              create: (_) => UserProviders(),
            ),
          ],
          child: DoubleBackToExitWidget( 
  snackBarMessage: "Cliquez à nouveau pour quitter Locative.",
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Locative',
              initialRoute: Lottie.routeName,
              routes: routes,
              theme: ThemeData.light(),
              // themeMode: ThemeMode.system,
              // darkTheme: ThemeData.dark(),
                
              home: UpgradeAlert(child: child,
              dialogStyle: UpgradeDialogStyle.cupertino,
              showIgnore: false,
              )
              
            ),
          ),
        );
      },
      child: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return FeedScreen();
            } else if (snapshot.hasError) {
              return showSnakeBar(snapshot.error.toString(), context);
            }
          }
          // if connection is on waiting state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
              ),
            );
          }
          return CompleteProfle();
        },
      ),
    );
  }
}
