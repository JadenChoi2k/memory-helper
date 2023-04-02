import 'package:memory_helper/model/problem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
  final String name;
  final List<Problem> problems;

  const Subject({required this.name, required this.problems});

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);

  /// name이 같은 Subject 객체끼리 결합.
  Subject merge(Subject subject) {
    return Subject(name: name, problems: problems + subject.problems);
  }
}
