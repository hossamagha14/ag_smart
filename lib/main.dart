import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Language/language_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Pump%20settings/pump_settingd_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/Scarcrow_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Stations/station_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/choose_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'View Model/bloc/Firtiliser settings/firtiliser_settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PumpSettingsCubit(),
        ),
        BlocProvider(
          create: (context) =>
              LinesActivationCubit()..getNumberOfValves(stationId: 1),
        ),
        BlocProvider(
          create: (context) => IrrigationTypeCubit(),
        ),
        BlocProvider(
          create: (context) =>
              DurationSettingsCubit()..getPeriods(stationId: 1),
        ),
        BlocProvider(
          create: (context) => FirtiliserSettingsCubit(),
        ),
        BlocProvider(
          create: (context) =>
              CustomIrrigationCubit()..getNumberOfValves(stationId: 1),
        ),
        BlocProvider(
          create: (context) => ScarecrowCubit(),
        ),
        BlocProvider(
          create: (context) => LightCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => StationsCubit()..createDataBase(),
        ),
        BlocProvider(
          create: (context) =>
              CustomFertilizationCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme(
                titleTextStyle: const TextStyle(
                    color: Color(0xFF575757),
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
                elevation: 0,
                color: backgroundColor,
                centerTitle: true)),
        home: CacheHelper.getData(key: 'languageChoosen') == true
            ? const BottomNavBarScreen()
            : const ChooseLanguageScreen(isEdit: false),
      ),
    );
  }
}