// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..responses = (json['responses'] as List)
        ?.map((e) =>
            e == null ? null : Output.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EventToJson(Event instance) =>
    <String, dynamic>{'responses': instance.responses};
