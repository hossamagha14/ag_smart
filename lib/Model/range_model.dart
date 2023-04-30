class RangeModel {
  int? stationId;
  String? date;
  int? amount;

  RangeModel({this.stationId, this.date, this.amount});

  RangeModel.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}
