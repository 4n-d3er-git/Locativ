// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Poste extends StatelessWidget {
  Poste({
    Key? key,
    required this.likes,

    required this.id,
  }) : super(key: key);

  final List likes;
  final String id;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> likePost(
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(id).update(
        {
          'likes': FieldValue.arrayUnion([userId])
        },
      );
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error liking post'),
        ),
      );
    }
  }

  Future<void> dislikePost(
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(id).update(
        {
          'likes': FieldValue.arrayRemove([userId])
        },
      );
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error liking post'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
       
      },
      child:  Row(
                  children: [
                    
                    //!
                    Text(
                      likes.length.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      
                      onPressed: () {
                        if (likes.contains(userId)) {
                          dislikePost(context);
                        } else {
                          likePost(context);
                        }
                      },
                      icon: likes.contains(userId)
                          ? const 
                              Icon(Icons.favorite, 
                              color: Colors.red)
                            
                          : const Icon(Icons.favorite_outline, 
                              color: Colors.red),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    

                  ],
                ),
      
    );
  }
}