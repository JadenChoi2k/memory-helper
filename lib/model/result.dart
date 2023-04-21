import 'package:memory_helper/model/problem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  final String? title;
  final List<Problem> problems;
  final List<String> answers;
  final List<bool> correct;
  final DateTime answerAt;

  Result({
    this.title,
    required this.problems,
    required this.answers,
    required this.correct,
    required this.answerAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  List<int> get score => [
        correct.fold(0, (prev, corr) => prev + (corr ? 1 : 0)),
        correct.length,
      ];

  List<Problem> get incorrectList =>
      List.generate(correct.length, (index) => index)
          .where((i) => !correct[i])
          .map((i) => problems[i])
          .toList();
}
