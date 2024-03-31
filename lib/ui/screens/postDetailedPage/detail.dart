import 'package:flutter/material.dart';
import 'package:locative/models/posts.dart';

import '../../widgets/bottomnavigation/bottomappbar.dart';
import '../postDetailedPage/component/body.dart'; 


class PostDetailedPage extends StatelessWidget {
  final snap;
  PostDetailedPage({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:  AppBar(
      //   backgroundColor: Colors.transparent,
        
      // ),
      body: SafeArea(
        child: Body(
          snap: snap,
        ),
      ),
      bottomNavigationBar: 
      // BottomAppBar(
      //   color:Colors.brown,
      //   shape: const CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Text(snap!["lienfacebook"],),
      //       IconButton(onPressed: () {  }, icon: Icon(Icons.home),),
      //       IconButton(onPressed: () {  }, icon: Icon(Icons.home),),
      //       IconButton(onPressed: () {  }, icon: Icon(Icons.home),),
      //       IconButton(onPressed: () {  }, icon: Icon(Icons.home),),
      //       IconButton(onPressed: () {  }, icon: Icon(Icons.home),),
      //     ],
      //   )
      // )
      bottomapp(context: context, snap: snap),
    );
  }
}
