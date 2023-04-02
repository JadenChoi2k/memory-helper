import 'package:json_annotation/json_annotation.dart';

part 'problem.g.dart';

@JsonSerializable()
class Problem {
  final String question;
  final String answer;

  const Problem({required this.question, required this.answer});

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);
  Map<String, dynamic> toJson() => _$ProblemToJson(this);

  bool solve(String s) => answer == s;
}
