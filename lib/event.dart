import 'package:json_annotation/json_annotation.dart';
import 'package:Base64Decoder/output.dart';

part 'event.g.dart';

@JsonSerializable()

// TODO add the other properties of event here.
class Event {
  List<Output> responses = [];

  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}