import 'dart:io';

import 'package:ag_smart/View%20Model/bloc/Report/report_states.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Model/range_model.dart';
import '../../../Model/report_station_model.dart';
import '../../../Model/station_model.dart';
import '../../../View/Reusable/text.dart';
import '../../database/dio_helper.dart';
import '../../database/end_points.dart';
import 'package:path_provider/path_provider.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(ReportIntialState());
  static ReportCubit get(context) => BlocProvider.of(context);

  DioHelper dio = DioHelper();
  String dropDownValue = 'Last 7 days';
  DateTime chosenYear = DateTime.now();
  double maxX = 31;
  double maxY = 100;
  List<RangeModel> ranges = [];
  List<FlSpot> spots = [];
  DateTime chosenMonth = DateTime.now();
  List<DateTime?>? chosenRange;
  int? quarter;
  int quarterYear = 2023;
  int reportStationId = stationId;
  StationModel? stationModel;
  List<StationModel> stations = [];
  ReportStationModel reportStationModel = ReportStationModel();
  String? currentStationName;
  List<String> dropDownValues = [
    'Last 7 days',
    'Last 15 days',
    'Last 30 days',
    'Monthly',
    'Yearly',
    'By Quarter',
    'Custom Range',
  ];

  Future<void> downloadPdf() async {
    try {
      // Create Dio instance
      Dio dio = Dio();

      // Define the URL for the POST request
      Response response = await dio.post(
        '$base/daily_records/range/pdf/1/18-4-2023/30-4-2023',
        options: Options(
            responseType: ResponseType.bytes,
            headers: {'Authorization': 'Bearer $token'}),
      );

      // Get the app's external storage directory path
      Directory? storageDir = await getExternalStorageDirectory();
      String storagePath = storageDir!.path;

      // Create the necessary directories
      Directory downloadsDir =
          await Directory('$storagePath/Download').create(recursive: true);

      // Define the file path and name for the downloaded PDF
      String pdfPath = '${downloadsDir.path}/example.pdf';

      // Write the PDF file to disk
      File pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(response.data, flush: true);

      // Show a notification that the download is complete
      print('PDF downloaded to: $pdfPath');
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  reguestPermission() async {
    final permission = await Permission.manageExternalStorage.request();
    if (permission.isGranted) {
      downloadPdf();
    }
  }

  chooseYear(DateTime value) {
    chosenYear = value;
    getYear();
    emit(ReportChooseYearState());
  }

  chooseRange(context) async {
    chosenRange = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        lastDate: DateTime.now(),
      ),
      dialogSize: Size(MediaQuery.of(context).size.width * 0.8,
          MediaQuery.of(context).size.width * 0.5),
      value: [DateTime.now(), DateTime.now()],
      borderRadius: BorderRadius.circular(15),
    );
    if (chosenRange != null) {
      getRange();
    }
    emit(ReportChooseRangeState());
  }

  chooseMonth(context) async {
    chosenMonth = (await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ))!;
    maxX = DateTime(chosenMonth.year, chosenMonth.month + 1, 0).day.toDouble();
    getMonth();
    emit(ReportChooseYearState());
  }

  chooseReport(String value) {
    dropDownValue = value;
    ranges = [];
    spots = [];
    maxY = 100;
    chosenRange = null;
    if (dropDownValue == 'Last 7 days') {
      get7days();
    } else if (dropDownValue == 'Last 15 days') {
      get15days();
    } else if (dropDownValue == 'Last 30 days') {
      get30days();
    } else if (dropDownValue == 'Monthly') {
      getMonth();
    } else if (dropDownValue == 'Yearly') {
      getYear();
    } else if (dropDownValue == 'By Quarter') {
      firstQuarter();
    }
    emit(ReportChooseDropDownValueState());
  }

  get7days() {
    DateTime start = DateTime.now().subtract(const Duration(days: 6));
    DateTime end = DateTime.now();
    int duration = end.difference(start).inDays;
    bool check = false;
    maxY = 100;
    dio
        .get(
            '$base/$dailyRecords/$reportStationId/${DateFormat('dd-MM-y').format(start)}/${DateFormat('dd-MM-y').format(end)}')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      print(duration);
      for (int i = 0; i <= duration; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('dd-MM-y').format(start.add(Duration(days: i))) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
  }

  get15days() {
    DateTime start = DateTime.now().subtract(const Duration(days: 14));
    DateTime end = DateTime.now();
    int duration = end.difference(start).inDays;
    bool check = false;
    maxY = 100;
    dio
        .get(
            '$base/$dailyRecords/$reportStationId/${DateFormat('dd-MM-y').format(start)}/${DateFormat('dd-MM-y').format(end)}')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      print(duration);
      for (int i = 0; i <= duration; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('dd-MM-y').format(start.add(Duration(days: i))) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
  }

  get30days() {
    DateTime start = DateTime.now().subtract(const Duration(days: 29));
    DateTime end = DateTime.now();
    int duration = end.difference(start).inDays;
    bool check = false;
    maxY = 100;
    dio
        .get(
            '$base/$dailyRecords/$reportStationId/${DateFormat('dd-MM-y').format(start)}/${DateFormat('dd-MM-y').format(end)}')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      print(duration);
      for (int i = 0; i <= duration; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('dd-MM-y').format(start.add(Duration(days: i))) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
  }

  getYear() {
    bool check = false;
    spots = [];
    ranges = [];
    maxY = 100;
    dio
        .get(
            '$base/$yearlyRecords/$reportStationId/${DateFormat('y').format(chosenYear)}')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      for (int i = 0; i < 12; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('MM-y').format(DateTime(
                  int.parse(DateFormat('y').format(chosenYear)), i + 1)) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
  }

  getMonth() {
    bool check = false;
    int duration =
        DateTime(chosenMonth.year, chosenMonth.month + 1, 0).day.toInt();
    maxX = duration.toDouble();
    print(duration);
    spots = [];
    ranges = [];
    maxY = 100;
    dio
        .get(
            '$base/$monthlyRecords/$reportStationId/${DateFormat('MM-y').format(chosenMonth)}')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      for (int i = 0; i < duration; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('dd-MM-y')
                  .format(chosenMonth.add(Duration(days: i))) ==
              ranges[j].date) {
            spots.add(FlSpot(i + 1.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i + 1.toDouble(), 0));
        }
        emit(ReportChooseRangeState());
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
  }

  getRange() {
    DateTime start = chosenRange![0]!;
    DateTime end = chosenRange![1]!;
    int duration = end.difference(start).inDays;
    bool check = false;
    maxY = 100;
    spots = [];
    ranges = [];
    dio
        .get(
            '$base/$dailyRecords/$reportStationId/${DateFormat('dd-MM-y').format(start)}/${DateFormat('dd-MM-y').format(end)}')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      print(duration);
      for (int i = 0; i <= duration; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('dd-MM-y').format(start.add(Duration(days: i))) ==
              ranges[j].date) {
            spots.add(FlSpot(
                double.parse(
                    DateFormat('dd').format(start.add(Duration(days: i)))),
                ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(
              double.parse(
                  DateFormat('dd').format(start.add(Duration(days: i)))),
              0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
  }

  firstQuarter() {
    quarter = 1;
    spots = [];
    ranges = [];
    maxY = 100;
    bool check = false;
    dio
        .get(
            '$base/$monthlyRange/$reportStationId/1-$quarterYear/3-$quarterYear')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      for (int i = 0; i <= 2; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('MM-y').format(DateTime(quarterYear, i + 1)) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
    emit(ReportChooseQuarterState());
  }

  secondQuarter() {
    quarter = 2;
    bool check = false;
    spots = [];
    ranges = [];
    maxY = 100;
    dio
        .get(
            '$base/$monthlyRange/$reportStationId/4-$quarterYear/6-$quarterYear')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      for (int i = 0; i <= 2; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('MM-y').format(DateTime(quarterYear, i + 4)) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
    emit(ReportChooseQuarterState());
  }

  thirdQuarter() {
    quarter = 3;
    bool check = false;
    maxY = 100;
    spots = [];
    ranges = [];
    dio
        .get(
            '$base/$monthlyRange/$reportStationId/7-$quarterYear/9-$quarterYear')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      for (int i = 0; i <= 2; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('MM-y').format(DateTime(quarterYear, i + 7)) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
    emit(ReportChooseQuarterState());
  }

  fourthQuarter() {
    quarter = 4;
    bool check = false;
    maxY = 100;
    spots = [];
    ranges = [];
    dio
        .get(
            '$base/$monthlyRange/$reportStationId/10-$quarterYear/12-$quarterYear')
        .then((value) {
      for (int i = 0; i < value.data.length; i++) {
        ranges.insert(0, RangeModel.fromJson(value.data[i]));
      }
      print(ranges[0].date);
      for (int i = 0; i <= 2; i++) {
        check = false;
        for (int j = 0; j < ranges.length; j++) {
          if (DateFormat('MM-y').format(DateTime(quarterYear, i + 10)) ==
              ranges[j].date) {
            spots.add(FlSpot(i.toDouble(), ranges[j].amount!.toDouble()));
            check = true;
          }
          if (maxY < ranges[j].amount!) {
            maxY = ranges[j].amount!.toDouble();
          }
        }
        if (check == false) {
          spots.add(FlSpot(i.toDouble(), 0));
        }
      }
      print(spots);
      print(maxY);
      emit(ReportChooseRangeState());
    }).catchError((onError) {});
    emit(ReportChooseQuarterState());
  }

  add() {
    if (quarterYear < 2023) {
      quarterYear += 1;
    }
    emit(ReportAddQuarterState());
  }

  subtract() {
    if (quarterYear > 2000) {
      quarterYear -= 1;
    }
    emit(ReportSubtractQuarterState());
  }

  getStations() {
    emit(ReportLoadinglState());
    reportStationModel.stationName = [];
    reportStationModel.reportStationId = [];
    dio.get('$base/$stationInfo/by_user/$userId').then((value) {
      for (var e in value.data) {
        stationModel = StationModel.fromJson(e);
        stations.add(stationModel!);
        reportStationModel.stationName.add(stationModel!.serialNumber!);
        reportStationModel.reportStationId.add(stationModel!.id!);
      }
      currentStationName = serialNumber;
      get7days();
      emit(ReportGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(ReportGetFailState());
    });
  }

  chooseStation(String value, int index) {
    currentStationName = value;
    reportStationId = reportStationModel.reportStationId[index];
    chooseReport(dropDownValue);
  }
}
