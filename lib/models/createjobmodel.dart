import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateJobResponseModel {
  List<CreateJobResponseModel>? list;
  String? id;
  String? name;
  String? address;

  CreateJobResponseModel({
    this.list,
    this.id,
    this.name,
    this.address,
  });

  factory CreateJobResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateJobResponseModel(
      list: List<CreateJobResponseModel>.from(
          json["list"].map((x) => CreateJobResponseModel.fromJson(x))),
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
    );
  }
  Map<String, dynamic> tojson() {
    return {
      "list": List<dynamic>.from(list!.map((x) => x.tojson())),
      'id': id,
      'name': name,
      'address': address
    };
  }
}
