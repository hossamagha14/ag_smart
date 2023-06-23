import 'package:ag_smart/View%20Model/Repo/auth_bloc.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Language/language_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Pump%20settings/pump_settingd_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Report/report_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/Scarcrow_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Stations/station_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/choose_language.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'View Model/bloc/Firtiliser settings/firtiliser_settings_cubit.dart';
import 'View Model/bloc/commom_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await CacheHelper.init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late AuthBloc authBloc;
  MyApp({super.key}) {
    authBloc = AuthBloc(IntialState());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PumpSettingsCubit(authBloc),
        ),
        BlocProvider(
          create: (context) => IrrigationTypeCubit(authBloc),
        ),
        BlocProvider(
          create: (context) => DurationSettingsCubit(authBloc),
        ),
        BlocProvider(
          create: (context) => FirtiliserSettingsCubit(authBloc),
        ),
        BlocProvider(
          create: (context) =>
              CustomIrrigationCubit(authBloc)..getNumberOfValves(),
        ),
        BlocProvider(
          create: (context) => ScarecrowCubit(authBloc),
        ),
        BlocProvider(
          create: (context) => StationsCubit(authBloc)..getStations(),
        ),
        BlocProvider(
          create: (context) => LightCubit(authBloc),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => CustomFertilizationCubit(authBloc),
        ),
        BlocProvider(
          create: (context) => ReportCubit(authBloc)..getStations(),
        ),
        BlocProvider(
          create: (context) => authBloc,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: iconColor),
                titleTextStyle: const TextStyle(
                    color: Color(0xFF575757),
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
                elevation: 0,
                color: backgroundColor,
                centerTitle: true)),
        home: isLanguageChosen == true
            ? SignInScreen()
            : const ChooseLanguageScreen(isEdit: false, chosenLanguageType: 0),
      ),
    );
  }
}
