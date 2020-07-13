import 'package:cetcse/update_bunk_record.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cetcse/bunk_series.dart';
import 'package:cetcse/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BunkChart extends StatelessWidget {
  final List<BunkSeries> data;

  BunkChart({@required this.data});

  @override
  Widget build(BuildContext context) {

    var homepage = HomePage();

    
    List<charts.Series<BunkSeries, String>> series = [
      charts.Series(
        id: "Bunked",
        data: data,
        domainFn: (BunkSeries bunkSeries, _) => bunkSeries.subject,
        measureFn: (BunkSeries bunkSeries, _) => bunkSeries.bunked,
        colorFn: (BunkSeries bunkSeries, _) => bunkSeries.barColor
      )
    ];
    
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Container(
        height: 220.0,
        width: 350.0,
        child:Column(
          children: <Widget>[
            Text("Classes Bunked in this semester"),
            Expanded(child: charts.BarChart(series)),
          ],
        ),
      ),
    );
  }
}