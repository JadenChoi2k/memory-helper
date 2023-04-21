import 'package:memory_helper/model/problem.dart';
import 'package:memory_helper/model/result.dart';

class ProblemSet {
  final List<Problem> problems;

  ProblemSet({required this.problems});

  Result solve(List<String> answerList, {String? title}) {
    if (answerList.length != problems.length) {
      throw ArgumentError("입력된 정답의 길이가 올바르지 않습니다.");
    }
    return Result(
      title: title,
      problems: problems,
      answers: answerList,
      correct: List.generate(
        answerList.length,
        (index) => problems[index].solve(answerList[index]),
      ).toList(),
      answerAt: DateTime.now(),
    );
  }
}
