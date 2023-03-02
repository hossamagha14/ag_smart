import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtilisers_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/Scarcrow_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/firtilisation_type.dart';
import 'package:ag_smart/View/Screens/light.dart';
import 'package:ag_smart/View/Screens/scarecrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'text_style.dart';

class FirScarLightWidget extends StatelessWidget {
  const FirScarLightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        children: [
          BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              FirtiliserSettingsCubit myCubit =
                  FirtiliserSettingsCubit.get(context);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirtilisationTypeScreen(),
                        ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: myCubit.done == false
                            ? Colors.white
                            : lightSelectedColor,
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(text[chosenLanguage]!['Fertilizer']!),
                        Text(
                          'y',
                          style: myCubit.done == false
                              ? smallIconOff
                              : smallIconOn,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          BlocConsumer<ScarecrowCubit, ScarecrowStates>(
            listener: (context, state) {},
            builder: (context, state) {
              ScarecrowCubit myCubit = ScarecrowCubit.get(context);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScarecrowScreen(),
                        ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: myCubit.done == false
                          ? Colors.white
                          : lightSelectedColor,
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(text[chosenLanguage]!['Scarecrow']!),
                        Text(
                          'z',
                          style: myCubit.done == false
                              ? smallIconOff
                              : smallIconOn,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          BlocConsumer<LightCubit, LightStates>(
            listener: (context, state) {},
            builder: (context, state) {
              LightCubit myCubit = LightCubit.get(context);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LightScreen(),
                        ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: myCubit.done == false
                            ? Colors.white
                            : lightSelectedColor,
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(text[chosenLanguage]!['Light']!),
                        Text(
                          'k',
                          style: myCubit.done == false
                              ? smallIconOff
                              : smallIconOn,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
