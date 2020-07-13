import 'dart:ui';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MembersPage extends StatefulWidget {

  @override 
  _MemberPageState createState() => _MemberPageState();

}

class _MemberPageState extends State<MembersPage> {

  Map<String, String> images = {
    "Soubhik Samal \n                CR" : "",
    "Rajashree Jena \n                GR" : "",
    "Pratik Kumar\n           ACR": "",
    "Shree Mishra\n            AGR": "",
    "A Asish": "",
    "Abhipsha Parimita Guru": "",
    "Abhishek Jena": "",
    "Aman Kumar Sahu": "",
    "Animesh Kumar Singh":  "",
    "Anmol Nayak":  "",
    "Ansuman Pattnaik":  "",
    "Arpita Mohanty": "",
    "Arpita Naik": "",
    "Bibekananda Das": "",
    "Bidya Kar": "",
    "Dattatraya Biswal": "",
    "Dikhyant Krishna Dalai": "",
    "E Mohit Patro": "",
    "Gourab Nandan Nayak": "",
    "Gyanendra Tripathy": "",
    "Jessica Nayak": "",
    "Jithu Hansda": "",
    "Khusboo Bothra": "",
    "Lala Kanheyalal Ray": "",
    "Lopita Naik": "",
    "Manik Sagar Mullick": "",
    "MD Arbab Sahid": "",
    "Mohit Satpathy": "",
    "Namrata Dash": "",
    "Neha Niharika Kar": "",
    "Nitya Gopal Bhadra": "",
    "Pankaj Kumar Bindhani": "",
    "Piyush Pradhan": "",
    "R P R Terdeage Murmu": "",
    "Ritika Mohanty": "",
    "Rohan Kumar Kar": "",
    "Rohit Rohan Dehury": "",
    "Rupayan Rout": "",
    "Sandeep Mahapatra": "",
    "Satabdi Mishra": "",
    "Satya Prakash Dwivedy": "",
    "Satya Saswat Mohanty": "",
    "Satyaprakash Ray": "",
    "Sheikh Irfan Ali": "",
    "Shivam Swastik Sahoo": "",
    "Simanu Smarak Behera": "",
    "Soumyak Ranjan Behera": "",
    "Sourav Nanda": "",
    "Subham Kumar Sahoo": "",
    "Suraj Kumar Sutar": "",
    "Suvakanta Mohapatra": "",
    "Swagatika Behera": "",
    "Tapan Naik": "",
    "Vansam Agrawal": "",
    "Vivek Gupta": "",
    "Arpan Kumar": "",
    "Sibadaata Samal": "",
    "Sweety Suhani Parhi": "",
    "Snehasis Debyans": "",
    "Somaditya Bindhani": "",
    "Siddheswar Panda": "",
    "Rohitakshya Behera": "",
    "Pemmaraju Anish Gopal": "",
  };
  
  List<String> imageList = [
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1588777308282-b3dd5ce9fb67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
  ];

  List<String> namesList = ["Soubhik Samal \n                CR","Rajashree Jena \n                GR","Pratik Kumar\n           ACR","Shree Mishra\n            AGR","A Asish","Abhipsha Parimita Guru","Abhishek Jena","Aman Kumar Sahu","Animesh Kumar Singh", "Anmol Nayak","Ansuman Pattnaik","Arpita Mohanty","Arpita Naik","Bibekananda Das","Bidya Kar","Dattatraya Biswal","Dikhyant Krishna Dalai","E Mohit Patro","Gourab Nandan Nayak","Gyanendra Tripathy","Jessica Nayak",
  "Jithu Hansda","Khusboo Bothra","Lala Kanheyalal Ray","Lopita Naik","Manik Sagar Mullick","MD Arbab Sahid","Mohit Satpathy","Namrata Dash","Neha Niharika Kar","Nitya Gopal Bhadra","Pankaj Kumar Bindhani","Piyush Pradhan","R P R Terdeage Murmu","Ritika Mohanty","Rohan Kumar Kar","Rohit Rohan Dehury","Rupayan Rout","Sandeep Mahapatra","Satabdi Mishra","Satya Prakash Dwivedy",
  "Satya Saswat Mohanty","Satyaprakash Ray","Sheikh Irfan Ali","Shivam Swastik Sahoo","Simanu Smarak Behera","Soumyak Ranjan Behera","Sourav Nanda","Subham Kumar Sahoo","Suraj Kumar Sutar","Suvakanta Mohapatra","Swagatika Behera","Tapan Naik","Vansam Agrawal","Vivek Gupta","Arpan Kumar","Sibadaata Samal","Sweety Suhani Parhi","Snehasis Debyans","Somaditya Bindhani","Siddheswar Panda","Rohitakshya Behera","Pemmaraju Anish Gopal"
  ];

