import 'package:ag_smart/View%20Model/bloc/Report/report_cubit.dart';
import 'package:ag_smart/View/Reusable/custom_container.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../View Model/bloc/Report/report_states.dart';
import '../Reusable/15days_chart.dart';
import '../Reusable/15days_container.dart';
import '../Reusable/30days_chart.dart';
import '../Reusable/30days_container.dart';
import '../Reusable/7days_chart.dart';
import '../Reusable/7days_container.dart';
import '../Reusable/colors.dart';
import '../Reusable/custom_chart.dart';
import '../Reusable/empty_chart.dart';
import '../Reusable/empty_container.dart';
import '../Reusable/monthContainer.dart';
import '../Reusable/month_chart.dart';
import '../Reusable/quarter_chart.dart';
import '../Reusable/quarter_container.dart';
import '../Reusable/text.dart';
import '../Reusable/year_chart.dart';
import '../Reusable/year_container.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => ReportCubit()..getStations(),
          child: BlocConsumer<ReportCubit, ReportStates>(
            listener: (context, state) {
              if (state is ReportPDFSuccessState) {
                successToast('PDF downloaded Successfully');
              } else if (state is ReportPDFFailState) {
                errorToast('an Error occured while downloading the PDF');
              }
            },
            builder: (context, state) {
              ReportCubit myCubit = ReportCubit.get(context);
              return myCubit.stationModel == null ||
                      state is ReportLoadinglState
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: backgroundColor),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: DropdownButton<String>(
                                          underline: const Divider(
                                            thickness: 0,
                                            color: Colors.transparent,
                                          ),
                                          hint: Center(
                                            child: Text(
                                              'Choose station',
                                              style: TextStyle(
                                                  color: iconColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: iconColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 35,
                                          ),
                                          items: myCubit
                                              .reportStationModel.stationName
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child:
                                                        Center(child: Text(e)),
                                                  ))
                                              .toList(),
                                          value: myCubit.currentStationName,
                                          onChanged: (value) {
                                            myCubit.chooseStation(
                                                value!,
                                                myCubit.reportStationModel
                                                    .stationName
                                                    .indexOf(value));
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025),
                                    myCubit.dropDownValue ==
                                            text[chosenLanguage]!['Yearly']!
                                        ? YearChart(
                                            spots: myCubit.spots,
                                            maxY: myCubit.maxY,
                                          )
                                        : myCubit.dropDownValue ==
                                                text[chosenLanguage]![
                                                    'Monthly']!
                                            ? MonthChart(
                                                numberOfDays: myCubit.maxX,
                                                spots: myCubit.spots,
                                                maxY: myCubit.maxY,
                                              )
                                            : myCubit.dropDownValue ==
                                                    text[chosenLanguage]![
                                                        'Last 7 days']!
                                                ? SevenDaysChart(
                                                    spots: myCubit.spots,
                                                    maxY: myCubit.maxY,
                                                  )
                                                : myCubit.dropDownValue ==
                                                        text[chosenLanguage]![
                                                            'Last 15 days']!
                                                    ? FifteenDaysChart(
                                                        maxY: myCubit.maxY,
                                                        spots: myCubit.spots)
                                                    : myCubit.dropDownValue ==
                                                            text[chosenLanguage]![
                                                                'Last 30 days']!
                                                        ? ThirtyDaysChart(
                                                            maxY: myCubit.maxY,
                                                            spots:
                                                                myCubit.spots)
                                                        : myCubit.dropDownValue ==
                                                                text[chosenLanguage]![
                                                                    'Custom Range']!
                                                            ? CustomChart(
                                                                maxY: myCubit
                                                                    .maxY,
                                                                spots: myCubit
                                                                    .spots,
                                                                start: myCubit.chosenRange == null
                                                                    ? 1
                                                                    : myCubit.chosenRange![0]!.day
                                                                        .toDouble(),
                                                                end: myCubit.chosenRange == null
                                                                    ? 31
                                                                    : myCubit.chosenRange![1]!.day
                                                                        .toDouble())
                                                            : myCubit.dropDownValue ==
                                                                    text[chosenLanguage]![
                                                                        'By Quarter']!
                                                                ? QuarterChart(
                                                                    maxY: myCubit
                                                                        .maxY,
                                                                    spots: myCubit.spots,
                                                                    quarter: myCubit.quarter ?? 1)
                                                                : const EmptyChart(),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border:
                                              Border.all(color: Colors.blue)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: DropdownButton<String>(
                                          underline: const Divider(
                                            thickness: 0,
                                            color: Colors.transparent,
                                          ),
                                          hint: Center(
                                            child: Text(
                                              'Choose duration',
                                              style: TextStyle(
                                                  color: iconColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: iconColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            size: 35,
                                          ),
                                          items: myCubit.dropDownValues
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child:
                                                        Center(child: Text(e)),
                                                  ))
                                              .toList(),
                                          value: myCubit.dropDownValue,
                                          onChanged: (value) {
                                            myCubit.chooseReport(value!);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    myCubit.dropDownValue ==
                                            text[chosenLanguage]![
                                                'Last 7 days']!
                                        ? const SevenDaysContainer()
                                        : myCubit.dropDownValue ==
                                                text[chosenLanguage]![
                                                    'Last 15 days']!
                                            ? const FifteenDaysContainer()
                                            : myCubit.dropDownValue ==
                                                    text[chosenLanguage]![
                                                        'Last 30 days']!
                                                ? const ThirtyDaysContainer()
                                                : myCubit.dropDownValue ==
                                                        text[chosenLanguage]![
                                                            'Yearly']!
                                                    ? const YearContainer()
                                                    : myCubit.dropDownValue ==
                                                            text[chosenLanguage]![
                                                                'Monthly']!
                                                        ? const MonthContainer()
                                                        : myCubit.dropDownValue ==
                                                                text[chosenLanguage]![
                                                                    'Custom Range']!
                                                            ? const CustomContainer()
                                                            : myCubit.dropDownValue ==
                                                                    text[chosenLanguage]![
                                                                        'By Quarter']!
                                                                ? const QuarterContainer()
                                                                : const EmptyContainer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.white,
                                          onTap: () async {
                                            final image =
                                                await screenshotController
                                                    .capture();
                                            if (image == null) return;
                                            await [Permission.storage]
                                                .request();
                                            final result =
                                                await ImageGallerySaver
                                                    .saveImage(image);
                                            successToast(
                                                'Screenshot saved to gallery');
                                            return result['filePath'];
                                          },
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  child: FittedBox(
                                                    child: Text(
                                                      'F',
                                                      style: TextStyle(
                                                          fontFamily: 'icons',
                                                          color: iconColor),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: FittedBox(
                                                    child: Text(
                                                      text[chosenLanguage]![
                                                          'Save screen']!,
                                                      style: TextStyle(
                                                          color: iconColor,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            myCubit.dropDownValue ==
                                                    text[chosenLanguage]![
                                                        'Monthly']!
                                                ? myCubit.downloadMonth()
                                                : myCubit.dropDownValue ==
                                                        text[chosenLanguage]![
                                                            'Yearly']!
                                                    ? myCubit.downloadYear()
                                                    : myCubit.dropDownValue ==
                                                            text[chosenLanguage]![
                                                                'By Quarter']!
                                                        ? myCubit
                                                            .downloadMonthRange()
                                                        : myCubit.download();
                                          },
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: FittedBox(
                                                    child: Text(
                                                      text[chosenLanguage]![
                                                          'Download']!,
                                                      style: TextStyle(
                                                        color: iconColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  child: FittedBox(
                                                    child: Text(
                                                      'E',
                                                      style: TextStyle(
                                                          fontFamily: 'icons',
                                                          color: iconColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
