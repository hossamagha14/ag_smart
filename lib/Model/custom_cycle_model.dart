class CustomCycleModel {
  int? valveId;
  int? interval;
  int? duration;
  int? quantity;
  int? weekDays;

  CustomCycleModel(
      {this.valveId,
      this.interval,
      this.duration,
      this.quantity,
      this.weekDays});

  CustomCycleModel.fromJson(Map<String, dynamic> json) {
    valveId = json['valve_id'];
    interval = json['interval'];
    duration = json['duration'];
    quantity = json['quantity'];
    weekDays = json['week_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valve_id'] = valveId;
    data['interval'] = interval;
    data['duration'] = duration;
    data['quantity'] = quantity;
    data['week_days'] = weekDays;
    return data;
  }
}