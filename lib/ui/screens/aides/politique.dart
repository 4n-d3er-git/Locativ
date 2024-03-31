import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Politique extends StatefulWidget {
  const Politique({super.key});

  @override
  State<Politique> createState() => _ProposState();
}

class _ProposState extends State<Politique> {
    String _contenu = "";
  @override
  void initState(){
    super.initState();
    lireAsset();
  }
  Future<void> lireAsset() async{
    String fichierTexte = await rootBundle.loadString('assets/cgu.txt');
    setState(() {
      _contenu=fichierTexte;
    
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(_contenu)
          ],
        ),
      )
    );
  }
}