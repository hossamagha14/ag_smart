class FertlizationModel {
  int? periodId;
  int? valveId;
  int? startingTime;
  int? duration;
  int? quantity;
  int? date;

  FertlizationModel(
      {this.periodId,
      this.valveId,
      this.startingTime,
      this.duration,
      this.quantity,
      this.date});

  FertlizationModel.fromJson(Map<String, dynamic> json) {
    periodId = json['period_id'];
    valveId = json['valve_id'];
    startingTime = json['starting_time'];
    duration = json['duration'];
    quantity = json['quantity'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_id'] = periodId;
    data['valve_id'] = valveId;
    data['starting_time'] = startingTime;
    data['duration'] = duration;
    data['quantity'] = quantity;
    data['date'] = date;
    return data;
  }
}