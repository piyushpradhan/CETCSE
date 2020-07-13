import 'package:flutter/material.dart';
import 'package:cetcse/bunk_chart.dart';
import 'package:cetcse/bunk_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateBunkRecord extends StatefulWidget {
  @override
  _UpdateBunkState createState() => _UpdateBunkState();
}

class _UpdateBunkState extends State<UpdateBunkRecord> {

  final List<BunkSeries> data = [
    BunkSeries(
      subject: "Sub #1",
      bunked: 2,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BunkSeries(
      subject: "Sub #2",
      bunked: 6,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BunkSeries(
      subject: "Sub #3",
      bunked: 2,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BunkSeries(
      subject: "Sub #4",
      bunked: 1,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BunkSeries(
      subject: "Sub #5",
      bunked: 4,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Bunk Records"),
      ),
      
    );
  }
}