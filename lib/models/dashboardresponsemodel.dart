import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DashBoardResponesModel {
  int? emergency;
  int? all_jobs;
  int? assigned_to_me;

  DashBoardResponesModel({
    this.emergency,
    this.all_jobs,
    this.assigned_to_me,
  });

  factory DashBoardResponesModel.fromJson(Map<String, dynamic> json) {
    return DashBoardResponesModel(
      emergency: json['emergency'] as int?,
      all_jobs: json['all_jobs'] as int?,
      assigned_to_me: json['assigned_to_me'] as int?,
    );
  }
}
