import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseDyasWidget extends StatelessWidget {
  final bool useFunction;
  const ChooseDyasWidget({Key? key, required this.useFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DurationSettingsCubit, DurationSettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DurationSettingsCubit myCubit = DurationSettingsCubit.get(context);
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
                  onTap: useFunction == true
                      ? () {
                          myCubit.chooseThisDay(index);
                        }
                      : null,
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
                        child: FittedBox(
                      child: Text(
                        myCubit.days[index].day!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myCubit.days[index].isOn! == false
                                ? Colors.blue
                                : Colors.white),
                      ),
                    )),
                  ),
                );
              }),
        );
      },
    );
  }
}
