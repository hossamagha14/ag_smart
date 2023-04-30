import 'package:ag_smart/View%20Model/bloc/Report/report_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Report/report_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key}) : super(key: key);

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
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myCubit.chosenRange == null
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.06),
                        child: Text('Pick date range',
                            style: TextStyle(
                                color: iconColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500)),
                      )
                    : RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '${myCubit.chosenRange![1]!.difference(myCubit.chosenRange![0]!).inDays+1}',
                              style: TextStyle(
                                  color: iconColor,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text: ' Days',
                              style: TextStyle(
                                  color: iconColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ),
                const Spacer(),
                myCubit.chosenRange == null
                    ? const SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('d.MMM.y')
                                .format(myCubit.chosenRange![0]!),
                            style: TextStyle(
                                color: iconColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                              DateFormat('d.MMM.y')
                                  .format(myCubit.chosenRange![1]!),
                              style: TextStyle(
                                  color: iconColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
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
                    myCubit.chooseRange(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
