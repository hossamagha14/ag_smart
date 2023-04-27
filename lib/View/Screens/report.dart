import 'package:ag_smart/View/Reusable/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/Bottom navigation bar/bottom_nav_bar_cubit.dart';
import '../../View Model/bloc/commom_states.dart';
import '../Reusable/7days_chart.dart';
import '../Reusable/7days_container.dart';
import '../Reusable/colors.dart';
import '../Reusable/custom_chart.dart';
import '../Reusable/monthContainer.dart';
import '../Reusable/month_chart.dart';
import '../Reusable/year_chart.dart';
import '../Reusable/year_container.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: BlocConsumer<BottomNavBarCubit, CommonStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
          return BlocConsumer<BottomNavBarCubit, CommonStates>(
            listener: (context, state) {},
            builder: (context, state) {
              BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
              return SingleChildScrollView(
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
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: backgroundColor),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.025),
                              myCubit.dropDownValue == 'Yearly'
                                  ? const YearChart()
                                  : myCubit.dropDownValue == 'Monthly'
                                      ? MonthChart(
                                          numberOfDays: myCubit.maxX,
                                        )
                                      : myCubit.dropDownValue == 'Last 7 days'
                                          ? const SevenDaysChart()
                                          : CustomChart(
                                              start: myCubit.start,
                                              end: myCubit.end),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(color: Colors.blue)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: DropdownButton<String>(
                                    underline: const Divider(
                                      thickness: 0,
                                      color: Colors.transparent,
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
                                              child: Center(child: Text(e)),
                                            ))
                                        .toList(),
                                    value: myCubit.dropDownValue,
                                    onChanged: (value) {
                                      myCubit.chooseReport(value!);
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              myCubit.dropDownValue == 'Last 7 days'
                                  ? const SevenDaysContainer()
                                  : myCubit.dropDownValue == 'Yearly'
                                      ? const YearContainer()
                                      : myCubit.dropDownValue == 'Monthly'
                                          ? const MonthContainer()
                                          : const CustomContainer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Row(
                                        children: [
                                          Text(
                                            's',
                                            style: TextStyle(
                                                fontFamily: 'icons',
                                                fontSize: 35,
                                                color: iconColor),
                                          ),
                                          Text(
                                            'Save Screen',
                                            style: TextStyle(
                                                color: iconColor, fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Save Screen',
                                            style: TextStyle(
                                                color: iconColor, fontSize: 20),
                                          ),
                                          Text(
                                            'd',
                                            style: TextStyle(
                                                fontFamily: 'icons',
                                                fontSize: 35,
                                                color: iconColor),
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
          );
        },
      ),
    );
  }
}
