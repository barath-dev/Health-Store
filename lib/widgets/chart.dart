import 'package:flutter/material.dart';
import 'package:healzero/core/theme/theme_helper.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SingleLineChart extends StatelessWidget {
  final List<dynamic> data;
  final String title;
  const SingleLineChart({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    print(data.toSet().toString() + "demoooo");

    // if(data[1] != null){
    //   print('No date');
    // }
    return Card(
      color: appTheme.lightGreen100,
      child: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
          enableSelectionZooming: true,
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          autoScrollingMode: AutoScrollingMode.start,
          interval: 5,
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(color: Colors.transparent),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
        ),
        primaryXAxis: DateTimeAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(
            text: title,
            textStyle: theme.textTheme.labelMedium!.copyWith(
              color: appTheme.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          dateFormat: DateFormat.MMMd(),
          intervalType: DateTimeIntervalType.auto,
          // labelRotation: 45,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          // be handled when the axis labels collide with each other.
          labelIntersectAction: AxisLabelIntersectAction.trim,
        ),
        series: <CartesianSeries<dynamic, DateTime>>[
          SplineSeries<dynamic, DateTime>(
            dataSource: data,
            xValueMapper: (dynamic data, _) => DateTime.tryParse(data['date']),
            yValueMapper: (dynamic data, _) => data['value'],
            name: "BMI",
            splineType: SplineType.monotonic,
            markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
            ),
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }
}

class DoubleLineChart extends StatelessWidget {
  final List<dynamic> data;
  final String title;

  const DoubleLineChart({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: appTheme.lightGreen100,
        child: SfCartesianChart(
          legend: Legend(
            isVisible: true,
            position: LegendPosition.top,
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            enableDoubleTapZooming: true,
            enableSelectionZooming: true,
          ),
          primaryYAxis: NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.x : point.y',
          ),
          primaryXAxis: DateTimeAxis(
            majorGridLines: MajorGridLines(width: 0),
            title: AxisTitle(
              text: title,
              textStyle: theme.textTheme.labelMedium!.copyWith(
                color: appTheme.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            dateFormat: DateFormat.MMMd(),
            // be handled when the axis labels collide with each other.

            interval: 10,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            intervalType: DateTimeIntervalType.auto,
            // labelRotation: 45,
            // be handled when the axis labels collide with each other.
            labelIntersectAction: AxisLabelIntersectAction.trim,
          ),
          series: <CartesianSeries<dynamic, DateTime>>[
            SplineSeries<dynamic, DateTime>(
              dataSource: data,
              xValueMapper: (dynamic data, _) {
                var dateString = data['range']['date'];
                return dateString != null
                    ? DateTime.parse(dateString)
                    : DateTime(1970, 1, 1);
              },
              yValueMapper: (dynamic data, _) => data['range']['max'],
              splineType: SplineType.monotonic,
              initialSelectedDataIndexes: [],
              name: "Systolic",
              isVisibleInLegend: true,
              markerSettings: MarkerSettings(
                  // isVisible: true,
                  // shape: DataMarkerType.diamond,
                  ),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
            ),
            SplineSeries<dynamic, DateTime>(
              dataSource: data,
              xValueMapper: (dynamic data, _) {
                var dateString = data['range']['date'];
                return dateString != null
                    ? DateTime.parse(dateString)
                    : DateTime(1970, 1, 1);
              },
              yValueMapper: (dynamic data, _) => data['range']['min'],
              name: "Diastolic",
              splineType: SplineType.monotonic,
              markerSettings: MarkerSettings(
                  // isVisible: true,
                  // shape: DataMarkerType.circle,
                  ),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
            ),
          ],
        ),
      ),
    );
  }
}

class SingleLineMiniChart extends StatelessWidget {
  final List<dynamic> data;

  const SingleLineMiniChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          labelStyle: TextStyle(color: Colors.transparent),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
          isVisible: false,
        ),
        primaryYAxis: NumericAxis(
          labelStyle: TextStyle(color: Colors.transparent),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
          isVisible: false,
        ),
        series: [
          SplineSeries<dynamic, DateTime>(
              splineType: SplineType.monotonic,
              dataSource: data,
              xValueMapper: (dynamic data, _) =>
                  DateTime.tryParse(data['date']),
              yValueMapper: (dynamic data, _) => data['value'],
              color: appTheme.amber600),
        ],
      ),
    );
  }
}

class DoubleLineMiniChart extends StatelessWidget {
  final List<dynamic> data;

  const DoubleLineMiniChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          labelStyle: TextStyle(color: Colors.transparent),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
          isVisible: false,
        ),
        primaryYAxis: NumericAxis(
          labelStyle: TextStyle(color: Colors.transparent),
          majorGridLines: MajorGridLines(width: 0),
          axisLine: AxisLine(width: 0),
          isVisible: false,
        ),
        series: [
          LineSeries<dynamic, DateTime>(
            dataSource: [],
            xValueMapper: (dynamic data, _) =>
                DateTime.parse(data['range']['date']),
            yValueMapper: (dynamic data, _) => data['range']['max'],
            name: 'Systolic',
            color: appTheme.lightGreen100,
          ),
          SplineSeries<dynamic, DateTime>(
            splineType: SplineType.monotonic,
            dataSource: data,
            xValueMapper: (dynamic data, _) =>
                DateTime.parse(data['range']['date']),
            yValueMapper: (dynamic data, _) => data['range']['min'],
            name: 'Diastolic',
            color: appTheme.amber600,
          ),
        ],
      ),
    );
  }
}
