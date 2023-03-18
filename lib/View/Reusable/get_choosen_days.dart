import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_states.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetChooseDyasWidget extends StatelessWidget {
  const GetChooseDyasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
        return myCubit.activeDays.length < 7
            ? const ChooseDyasWidget(useFunction: false)
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.016,
                      );
                    },
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      print(myCubit.activeDays);
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: myCubit.activeDays[index] == 0
                                ? Colors.white
                                : Colors.blue,
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          myCubit.days[index].day!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myCubit.activeDays[index] == 0
                                  ? Colors.blue
                                  : Colors.white),
                        )),
                      );
                    }),
              );
      },
    );
  }
}
