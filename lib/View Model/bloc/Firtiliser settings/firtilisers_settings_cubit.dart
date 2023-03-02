import 'package:ag_smart/Model/firtiliser_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firtiliser_settings_states.dart';

class FirtiliserSettingsCubit extends Cubit<FirtiliserSettingsStates> {
  FirtiliserSettingsCubit() : super(FirtiliserSettingsIntialState());

  static FirtiliserSettingsCubit get(context) => BlocProvider.of(context);

  int index = 1;
  List<String> dateStringList = [];
  List<String> timeStringList = [];
  FirtiliserModel firtiliserModel = FirtiliserModel();
  List<String> controllersStringList = [];
  bool done = false;
  bool? accordingToTime;

  chooseTime(value, int containerIndex) {
    firtiliserModel.timeList[containerIndex] = value;
    emit(FirtiliserSettingsChooseTimeState());
  }

  chooseDate(value, int containerIndex) {
    firtiliserModel.dateList[containerIndex] = value;
    emit(FirtiliserSettingsChooseDateState());
  }

  addContainer() {
    index++;
    firtiliserModel.dateList.add(DateTime.now());
    firtiliserModel.timeList.add(TimeOfDay.now());
    firtiliserModel.controllersList.add(TextEditingController());
    emit(FirtiliserSettingsAddContainerState());
  }

  removeContainer() {
    index--;
    firtiliserModel.dateList.remove(DateTime.now());
    firtiliserModel.timeList.remove(TimeOfDay.now());
    firtiliserModel.controllersList.remove(TextEditingController());
    emit(FirtiliserSettingsAddContainerState());
  }

  issDone() {
    done = true;
    emit(FirtiliserSettingsIsDoneState());
  }

  firtiliseAccordingToTime() {
    accordingToTime = true;
    emit(FirtiliserSettingsAccordingToTimeState());
  }

  firtiliseAccordingToQuantity() {
    accordingToTime = false;
    emit(FirtiliserSettingssAccordingToQuantityState());
  }

  getData(context) {
    dateStringList = [];
    timeStringList = [];
    controllersStringList = [];
    for (int i = 0; i < index; i++) {
      dateStringList.add(firtiliserModel.dateList[i].toString());
      timeStringList
          .add(firtiliserModel.timeList[i].format(context).toString());
      controllersStringList.add(firtiliserModel.controllersList[i].text);
    }
  }
}
