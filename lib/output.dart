import 'package:json_annotation/json_annotation.dart';

part 'output.g.dart';

@JsonSerializable()
class Output {
  String name;
  String answer;

  Output();

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  Map<String, dynamic> toJson() => _$OutputToJson(this);
}