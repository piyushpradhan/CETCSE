import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SharedPhotosPage extends StatefulWidget {
  @override
  _sharedPhotoPageState createState() => _sharedPhotoPageState();
}

class _sharedPhotoPageState extends State<SharedPhotosPage> {

  List<String> photosUrl = [];
  List<String> captions = [];
  File _imageFile;
  TextEditingController captionController = TextEditingController();
  var captionFocusNode = FocusNode();

  showAddPhotoDialog(BuildContext context, {String caption = ""}) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: 400.0,
                width: 400.0,
                child: Image.file(_imageFile),
              ),
              TextField(
                focusNode: captionFocusNode,
                controller: captionController,
                decoration: InputDecoration(
                  labelText: "Caption"
                ),
                maxLines: null,
              ),
              SizedBox(height: 20.0,),
              RawMaterialButton(
                fillColor: Colors.blueAccent,
                child: Text("Upload", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                onPressed: () {
                  if(captionController.text.trim() == null) {
                    captionFocusNode.requestFocus();
                  } else {
                    _uploadPhoto(captionController.text);
                    Navigator.of(context).pop();
                  }
                }
              )
            ],
          ),
        )
      );
    });
  }

  _addImage() async {
    await FilePicker.getFile(type: FileType.image).then((result) {
      if(result != null) {
        setState(() {
          _imageFile = result;
        });
      }
    });
    showAddPhotoDialog(context);
  }

  _uploadPhoto(String caption) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('uploadedPhotos/${Path.basename(_imageFile.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((value) {
      Firestore.instance.collection("photos")
          .document(caption)
          .setData({
            "url" : value,
            "caption" : caption,
          });
          setState(() {
            downloadImages();
            captionController.text = "";
          });
    });
  }

  Future downloadImages() async {
    QuerySnapshot qn = await Firestore.instance.collection("photos").getDocuments();
    return qn.documents;
  }

  photoScreen(int index) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Column(children: <Widget>[
            FutureBuilder(
              future: downloadImages(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 200.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            color: Colors.black,
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.height,
                            child: Flex(
                              direction: Axis.vertical,
                              children: [Expanded(
                                  child: Hero(
                                    tag: "sharedImage$index",
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data[index].data["url"],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        Center(child: Container(
                                          width: 60.0, 
                                          height: 60.0,
                                          child: CircularProgressIndicator(),
                                        ),);
                                      },
                                    )
                                  ),
                                ),]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                            child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () => Navigator.of(context).pop(),
                              child: Icon(Icons.arrow_back, color: Colors.black,),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        alignment: Alignment.centerLeft,
                        child: Text(snapshot.data[index].data["caption"], 
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  );
                }
              },
              
            ),
          ],)
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text("Photos",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
      ),
      body: FutureBuilder(
        future: downloadImages(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return new StaggeredGridView.countBuilder(
                itemCount: snapshot.data.length,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: GestureDetector(
                        onTap: () {
                          photoScreen(index);
                        },
                        onLongPress: () {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Confirm Delete?", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                              ),
                              actions: <Widget>[
                                RawMaterialButton(
                                  child: Text("DELETE", style: TextStyle(fontWeight: FontWeight.w700)),
                                  onPressed: () {
                                   Firestore.instance
                                    .collection("photos")
                                    .document(snapshot.data[index].data["caption"])
                                    .delete()
                                    .then((value) => Navigator.of(context).pop());
                                    setState(() {
                                      downloadImages();
                                    });
                                  },
                                ),
                                RawMaterialButton(
                                  child: Text("CANCEL"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ) 
                              ],
                            );
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Hero(
                            tag: "sharedImage$index",
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data[index].data["url"],
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                Center(child: Container(
                                  width: 60.0, 
                                  height: 60.0,
                                  child: CircularProgressIndicator(),
                                ),);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                }
            );
          }
        }
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 40.0,),
          RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            onPressed: _addImage,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text("Add Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            fillColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}