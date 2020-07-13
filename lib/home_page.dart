import 'dart:ui';

import 'package:cetcse/notice_page.dart';
import 'package:flutter/material.dart';
import 'package:cetcse/bunk_chart.dart';
import 'package:cetcse/bunk_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cetcse/update_bunk_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  get _updateBunkRecordScreen => null;

  @override 
  _HomePageState createState() => _HomePageState();

  void updateBunkRecordScreen() {}
}

class _HomePageState extends State<HomePage> {

  static TextEditingController subject_one = TextEditingController();
  TextEditingController subject_two = TextEditingController();
  TextEditingController subject_three = TextEditingController();
  TextEditingController subject_four = TextEditingController();
  TextEditingController subject_five = TextEditingController();

  int bunked_one, bunked_two, bunked_three, bunked_four, bunked_five;
  TextEditingController bunked_one_controller = TextEditingController();
  TextEditingController bunked_two_controller = TextEditingController();
  TextEditingController bunked_three_controller = TextEditingController();
  TextEditingController bunked_four_controller = TextEditingController();
  TextEditingController bunked_five_controller = TextEditingController();

  Future getBunkData() async {
    QuerySnapshot qn = await Firestore.instance.collection("updatebunkrecords").getDocuments();
    return qn.documents;
  }

  Future getNotices() async {
    QuerySnapshot qn = await Firestore.instance.collection("notices").getDocuments();
    return qn.documents;
  }

