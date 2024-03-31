import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:locative/ui/screens/feed/feedScreen.dart';
import 'package:locative/ui/screens/house/components/card.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios),
    ),
            title: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Rechercher...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    name = val; 
                  });
                },
              ),
            ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.brown,
                  radius: 24,
                ),
              );
            }

            final docs = snapshots.data!.docs;
            final matches = docs.where((doc) {
              final snap = doc.data() as Map<String, dynamic>;
              return snap['titre'].toString().toLowerCase().contains(name.toLowerCase()) ||
                  snap['prix'].toString().toLowerCase().contains(name.toLowerCase()) ||
                  snap['localite'].toString().toLowerCase().contains(name.toLowerCase());
            }).toList();

            if (matches.isEmpty) {
              return Center(
                child: const Text(
                  "Aucune Location Trouvée ! \n Veuillez rechercher par Titre, Prix ou Localité.",
                ),
              );
            }

            return ListView.separated(
              itemCount: matches.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return customHouseCard(
                  snap: matches[index].data(),
                );
              },
            );
          },
        ));
  }
}
