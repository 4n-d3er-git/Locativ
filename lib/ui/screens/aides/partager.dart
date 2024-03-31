import 'package:flutter_share/flutter_share.dart';


Future<void> share() async {
    await FlutterShare.share(
        title: 'Partager',
        text: 'Téléchargez Locative gratuitement! Une application dans laquelle vous trouverez en location tout ce dont vous avez besoin.',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.locative',
        chooserTitle: "Téléchargez Locative gratuitement!"
        );
  }