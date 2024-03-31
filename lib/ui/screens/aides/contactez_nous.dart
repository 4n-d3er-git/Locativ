import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'Anderson Goumou',
          textColor: Colors.white,
          backgroundColor: Colors.brown.shade900,
          email: 'andersongoumou10@gmail.com',
          // textFont: 'Sail',
        ),
        backgroundColor: Colors.brown.shade400,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.black,
          logo: const AssetImage('assets/L.png'),
          email: 'andersongoumou10@gmail.com',
          companyName: 'LOCATIVE',
          companyColor: Colors.black54,
          dividerThickness: 2,
          phoneNumber: '+224620878831',
          website: 'https://andersongoumou.000webhostapp.com',
          githubUserName: '4n-d3er-git',
          linkedinURL: 'https://www.linkedin.com/in/anderson-g-164802264/',
          tagLine: 'Louez Plus Facilement',
          taglineColor: Colors.teal.shade100,
          twitterHandle: 'GoumouAnderson',
          instagram: 'an_der_s0n_',
          facebookHandle: 'Anderson.goumou',
        ),
      );
    
  }
}