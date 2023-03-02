import 'package:ag_smart/Model/device_feature_model.dart';
import 'package:ag_smart/View%20Model/bloc/Device%20feature/device_feature_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  ];

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
}
