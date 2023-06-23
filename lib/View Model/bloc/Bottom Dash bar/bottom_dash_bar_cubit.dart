import 'package:ag_smart/View%20Model/bloc/Bottom%20Dash%20bar/bottom_dash_bar_states.dart';
import 'package:ag_smart/View/Screens/dashboard.dart';
import 'package:ag_smart/View/Screens/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../../database/end_points.dart';
import '../commom_states.dart';

class BottomDashBarCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  BottomDashBarCubit(this.authBloc) : super(BottomDashBarIntialState()) {
    dio = DioHelper(authBloc);
  }

  static BottomDashBarCubit get(context) => BlocProvider.of(context);
  List<Widget> bottomDashBarScreens = [
    const DashsboardScreen(),
    ReportScreen()
  ];
  int index = 0;

  chooseIndex(int value) {
    index = value;
    emit(BottomDashBarChooseScreenState());
  }

  logout() {
    dio.post('$base/$logoutCall').then((value) {
      emit(BottomDashBarLogOutSuccessState());
    }).catchError((onError) {
      emit(BottomDashBarLogoutFailState());
    });
  }
}