  List<String> constantNamesList = ["Soubhik Samal \n                CR","Rajashree Jena \n                GR","Pratik Kumar\n           ACR","Shree Mishra\n            AGR","A Asish","Abhipsha Parimita Guru","Abhishek Jena","Aman Kumar Sahu","Animesh Kumar Singh", "Anmol Nayak","Ansuman Pattnaik","Arpita Mohanty","Arpita Naik","Bibekananda Das","Bidya Kar","Dattatraya Biswal","Dikhyant Krishna Dalai","E Mohit Patro","Gourab Nandan Nayak","Gyanendra Tripathy","Jessica Nayak",
  "Jithu Hansda","Khusboo Bothra","Lala Kanheyalal Ray","Lopita Naik","Manik Sagar Mullick","MD Arbab Sahid","Mohit Satpathy","Namrata Dash","Neha Niharika Kar","Nitya Gopal Bhadra","Pankaj Kumar Bindhani","Piyush Pradhan","R P R Terdeage Murmu","Ritika Mohanty","Rohan Kumar Kar","Rohit Rohan Dehury","Rupayan Rout","Sandeep Mahapatra","Satabdi Mishra","Satya Prakash Dwivedy",
  "Satya Saswat Mohanty","Satyaprakash Ray","Sheikh Irfan Ali","Shivam Swastik Sahoo","Simanu Smarak Behera","Soumyak Ranjan Behera","Sourav Nanda","Subham Kumar Sahoo","Suraj Kumar Sutar","Suvakanta Mohapatra","Swagatika Behera","Tapan Naik","Vansam Agrawal","Vivek Gupta","Arpan Kumar","Sibadaata Samal","Sweety Suhani Parhi","Snehasis Debyans","Somaditya Bindhani","Siddheswar Panda","Rohitakshya Behera","Pemmaraju Anish Gopal"
  ];


  File _image;

  downloadProfileImages() async {
    QuerySnapshot qn = await Firestore.instance.collection("profilePhotos").getDocuments();
    return qn.documents;
  }

  Future uploadProfilePhoto(String name) async {
     StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profilePhotos/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((value) {
      Firestore.instance.collection("profilePhotos")
          .document(name)
          .updateData({
            "url" : value,
          });
          setState(() {
            downloadProfileImages();
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: <Widget>[
              Text("Members", style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
              )),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: new StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            itemCount: 63,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3.0,
                child: FutureBuilder(
                  future: downloadProfileImages(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        )
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: (snapshot.data[index].data["url"] != "") ? 
                            GestureDetector(
                              onTap: () async{
                                await FilePicker.getFile(type: FileType.image)
                                  .then((value) {
                                    setState(() {
                                      _image = value;
                                      uploadProfilePhoto(snapshot.data[index].data["Name"]);
                                    });
                                  });
                              },
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data[index].data["url"],
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  Center(
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator()
                                  ));
                                },
                              )) : 
                            IconButton(
                              onPressed: () async {
                                await FilePicker.getFile(type: FileType.image)
                                  .then((value) {
                                    setState(() {
                                      _image = value;
                                      uploadProfilePhoto(snapshot.data[index].data["Name"]);
                                    });
                                  });
                              },
                              icon: Icon(Icons.account_circle),
                              iconSize: 40.0,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                            child: Text(snapshot.data[index].data["Name"], style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      );
                    }
                  }
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.2);
            }),
      ),
    );
  }
}