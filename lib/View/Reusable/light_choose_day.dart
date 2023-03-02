import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LightChooseDay extends StatelessWidget {
  const LightChooseDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LightCubit, LightStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LightCubit myCubit = LightCubit.get(context);
        return SizedBox(
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
                return InkWell(
                  onTap: () {
                    myCubit.chooseThisDay(index);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: myCubit.days[index].isOn! == false
                            ? Colors.white
                            : Colors.blue,
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      myCubit.days[index].day!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: myCubit.days[index].isOn! == false
                              ? Colors.blue
                              : Colors.white),
                    )),
                  ),
                );
              }),
        );
      },
    );
  }
}
