
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/screens/house/components/card.dart';
import 'package:locative/ui/widgets/customOutlineBorder.dart';
import 'package:locative/ui/widgets/customTextFormLable.dart';
import 'package:locative/ui/widgets/default.dart';
import 'package:locative/ui/widgets/validator.dart';

class Filtrer extends StatefulWidget {
  const Filtrer({Key? key}) : super(key: key);

  @override
  State<Filtrer> createState() => _FiltrerState();
}

class _FiltrerState extends State<Filtrer> {
bool loading = false;

  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  late TextEditingController _typeController;
  late TextEditingController _neighborhoodController;

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController();
    _maxPriceController = TextEditingController();
    _typeController = TextEditingController();
    _neighborhoodController = TextEditingController();
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _typeController.dispose();
    _neighborhoodController.dispose();
    super.dispose();
  }

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
              // Vous pouvez utiliser cette fonctionnalité pour la recherche par nom
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customTextFieldLable(lableText: 'Prix Minimum', isRequired: false),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: _minPriceController,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "veuillez entrer un prix minimum",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                customTextFieldLable(lableText: 'Prix Maximum', isRequired: false),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: _maxPriceController,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "veuillez entrer un prix maximum",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                customTextFieldLable(lableText: 'Type', isRequired: false),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: _typeController,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "immobilier, enginsroulants, evenements, pleinair, autres",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                customTextFieldLable(lableText: 'Quartier', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: _neighborhoodController,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "veuillez entrer un le nom du quartier",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
            
            SizedBox(height: 16),
            loading
                    ? Center(
                        child: CupertinoActivityIndicator(
                          radius: 25.r,
                          color: Colors.brown,
                        ),
                      )
                    : defaultButton(
                        text: "Filtrer",
                        press: (() {
                          // setState(() {
                          //   loading = true;
                          // });
                          _applyFilters();
                        }
                         
                     ) ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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

                if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Aucune location trouvée"),
                  );
                } else {
                  return ListView.separated(
                    itemCount: snapshots.data!.docs.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      var snap = snapshots.data!.docs[index].data() as Map<String, dynamic>;
                      return customHouseCard(
                        snap: snap,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    // Validation des champs de saisie
    if (_minPriceController.text.isEmpty || _maxPriceController.text.isEmpty) {
      // Afficher une boîte de dialogue ou un message d'erreur pour informer l'utilisateur
      return;
    }

    double minPrice = double.tryParse(_minPriceController.text) ?? 0;
    double maxPrice = double.tryParse(_maxPriceController.text) ?? double.infinity;
    String type = _typeController.text.trim();
    String neighborhood = _neighborhoodController.text.trim();

    setState(() {
      // Mettre à jour les paramètres de la requête Firestore avec les valeurs des champs de texte
      _minPriceController.text = minPrice.toString();
      _maxPriceController.text = maxPrice.toString();
      _typeController.text = type;
      _neighborhoodController.text = neighborhood;
    });

    // Appliquer les filtres sur la collection Firestore
    _fetchFilteredData(minPrice, maxPrice, type, neighborhood);
  }

  void _fetchFilteredData(double minPrice, double maxPrice, String type, String neighborhood) {
    FirebaseFirestore.instance
        .collection('posts')
        .where('prix', isGreaterThanOrEqualTo: minPrice)
        .where('prix', isLessThanOrEqualTo: maxPrice)
        .where('type', isEqualTo: type)
        .where('localite', isEqualTo: neighborhood)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      // Traitement des résultats de la requête
      if (snapshot.docs.isEmpty) {
        // Afficher un message indiquant qu'aucune location n'a été trouvée
      } else {
        // Mettre à jour l'affichage avec les résultats de la recherche
      }
    }, onError: (error) {
      // Gérer les erreurs de requête Firestore
      print('Error fetching filtered data: $error');
    });
  }
}
