import 'package:ag_smart/View%20Model/bloc/Device%20feature/device_feature_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Device%20feature/device_feature_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/pump_settings.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/main_icons_row_widget.dart';
import '../Reusable/toasts.dart';

class DeviceFeaturesScreen extends StatefulWidget {
  final bool isEdit;
  const DeviceFeaturesScreen({Key? key, required this.isEdit})
      : super(key: key);

  @override
  State<DeviceFeaturesScreen> createState() => _DeviceFeaturesScreenState();
}

class _DeviceFeaturesScreenState extends State<DeviceFeaturesScreen> {
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
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: BlocProvider(
        create: (context) => DeviceFeatureCubit(authBloc)..getFeatures(),
        child: BlocConsumer<DeviceFeatureCubit, CommonStates>(
          listener: (context, state) {},
          builder: (context, state) {
            DeviceFeatureCubit myCubit = DeviceFeatureCubit.get(context);
            return myCubit.stationModel == null ||
                    state is DeviceFeatureLoadingStateState
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.blue,
                  ))
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
                          buttonColor: greenButtonColor,
                          cardtitle: text[chosenLanguage]!['Device Features']!,
                          mainWidget: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.43,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return myCubit.featuresIntList[index] == 1
                                          ? const SizedBox(
                                              width: 0,
                                              height: 0,
                                            )
                                          : AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  myCubit.featureList[index]
                                                      .height!,
                                              decoration: BoxDecoration(
                                                  color: backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      textDirection:
                                                          chosenLanguage == 'ar'
                                                              ? TextDirection
                                                                  .rtl
                                                              : TextDirection
                                                                  .ltr,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          textDirection:
                                                              chosenLanguage == 'ar'
                                                                  ? TextDirection
                                                                      .rtl
                                                                  : TextDirection
                                                                      .ltr,
                                                          children: [
                                                            const CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              radius: 8,
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            Text(myCubit
                                                                .featureList[
                                                                    index]
                                                                .title!),
                                                          ],
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              myCubit.getInfo(
                                                                  index);
                                                            },
                                                            child: Text(
                                                              'p',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'icons',
                                                                  color:
                                                                      iconColor,
                                                                  fontSize: 18),
                                                            )),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 5, 31, 0),
                                                      child:
                                                          AnimatedDefaultTextStyle(
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: myCubit
                                                                .featureList[
                                                                    index]
                                                                .fontSize),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    0),
                                                        child: Text(
                                                          myCubit
                                                              .featureList[
                                                                  index]
                                                              .description!,
                                                          textDirection:
                                                              chosenLanguage == 'ar'
                                                                  ? TextDirection
                                                                      .rtl
                                                                  : TextDirection
                                                                      .ltr,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                    },
                                    separatorBuilder: (context, index) {
                                      return myCubit.featuresIntList[index] == 1
                                          ? const SizedBox(
                                              width: 0,
                                              height: 0,
                                            )
                                          : const SizedBox(
                                              height: 10,
                                            );
                                    },
                                    itemCount: myCubit.featureList.length),
                              )),
                          rowWidget: const MainIconsRowWidget(
                            icon1: 'm',
                          ),
                          function: () {
                            if (widget.isEdit == false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PumpSettingsScreen(
                                      isEdit: false,
                                    ),
                                  ));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        const Spacer()
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
