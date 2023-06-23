import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/bloc/Report/report_cubit.dart';
import '../../View Model/bloc/commom_states.dart';

class YearContainer extends StatelessWidget {
  const YearContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, CommonStates>(
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
                    left: MediaQuery.of(context).size.width * 0.28),
                child: Text(
                  myCubit.chosenYear.year.toString(),
                  style: TextStyle(fontSize: 28, color: iconColor),
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
                        title: const Text("Select Year"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: YearPicker(
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                            selectedDate: myCubit.chosenYear,
                            onChanged: (DateTime value) {
                              myCubit.chooseYear(value);
                              Navigator.pop(context);
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
