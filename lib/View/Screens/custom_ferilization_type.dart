import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
import 'custom_fertlization_duration.dart';

class CustomFirtilizationTypesScreen extends StatefulWidget {
  final int lineIndex;
  final int valveId;
  const CustomFirtilizationTypesScreen(
      {Key? key, required this.lineIndex, required this.valveId})
      : super(key: key);

  @override
  State<CustomFirtilizationTypesScreen> createState() =>
      _CustomFirtilizationTypesScreenState();
}

class _CustomFirtilizationTypesScreenState
    extends State<CustomFirtilizationTypesScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station info.'),
      ),
      body: BlocProvider(
        create: (context) => CustomFertilizationCubit(authBloc)
          ..getNumberOfValvesOnly(serialNumber: serialNumber),
        child: SafeArea(
            child: BlocConsumer<CustomFertilizationCubit, CommonStates>(
          listener: (context, state) {
            CustomFertilizationCubit myCubit =
                CustomFertilizationCubit.get(context);
            if (state is CustomFertilizationPutSuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomFirtiliserSettingsScreen(
                      lineIndex: widget.lineIndex,
                      valveId: widget.valveId,
                      fertiliationType: myCubit.fertilizationType,
                    ),
                  ));
              if (state is CustomFertilizationPutFailState) {
                Navigator.pop(context);
                errorToast('An error has occurred');
              }
            } else if (state is CustomFertilizationPutFailState) {
              errorToast('An error has occurred');
            }
          },
          builder: (context, state) {
            CustomFertilizationCubit myCubit =
                CustomFertilizationCubit.get(context);
            return myCubit.featuresModel == null
                ? const Center(child: CircularProgressIndicator())
                : BlocListener<AuthBloc, CommonStates>(
                    listener: (context, state) {
                      if (state is ExpiredTokenState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        expiredTokenToast();
                      }
                      if (state is ServerDownState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        serverDownToast();
                      }
                    },
                    child: Column(
                      children: [
                        MainCard2(
                            mainWidget: DurationSettingsRow(
                                firstButtonTitle: text[chosenLanguage]![
                                    'Fertilizing by duration']!,
                                secondButtonTitle: text[chosenLanguage]![
                                    'Fertilizing by quantity']!,
                                firstButtonIcon: Center(
                                    child: Text(
                                  'g',
                                  style: TextStyle(
                                      fontFamily: 'icons',
                                      color: yellowColor,
                                      fontSize: 30),
                                )),
                                secondButtonIcon: Center(
                                    child: Text(
                                  'h',
                                  style: TextStyle(
                                      fontFamily: 'icons',
                                      color: yellowColor,
                                      fontSize: 30),
                                )),
                                firstButtonFunction: () {
                                  myCubit.chooseDuration();
                                },
                                secondButtonFunction: () {
                                  myCubit.chooseQuantity();
                                },
                                firstButtonColor: myCubit.isDuration == true
                                    ? selectedColor
                                    : Colors.white,
                                secondButtonColor: myCubit.isDuration == false
                                    ? selectedColor
                                    : Colors.white),
                            rowWidget: Text(
                              'y',
                              style: yellowIcon,
                            ),
                            function: () {
                              myCubit.putFertilizationType(
                                  lineIndex: widget.lineIndex,
                                  valveId: widget.valveId,
                                  stationId: stationId,
                                  fertilizationMethod:
                                      myCubit.fertilizationType);
                            },
                            cardtitle: 'Fertilization Settings',
                            buttonColor: yellowColor),
                      ],
                    ),
                  );
          },
        )),
      ),
    );
  }
}