  Route updateBunkRecordScreen(int index) {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: () {Navigator.of(context).pop();},
                    icon: Icon(Icons.arrow_back, color: Colors.black)
                  ),
                ),
                elevation: 0.0,
                title: Text("Update Bunk Record", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                ),)
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: getBunkData(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          subject_one.text = snapshot.data[index].data["subject #1"].toString();
                          subject_two.text = snapshot.data[index].data["subject #2"].toString();
                          subject_three.text = snapshot.data[index].data["subject #3"].toString();
                          subject_four.text = snapshot.data[index].data["subject #4"].toString();
                          subject_five.text = snapshot.data[index].data["subject #5"].toString();

                          bunked_one_controller.text = snapshot.data[index].data["bunked_one"].toString();
                          bunked_two_controller.text = snapshot.data[index].data["bunked_two"].toString();
                          bunked_three_controller.text = snapshot.data[index].data["bunked_three"].toString();
                          bunked_four_controller.text = snapshot.data[index].data["bunked_four"].toString();
                          bunked_five_controller.text = snapshot.data[index].data["bunked_five"].toString();
                            return Column(
                            children: <Widget>[
                              BunkChart(data: (index == 0) ? data : (index == 1) ? data4 : (index == 2) ? data5 : data6),

                              SizedBox(height: 30.0),
                              //for the first subject
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 40.0),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5, bottom: 10),
                                        height: 40.0,
                                        child: TextField(
                                          autofocus: false,
                                          controller: subject_one,
                                          decoration: InputDecoration(labelText: "Subject #1",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height: 40.0,
                                      width: 80.0,
                                      child: TextField(
                                        autofocus: false,
                                        controller: bunked_one_controller, 
                                        decoration: InputDecoration(labelText: "Bunked",
                                          enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //for the second subject
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40.0),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5, bottom: 10),
                                        height: 40.0,
                                        child: TextField(
                                          autofocus: false,
                                          controller: subject_two,
                                          decoration: InputDecoration(labelText: "Subject #2",
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                              ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height: 40.0,
                                      width: 80.0,
                                      child: TextField(
                                        autofocus: false,
                                        controller: bunked_two_controller, 
                                        decoration: InputDecoration(labelText: "Bunked",
                                          enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //for the third subject
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40.0),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5, bottom: 10),
                                        height: 40.0,
                                        child: TextField(
                                          autofocus: false,
                                          controller: subject_three,
                                          decoration: InputDecoration(labelText: "Subject #3",
                                            enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),

                                    child: Container(
                                      height: 40.0,
                                      width: 80.0,
                                      child: TextField(
                                        autofocus: false,
                                        controller: bunked_three_controller, 
                                        decoration: InputDecoration(labelText: "Bunked",
                                          enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40.0),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5, bottom: 10),
                                        height: 40.0,
                                        child: TextField(
                                          autofocus: false,
                                          controller: subject_four,
                                          decoration: InputDecoration(labelText: "Subject #4",
                                            enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),

                                    child: Container(
                                      height: 40.0,
                                      width: 80.0,
                                      child: TextField(
                                        autofocus: false,
                                        controller: bunked_four_controller, 
                                        decoration: InputDecoration(labelText: "Bunked",
                                          enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40.0),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5, bottom: 10),
                                        height: 40.0,
                                        child: TextField(
                                          autofocus: false,
                                          controller: subject_five,
                                          decoration: InputDecoration(labelText: "Subject #5",
                                            enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),

                                    child: Container(
                                      height: 40.0,
                                      width: 80.0,
                                      child: TextField(
                                        autofocus: false,
                                        controller: bunked_five_controller, 
                                        decoration: InputDecoration(labelText: "Bunked",
                                          enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.grey, width: 1.0)
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: RawMaterialButton(
                                  fillColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  onPressed: () {
                                    Firestore.instance
                                      .collection("updatebunkrecords")
                                      .document("bunkrecords$index")
                                      .updateData({
                                        "subject #1" : subject_one.text,
                                        "subject #2" : subject_two.text,
                                        "subject #3" : subject_three.text,
                                        "subject #4" : subject_four.text,
                                        "subject #5" : subject_five.text,
                                        "bunked_one" : int.parse(bunked_one_controller.text),
                                        "bunked_two" : int.parse(bunked_two_controller.text),
                                        "bunked_three" : int.parse(bunked_three_controller.text),
                                        "bunked_four" : int.parse(bunked_four_controller.text),
                                        "bunked_five" : int.parse(bunked_five_controller.text)
                                      });
                                      setState(() {

                                      });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text("Update data for semester ${index + 3}", style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    ),
                  ),
                ),
              ),
            );
          }
        )
      );
    }

  List<BunkSeries> data;
  List<BunkSeries> data4;
  List<BunkSeries> data5;
  List<BunkSeries> data6;

  var date = new DateTime.now();

  final List<String> months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  final List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text("CSE 2023", style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 30.0),
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text("${date.day} ${months[date.month - 1]} ${date.year}", 
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Text(days[0], style: (date.weekday == 1) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                    Text(days[1], style: (date.weekday == 2) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                    Text(days[2], style: (date.weekday == 3) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                    Text(days[3], style: (date.weekday == 4) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                    Text(days[4], style: (date.weekday == 5) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                    Text(days[5], style: (date.weekday == 6) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                    Text(days[6], style: (date.weekday == 7) ? TextStyle(fontSize: 17.0, color: Colors.blueAccent, fontWeight: FontWeight.w600) : TextStyle() ),
                  ],),
                ],),
              ),
            ),
            SizedBox(height: 15.0),
            FutureBuilder(
              future: getBunkData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(child: CircularProgressIndicator(),)
                  );
                } else {
                  data = [
                    BunkSeries(
                      subject: snapshot.data[0].data["subject #1"].toString(),
                      bunked: snapshot.data[0].data["bunked_one"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[0].data["subject #2"].toString(),
                      bunked: snapshot.data[0].data["bunked_two"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[0].data["subject #3"].toString(),
                      bunked:snapshot.data[0].data["bunked_three"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[0].data["subject #4"].toString(),
                      bunked: snapshot.data[0].data["bunked_four"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[0].data["subject #5"].toString(),
                      bunked: snapshot.data[0].data["bunked_five"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                  ];

                   data4 = [
                    BunkSeries(
                      subject: snapshot.data[1].data["subject #1"].toString(),
                      bunked: snapshot.data[1].data["bunked_one"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[1].data["subject #2"].toString(),
                      bunked: snapshot.data[1].data["bunked_two"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[1].data["subject #3"].toString(),
                      bunked:snapshot.data[1].data["bunked_three"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[1].data["subject #4"].toString(),
                      bunked: snapshot.data[1].data["bunked_four"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[1].data["subject #5"].toString(),
                      bunked: snapshot.data[1].data["bunked_five"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                  ];

                  data5 = [
                    BunkSeries(
                      subject: snapshot.data[2].data["subject #1"].toString(),
                      bunked: snapshot.data[2].data["bunked_one"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[2].data["subject #2"].toString(),
                      bunked: snapshot.data[2].data["bunked_two"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[2].data["subject #3"].toString(),
                      bunked:snapshot.data[2].data["bunked_three"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[2].data["subject #4"].toString(),
                      bunked: snapshot.data[2].data["bunked_four"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[2].data["subject #5"].toString(),
                      bunked: snapshot.data[2].data["bunked_five"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                  ];

                  data6 = [
                    BunkSeries(
                      subject: snapshot.data[3].data["subject #1"].toString(),
                      bunked: snapshot.data[3].data["bunked_one"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[3].data["subject #2"].toString(),
                      bunked: snapshot.data[3].data["bunked_two"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[3].data["subject #3"].toString(),
                      bunked:snapshot.data[3].data["bunked_three"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[3].data["subject #4"].toString(),
                      bunked: snapshot.data[3].data["bunked_four"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                    BunkSeries(
                      subject: snapshot.data[3].data["subject #5"].toString(),
                      bunked: snapshot.data[3].data["bunked_five"],
                      barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
                    ),
                  ];
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 15.0,),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: BunkChart(data: data)
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 310.0,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                                  width: 30.0,
                                  height: 30.0,
                                  child: FloatingActionButton(
                                    heroTag: "first",
                                    child: Icon(Icons.open_in_new, size: 20.0,),
                                    onPressed: () {
                                      updateBunkRecordScreen(0);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Stack(
                          children: <Widget>[
                            BunkChart(data: data4),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 310.0,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                                  width: 30.0,
                                  height: 30.0,
                                  child: FloatingActionButton(
                                    heroTag: "second",
                                    child: Icon(Icons.open_in_new, size: 20.0,),
                                    onPressed: () {
                                      updateBunkRecordScreen(1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Stack(
                          children: <Widget>[
                            BunkChart(data: data5),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 310.0,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                                  width: 30.0,
                                  height: 30.0,
                                  child: FloatingActionButton(
                                    heroTag: "third",
                                    child: Icon(Icons.open_in_new, size: 20.0,),
                                    onPressed: () {
                                      updateBunkRecordScreen(2);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: BunkChart(data: data6)
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 310.0,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                                  width: 30.0,
                                  height: 30.0,
                                  child: FloatingActionButton(
                                    heroTag: "fourth",
                                    child: Icon(Icons.open_in_new, size: 20.0,),
                                    onPressed: () {
                                      updateBunkRecordScreen(3);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            SizedBox(height: 30.0,),

            FutureBuilder(
              future: getNotices(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator()
                    ),
                  );
                } else {
                  if(snapshot.data.length >= 5) {
                    return Column(
                    children: <Widget>[
                      Text("Notice", style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),),
                      SizedBox(height: 5.0,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 225.0,
                                  width: 150.0,
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(snapshot.data[0].data["title"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            height: 1.15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(snapshot.data[0].data["desc"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 225.0,
                                  width: 150.0,
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(snapshot.data[1].data["title"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            height: 1.15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(snapshot.data[1].data["desc"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 225.0,
                                  width: 150.0,
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(snapshot.data[2].data["title"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            height: 1.15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(snapshot.data[2].data["desc"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ), 
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 225.0,
                                  width: 150.0,
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(snapshot.data[3].data["title"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(snapshot.data[3].data["desc"],
                                        maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 225.0,
                                  width: 150.0,
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(snapshot.data[4].data["title"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                            height: 1.15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 25.0
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(snapshot.data[4].data["desc"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),  

                            SizedBox(width: 20.0),

                          ],
                        ),
                      ),
                    ],
                  );
                  } else {
                    return Column(
                    children: <Widget>[
                      Text("Notice", style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),),
                      SizedBox(height: 15.0,),
                      Text("No recent notices :)")
                    ],
                  );
                  }
                }
              },
            ),
            
          ],
        ),
      ),
    );
  }
}

