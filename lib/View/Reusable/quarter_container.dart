import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/bloc/Report/report_cubit.dart';
import '../../View Model/bloc/Report/report_states.dart';

class QuarterContainer extends StatelessWidget {
  const QuarterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, ReportStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ReportCubit myCubit = ReportCubit.get(context);
        return Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.blue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.18),
                child: Text(
                  myCubit.quarter == null
                      ? 'Choose quarter'
                      : myCubit.quarter == 1
                          ? 'Jan, Feb, Mar'
                          : myCubit.quarter == 2
                              ? 'Apr, May, Jun'
                              : myCubit.quarter == 3
                                  ? 'Jul, Aug, Sep'
                                  : 'Oct, Nov, Dec',
                  style: TextStyle(fontSize: 21, color: iconColor),
                ),
              ),
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7),
                          bottomRight: Radius.circular(7)),
                      border: Border.all(color: Colors.blue),
                      color: Colors.blue.withOpacity(0.2)),
                  child: const Center(
                    child: Text(
                      'l',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'icons',
                          color: Colors.grey),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: BlocBuilder<ReportCubit, ReportStates>(
                            builder: (context, state) {
                              ReportCubit myCubit = ReportCubit.get(context);
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            myCubit.subtract();
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: iconColor,
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${myCubit.quarterYear}',
                                        style: TextStyle(
                                            fontSize: 30, color: iconColor),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            myCubit.add();
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: iconColor,
                                          ))
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      myCubit.firstQuarter();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text('Jan, Feb, Mar',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: iconColor))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      myCubit.secondQuarter();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text('Apr, May, Jun',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: iconColor))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      myCubit.thirdQuarter();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text('Jul, Aug, Sep',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: iconColor))),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      myCubit.fourthQuarter();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Text('Oct, Nov, Dec',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: iconColor))),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
