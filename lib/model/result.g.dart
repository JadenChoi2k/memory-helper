// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      title: json['title'] as String?,
      problems: (json['problems'] as List<dynamic>)
          .map((e) => Problem.fromJson(e as Map<String, dynamic>))
          .toList(),
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      correct:
          (json['correct'] as List<dynamic>).map((e) => e as bool).toList(),
      answerAt: DateTime.parse(json['answerAt'] as String),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'title': instance.title,
      'problems': instance.problems,
      'answers': instance.answers,
      'correct': instance.correct,
      'answerAt': instance.answerAt.toIso8601String(),
    };
