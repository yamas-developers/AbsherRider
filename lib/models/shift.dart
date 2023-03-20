class Shift {
  int? id;
  int? zoneId;
  String? description;
  String? startTime;
  String? endTime;
  String? shiftDate;
  int? deliveryMan;
  String? status;
  String? shiftStartedAt;
  String? shiftEndedAt;
  String? createdAt;
  String workingStatus = '';
  bool isTaken = false;

  Shift(
      {this.id,
        this.zoneId,
        this.description,
        this.startTime,
        this.endTime,
        this.shiftDate,
        this.deliveryMan,
        this.status,
        this.shiftStartedAt,
        this.shiftEndedAt,
        this.createdAt,
        });

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneId = json['zone_id'];
    description = json['description'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    shiftDate = json['shift_date'];
    deliveryMan = json['delivery_man'];
    status = json['status'];
    shiftStartedAt = json['shift_started_at'];
    shiftEndedAt = json['shift_ended_at'];
    createdAt = json['created_at'];
    if(json['working_status'] != null)
      workingStatus = json['working_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zone_id'] = this.zoneId;
    data['description'] = this.description;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['shift_date'] = this.shiftDate;
    data['delivery_man'] = this.deliveryMan;
    data['status'] = this.status;
    data['shift_started_at'] = this.shiftStartedAt;
    data['shift_ended_at'] = this.shiftEndedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}