import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:locative/ui/screens/house/components/card.dart';
import 'package:locative/ui/screens/postDetailedPage/component/body.dart';

class ProfiAute extends StatefulWidget {
  final snap;

   ProfiAute({Key? key,
    required this.snap, required uid,
  }) : super(key: key);


  @override
  State<ProfiAute> createState() => _ProfiAuteState();
}

class _ProfiAuteState extends State<ProfiAute> {
  @override
  Widget build(BuildContext context) {
  // DateTime dateTime = widget.snap!["membre"].toDate();
  // String formatDate = DateFormat('dd MMMM yyyy', 'fr_FR').format(dateTime)??"";

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.3,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        widget.snap!["photoProfil"], 
                    ),
                  )
                ),
                child: GestureDetector(
                  onTap:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageZoom(
                            texte: widget.snap!["userName"] + " " + widget.snap!["nom"],
                            imageUrl: widget.snap!["photoProfil"],
                          ),
                        ),
                      );
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                      widget.snap!["photoProfil"]
                          ),            ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.snap!["userName"] + " " + widget.snap!["nom"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),),
                        SizedBox(width: 5,),
                        if (widget.snap!["certification"] == "oui")
                        Icon(
                          Icons.verified,
                          color: Colors.blue[500],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    // CupertinoListTile(
                      // title: Text("Membre depuis le: $formatDate"),
                    // ),
                    CupertinoListTile(
                      title: Text(widget.snap!["adresse"]+", "+widget.snap!["ville"]),
                    ),
                    CupertinoListTile(
                      title: Text(widget.snap!["genre"]),
                    ),
                    Divider(),
                    Divider(),
                    CupertinoListTile(
                      title: Text("Voir ses mises en location"),
                      leading: Icon(Icons.publish),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SesLocations(snap:  widget.snap, userId: widget.snap!["uid"]) ,
                          ),
                        );
                      },
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}



class SesLocations extends StatefulWidget {
  final String userId;
  var snap;
   SesLocations({Key? key, required this.snap,  required this.userId}) : super(key: key);

  @override
  _SesLocationsState createState() => _SesLocationsState();
}

class _SesLocationsState extends State<SesLocations> {

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mises en Location de " + widget.snap!["userName"],
        style: TextStyle(fontSize: 17),
        ),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection('posts')
            .where('uid', isEqualTo: widget.userId)
            .orderBy('datePublication', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index].data();
                return 
                customHouseCard(
                            snap: doc, 
                          );
                // ListTile(
                //   leading: Image.network(
                //     doc['photo'],
                //     width: 50,
                //     height: 50,
                //   ),
                //   title: Text(doc['titre']),
                //   subtitle: Text(doc['vill']),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => DetailsPost(doc: doc),
                //       ),
                //     );
                //   },
                // );
              },
            );
          } else {
            return Center(child: CupertinoActivityIndicator(
                          radius: 25.r,
                          color: Colors.brown,
                        ),);
          }
        },
      ),
    );
  }
}

