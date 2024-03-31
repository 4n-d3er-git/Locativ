import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locative/models/posts.dart';
import 'package:locative/ui/screens/postDetailedPage/detail.dart';
 
class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name ="";

  final TextEditingController searchEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchEditingController.dispose();
  }

  bool isShowUser = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading:Icon(Icons.search,color: Colors.black,),
          title: TextFormField(
            controller: searchEditingController,
            decoration: InputDecoration(
              hintText: "Rechercher un utilisateur....",
            ),
            // onFieldSubmitted: (String _) {
            //   print(_);
            //   setState(() {
            //     isShowUser = true;
            //   });
            // },
            onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
          ),
        ),
        body:  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    // .collection('utilisateurs')
                    // .where(
                    //   'nomComplet',
                    .collection('posts')
                    .where(
                      'titre',
                      isGreaterThanOrEqualTo: searchEditingController.text,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(
                          animating: true,
                          color: Colors.brown,
                          radius: 24,
                          key: UniqueKey()),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data()
                      as Map<String, dynamic>;
                      if(name.isEmpty)
                      return 
                      // if(name.isEmpty){
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailedPage(
                                  snap: snapshot.data!.docs[index].id, 
                                ),
                              ),
                            );
                          },
                              leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]['postURL'],
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docs[index]['titre'],
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]['description'],
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                    // if(snapshot.data!.docs[index]['titre'].toString()
                    //       .toLowerCase()
                    //       .startsWith(name.toLowerCase())){
                            
                    //       }
                  
                    // if (data['titre']).toString()
                    //       .toLowerCase()
                    //       .startsWith(name.toLowerCase()) {
                    //         return Container();
                    //       }
                  );
                },
              )
            // : 
            // FutureBuilder(
            //     future: FirebaseFirestore.instance.collection('posts').get(),
            //     builder: (context,
            //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
            //             snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(
            //   child: CupertinoActivityIndicator(
            //       animating: true,
            //       color: Colors.green,
            //       radius: 24,
            //       key: UniqueKey()),
            // );
            //       }
            //       return ListView.builder(
            //         itemCount: snapshot.data!.docs.length,
            //         itemBuilder: (context, index) {
            //           return Dismissible(
            //             key: UniqueKey(),
            //             child: InkWell(
            //               onTap: () {},
            //               child: ListTile(
            //                 title: Text(
            //                   // snapshot.data!.docs[index]['nomComplet'],
            //                   snapshot.data!.docs[index]['titre'],
            //                 ),
            //                 subtitle: Text(
            //                   // snapshot.data!.docs[index]['email'],
            //                   snapshot.data!.docs[index]['description'], maxLines: 2,
            //                   style: TextStyle(
            //                     color: Colors.grey,
            //                   ),
            //                 ),
            //                 leading: CircleAvatar(
            //                   backgroundImage: NetworkImage(
            //                     // snapshot.data!.docs[index]['profilPhoto'],
            //                     snapshot.data!.docs[index]['postURL'],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
      ),
    );
  }
}
