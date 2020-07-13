import 'dart:collection';

import 'package:cetcse/members_page.dart';
import 'package:cetcse/shared_photos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetcse/notice_page.dart';
import 'package:cetcse/home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';


final databaseReference = FirebaseDatabase.instance.reference();
final firestoreInstance = Firestore.instance;


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blueAccent, 
    statusBarColor: Colors.white, 
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins'
      ),
      home: Main(title: 'CSE'),
    );
  }
}



class Main extends StatefulWidget {
  Main({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {


	int _currentIndex = 0;
  final List<Widget> _pageOptions = [
    HomePage(),
    NoticePage(),
    MembersPage(),
    SharedPhotosPage(),
  ];

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      body: _pageOptions[_currentIndex],
			bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blueAccent,
        backgroundColor: Colors.transparent,
        height: 50.0,
        animationCurve: Curves.fastOutSlowIn,
				items: [
          Icon(Icons.home, color: Colors.white),
          (_currentIndex == 1) ? Icon(Icons.notifications, color: Colors.white) : Icon(Icons.notifications_none, color: Colors.white),
          (_currentIndex == 2) ? Icon(Icons.people, color: Colors.white) : Icon(Icons.people_outline, color: Colors.white,),
          (_currentIndex == 3) ? Icon(Icons.photo, color: Colors.white,) : Icon(Icons.photo_library, color: Colors.white),
				],
				onTap: (index) {
					setState(() {
					  _currentIndex = index;
					});
				},
			),
    );
  }
}
