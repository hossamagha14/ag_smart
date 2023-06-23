import 'package:ag_smart/Model/device_feature_model.dart';
import 'package:ag_smart/View%20Model/bloc/Device%20feature/device_feature_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/station_model.dart';
import '../../../View/Reusable/text.dart';
import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../../database/end_points.dart';
import '../commom_states.dart';

class DeviceFeatureCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  DeviceFeatureCubit(this.authBloc) : super(DeviceFeatureIntialState()) {
    dio = DioHelper(authBloc);
  }

  static DeviceFeatureCubit get(context) => BlocProvider.of(context);

  List<DeviceFeatureModel> featureList = [
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dinternet'],
        title: text[chosenLanguage]!['internet'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dlinesNumber'],
        title: text[chosenLanguage]!['linesNumber'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dfertilizer'],
        title: text[chosenLanguage]!['fertilizer'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dlight'],
        title: text[chosenLanguage]!['light'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['danimal'],
        title: text[chosenLanguage]!['animal'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dpressure'],
        title: text[chosenLanguage]!['pressure'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dlevel'],
        title: text[chosenLanguage]!['level'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dauto'],
        title: text[chosenLanguage]!['auto'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dflow'],
        title: text[chosenLanguage]!['flow'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dleak'],
        title: text[chosenLanguage]!['leak'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dph'],
        title: text[chosenLanguage]!['ph'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dtds'],
        title: text[chosenLanguage]!['tds'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dtemp'],
        title: text[chosenLanguage]!['temp'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description: text[chosenLanguage]!['dhumidity'],
        title: text[chosenLanguage]!['humidity'],
        height: 0.06,
        isPressed: false,
        fontSize: 0),
  ];
  StationModel? stationModel;
  List<dynamic> featuresIntList = [];
  Map<String, dynamic> map = {};

  getInfo(int index) {
    if (featureList[index].isPressed == false) {
      featureList[index].height = 0.22;
      featureList[index].fontSize = 15;
      featureList[index].isPressed = true;
    } else {
      featureList[index].height = 0.06;
      featureList[index].fontSize = 0;
      featureList[index].isPressed = false;
    }
    emit(DeviceFeatureGetInfoState());
  }

  getFeatures() {
    emit(DeviceFeatureLoadingStateState());
    featuresIntList = [];
    map = {};
    dio.get('$base/$stationBySerial/$serialNumber').then((value) {
      stationModel = StationModel.fromJson(value.data);
      map = stationModel!.features![0].toJson();
      featuresIntList = map.values.toList();
      emit(DeviceFeatureGetSuccessStateState());
    }).catchError((onError) {
      emit(DeviceFeatureGetFailStateState());
    });
  }
}
