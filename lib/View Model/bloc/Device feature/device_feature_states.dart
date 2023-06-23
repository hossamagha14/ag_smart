import '../commom_states.dart';

abstract class DeviceFeaturesStates extends CommonStates{}

class DeviceFeatureIntialState extends DeviceFeaturesStates {}

class DeviceFeatureGetInfoState extends DeviceFeaturesStates {}

class DeviceFeatureGetSuccessStateState extends DeviceFeaturesStates {}

class DeviceFeatureGetFailStateState extends DeviceFeaturesStates {}

class DeviceFeatureLoadingStateState extends DeviceFeaturesStates {}
