import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/provider/userProviders.dart';
import 'package:locative/ui/screens/aides/aides.dart';
import 'package:locative/ui/screens/edit/components/liste/mot_de_pass.dart';
import 'package:locative/ui/screens/edit/components/liste/prenom_nom.dart';
import 'package:locative/ui/screens/edit/components/liste/telephone.dart';
import 'package:locative/ui/screens/edit/components/liste/ville_quartier.dart';
import 'package:provider/provider.dart';

class ListeModifications extends StatelessWidget {
  const ListeModifications({super.key});

  @override
  Widget build(BuildContext context) {
    var creaditials = Provider.of<UserProviders>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text("Modifier le Profil"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          customListTIle(
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PrenomNom(),
                ),
              );
            },
            leading: Icons.help,
            text: "Prénom et Nom",
            trailing: Icons.arrow_forward_ios_outlined,
          ),
          const Divider(),
          customListTIle(
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VilleQuartier(),
                ),
              );
            },
            leading: Icons.help,
            text: "Ville et Quartier/Commune",
            trailing: Icons.arrow_forward_ios_outlined,
          ),
          const Divider(),
          //?-----------------------
          creaditials.lienFacebook == "aucun lien" ?
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Telephone(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 14.h),
                child: ListTile(
                  leading: Container(
                    width: 54.w,
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.04),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    "Numero de Téléphone et Réseaux",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ):
          customListTIle(
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Telephone(),
                ),
              );
            },
            leading: Icons.phone_android,
            text: "Numero de Téléphone et Réseaux",
            trailing: Icons.arrow_forward_ios_outlined,
          ),
          const Divider(),
          customListTIle(
            press: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MotDePass(),
                ),
              );
            },
            leading: Icons.help,
            text: "Mot de Pass",
            trailing: Icons.arrow_forward_ios_outlined,
          ),
        ],
      ),
    );
  }

  Widget customListTIle({
    required IconData leading,
    required String text,
    required IconData? trailing,
    required VoidCallback press,
  }) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 14.h),
        child: ListTile(
          leading: Container(
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: text == "Déconnexion"
                  ? Colors.red[300]
                  : Colors.brown.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: Icon(
              leading,
              color: text == "Déconnexion" ? Colors.white : Colors.brown,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          trailing: Icon(
            trailing,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}
