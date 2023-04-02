import 'package:memory_helper/model/problem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  final List<Problem> problems;
  final List<String> answers;
  final List<bool> correct;
  final DateTime answerAt = DateTime.now();

  Result({
    required this.problems,
    required this.answers,
    required this.correct,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  List<int> get score => [
        correct.fold(0, (prev, corr) => prev + (corr ? 1 : 0)),
        correct.length,
      ];
}
