import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/screens/postDetailedPage/component/vues.dart';
import 'package:locative/ui/screens/postDetailedPage/component/likes.dart';
import 'package:locative/ui/widgets/customSnakeBar.dart';
import 'package:provider/provider.dart';

import '../../../../models/users.dart';
import '../../../../provider/userProviders.dart';
import '../../../../services/firestore_methods.dart';
import '../../postDetailedPage/detail.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';


class customHouseCard extends StatefulWidget {
  final snap;
  customHouseCard({
    Key? key,
    required this.snap,
    
  }) : super(key: key);

  @override
  State<customHouseCard> createState() => _customHouseCardState();
}

class _customHouseCardState extends State<customHouseCard> {
  Widget likes() {
    setState(() {});
    return Text("${widget.snap!["likes"].length} Likes");
  }

  
  @override
  Widget build(BuildContext context) {
//   DateTime dateTime = widget.snap!["datePublication"].toDate();
// String timeAgo = timeago.format(dateTime, locale: 'es_short');
DateTime dateTime = widget.snap!["datePublication"].toDate();
DateTime now = DateTime.now();
Duration difference = now.difference(dateTime);

String timeAgo;
if (difference.inDays > 365) {
  final years = (difference.inDays / 365).floor();
  timeAgo = '$years ${years == 1 ? 'an' : 'ans'}';
} else if (difference.inDays > 30) {
  final months = (difference.inDays / 30).floor();
  timeAgo = '$months ${months == 1 ? 'mois' : 'mois'}';
} else if (difference.inDays > 7) {
  final weeks = (difference.inDays / 7).floor();
  timeAgo = '$weeks ${weeks == 1 ? 'semaine' : 'semaines'}';
} else if (difference.inDays > 0) {
  timeAgo = '${difference.inDays} ${difference.inDays == 1 ? 'jour' : 'jours'}';
} else if (difference.inHours > 0) {
  timeAgo = '${difference.inHours} ${difference.inHours == 1 ? 'heure' : 'heures'}';
} else if (difference.inMinutes > 0) {
  timeAgo = '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}';
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

    UserCreaditials userCreaditials =
        Provider.of<UserProviders>(context).getUser;
    return 
    GestureDetector(
      
      onTap: (){
        posteVue.incrementVue();
        Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostDetailedPage(snap: widget.snap, ),
                  ),
                );
                
      },
      child:
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            // child: 
            // Card(
              // semanticContainer: true,
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 170.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      widget.snap!["postURL"],
                    ),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    right: BorderSide(),
                    top: BorderSide(),
                    left: BorderSide(),
                    ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(20.r),
                    ),
                ),
              ),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(30.r),
              //     topRight: Radius.circular(20.r),
              //   ),
              // ),
              // elevation: 5,
              // margin: EdgeInsets.all(0),
            // ),
            
          ),
          SizedBox(
            width: double.infinity,
            child: 
            // OutlinedButton(
            //   style: ButtonStyle(
            //     padding: MaterialStateProperty.all(
            //       EdgeInsets.symmetric(vertical: 24.h, horizontal: 0),
            //     ),
            //     shape: MaterialStateProperty.all(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(30.r),
            //           bottomRight: Radius.circular(20.r),
            //         ),
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => PostDetailedPage(snap: snap),
            //       ),
            //     );
            //   },
            Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(),
                    bottom: BorderSide(),
                    left: BorderSide(),
                    ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(20.r),
                    ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //!
                    Text("il y a $timeAgo"),
                    SizedBox(height: 8),
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
                              widget.snap!['locationType'],
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.snap!["prix"],
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              " GNF",
                              style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.snap!["titre"],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.sp,
                          ),
                        ),
                        
                        
                         if (widget.snap!["certification"] == "oui")
                      Icon(
                        Icons.verified,
                        color: Colors.blue[500],
                        size: 30,
                      ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.green[900],
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              widget.snap!["localite"],
                              style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // PosteVue(id: widget.snap!["postId"], vues: widget.snap!["vue"],),
                            Text("${formatVues(posteVue.vues)}"),
                            SizedBox(width: 4,),
                            Icon(Icons.remove_red_eye, color: Colors.brown,),
            //                 Poste(id: widget.snap!["postId"],
            // likes: widget.snap!["likes"],),
                      // likes(),
                      SizedBox(width: 10,),
                      widget.snap!['uid'] == userCreaditials.uid
                            ? InkWell(
                                onTap: () {
                                  // FirestoreMethods()
                                  //     .deletePost(postId: widget.snap!['postId']);
                                  showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Voulez-vous supprimer ?'),
                  content: Text('Cette mise en location sera définitivement supprimée de l\'application'),
                  actions: [
                    CupertinoDialogAction(
                      child: Text('D\'accord', style: TextStyle(color: Colors.red),),
                      onPressed: () {
                         FirestoreMethods()
                                      .deletePost(postId: widget.snap!['postId']);
                      Navigator.of(context).pop();
                      showSnakeBar("Location Supprimée avec succès.", context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Annuler',style: TextStyle(color: Colors.brown),),
                      onPressed: () {
                        Navigator.of(context).pop();
                        
                      },
                    ),
                  ],
                ),);
                                },
                                child: Icon(Icons.delete, color: Colors.red,),
                              )
                            : SizedBox(width: 0,)
                            
                          ],
                        ),
                        // snap!['uid'] == userCreaditials.uid
                        //     ? InkWell(
                        //         onTap: () {
                        //           FirestoreMethods()
                        //               .deletePost(postId: snap!['postId']);
                        //         },
                        //         child: Icon(Icons.delete, color: Colors.red,),
                        //       )
                        //     : Icon(Icons.favorite_outline_outlined),
                      ],
                    ),
                    // SizedBox(height: 3,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
