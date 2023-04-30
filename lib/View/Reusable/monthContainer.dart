import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../View Model/bloc/Report/report_cubit.dart';
import '../../View Model/bloc/Report/report_states.dart';
import 'colors.dart';

class MonthContainer extends StatelessWidget {
  const MonthContainer({Key? key}) : super(key: key);

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
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Text(
                DateFormat('MMMM.y').format(myCubit.chosenMonth).toString(),
                style: TextStyle(fontSize: 25, color: iconColor),
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
                  myCubit.chooseMonth(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
