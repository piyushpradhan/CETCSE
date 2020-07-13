import 'package:cetcse/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  @override 
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var _currentUser;

  Future getNotices() async {
    QuerySnapshot qn = await Firestore.instance.collection("notices").getDocuments();
    return qn.documents;
  }

  loginAlertDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Login"),
        content: Container(
          height: 400.0,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Email"
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password"
                ),
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              
            ],
          ),
        ),
      );
    });
  }

  addNoticeDialog(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          title: Text("Add a new Notice below"),
          content: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Heading",
                  ),
                  maxLines: null,
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: "Details"
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 30.0,),
                RawMaterialButton(
                  child: Text("ADD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  fillColor: Colors.blueAccent,
                  onPressed: () {
                    if(titleController.text != null && descController.text != null) {
                      Firestore.instance
                        .collection("notices")
                        .document(titleController.text)
                        .setData({
                          "title" : titleController.text,
                          "desc" : descController.text
                        });
                        titleController.text = "";
                        descController.text = "";
                        setState(() {
                          getNotices();
                        });
                        Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Container(
            padding: EdgeInsets.fromLTRB(20.0, 35.0, 0.0, 5.0),
            child: Text("Notices", style: TextStyle(
              color: Colors.grey[800],
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            )),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 23.0, 0.0, 5.0),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.black,),
                onPressed: () {
                  addNoticeDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
      	future: getNotices(),
      	builder: (context, snapShot) {
      		if(snapShot.connectionState == ConnectionState.waiting) {
      			return Center(
      				child: CircularProgressIndicator(),
      			);
      		} else {
      			return ListView.builder(
      				itemCount: snapShot.data.length,
      				itemBuilder: (context, index) {
      					return Padding(
      					  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      					  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 3.0,
      					    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.white,
                      ),
      					    	child: ListTile(
      					    		title: Padding(
      					    		  padding: const EdgeInsets.only(bottom: 5.0),
      					    		  child: Text(snapShot.data[index].data["title"], style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
      					    	      ),  
                          ),
      					    	),
      					    	subtitle: Text(snapShot.data[index].data["desc"], style: TextStyle(
      					    		color: Colors.grey[500],
      					    	),),
                      trailing: IconButton(
                        onPressed: () {
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
                                    .collection("notices")
                                    .document(snapShot.data[index].data["title"])
                                    .delete()
                                    .then((value) => Navigator.of(context).pop());
                                    setState(() {
                                      getNotices();
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
                        icon: Icon(Icons.delete_outline)
                      ),
      					    	),
      					    ),
      					  ),
      					);
      				}
      			);
      		}
      	}
      ),
      
    );
  }
}

