import 'package:ag_smart/Model/device_feature_model.dart';
import 'package:ag_smart/View%20Model/bloc/Device%20feature/device_feature_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/station_model.dart';
import '../../../View/Reusable/text.dart';
import '../../database/dio_helper.dart';
import '../../database/end_points.dart';

class DeviceFeatureCubit extends Cubit<DeviceFeaturesStates> {
  DeviceFeatureCubit() : super(DeviceFeatureIntialState());
  static DeviceFeatureCubit get(context) => BlocProvider.of(context);

  List<DeviceFeatureModel> featureList = [
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
    DeviceFeatureModel(
        description:
            'تقوم بقياس ضغط الماء و تحديد مستوي الضغط المناسب للساقية, و تسلعد في ضبط نوع الساقية تبعًا لتغير ضغط الماء.',
        title: 'وحدة قياس ضغط الماء',
        height: 0.06,
        isPressed: false,
        fontSize: 0),
  ];
  DioHelper dio = DioHelper();
  StationModel? stationModel;
  List<dynamic> featuresIntList = [];
  Map<String, dynamic> map = {};

  getInfo(int index) {
    if (featureList[index].isPressed == false) {
      featureList[index].height = 0.18;
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
      print(featuresIntList);
      emit(DeviceFeatureGetSuccessStateState());
    }).catchError((onError) {
      emit(DeviceFeatureGetFailStateState());
    });
  }
}
