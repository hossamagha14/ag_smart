import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtilisers_settings_cubit.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/fertiliser_settings.dart';
import 'package:ag_smart/View/Screens/firtilisation_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirtilisationTypeScreen extends StatelessWidget {
  const FirtilisationTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                FirtiliserSettingsCubit myCubit =
                    FirtiliserSettingsCubit.get(context);
                return MainCard2(
                    mainWidget: DurationSettingsRow(
                        firstButtonTitle:
                            text[chosenLanguage]!['According to time']!,
                        secondButtonTitle:
                            text[chosenLanguage]!['According to quantity']!,
                        firstButtonIcon: Center(
                          child: Text(
                            'g',
                            style: mainIcon,
                          ),
                        ),
                        secondButtonIcon: Center(
                          child: Text(
                            'h',
                            style: mainIcon,
                          ),
                        ),
                        firstButtonFunction: () {
                          myCubit.firtiliseAccordingToTime();
                        },
                        secondButtonFunction: () {
                          myCubit.firtiliseAccordingToQuantity();
                        },
                        firstButtonColor: myCubit.accordingToTime == true
                            ? selectedColor
                            : Colors.white,
                        secondButtonColor: myCubit.accordingToTime == false
                            ? selectedColor
                            : Colors.white),
                    rowWidget: Text(
                      'y',
                      style: mainIcon,
                    ),
                    function: () {
                      if (myCubit.accordingToTime == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const FirtiliserSettingsScreen(),
                            ));
                      } else if (myCubit.accordingToTime == false) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FirtilisatiopnQuantityScreen(),
                            ));
                      } else {
                        errorToast('Please select firtilisation type');
                      }
                    },
                    cardtitle: text[chosenLanguage]!['Fertilizer Settings']!,
                    buttonColor: greenButtonColor);
              },
            )
          ],
        ),
      ),
    );
  }
}
