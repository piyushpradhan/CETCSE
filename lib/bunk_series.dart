import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class BunkSeries {
  String subject;
  int bunked;
  charts.Color barColor;

  BunkSeries({this.subject, this.bunked, this.barColor});
}

