import 'package:flutter/material.dart';
import 'package:memory_helper/component/list_button.dart';
import 'package:memory_helper/component/problem_card.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/model/problem_set.dart';
import 'package:memory_helper/screen/result.dart';

class ProblemSolveScreen extends StatefulWidget {
  final String title;
  final ProblemSet problemSet;

  const ProblemSolveScreen({
    required this.title,
    required this.problemSet,
    Key? key,
  }) : super(key: key);

  @override
  State<ProblemSolveScreen> createState() => _ProblemSolveScreenState();
}

class _ProblemSolveScreenState extends State<ProblemSolveScreen> {
  final controller = TextEditingController();
  final List<String> answers = [];
  int pIndex = 0;
  bool get isLast => widget.problemSet.problems.length - 1 == pIndex;

  @override
  void initState() {
    super.initState();
    for (final _ in widget.problemSet.problems) {
      answers.add('');
    }
  }

  void moveTo(int page) {
    controller.text = answers[page];
    setState(() => pIndex = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('문제 풀이: ${widget.title}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProblemCard(
              num: pIndex + 1,
              content: widget.problemSet.problems[pIndex].question,
            ),
            SizedBox(
              width: 240.0,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: '정답을 입력해주세요'),
                onChanged: (val) => answers[pIndex] = val,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (pIndex > 0) ...[
                  OutlinedButton(
                    onPressed: () => moveTo(pIndex - 1),
                    child: const Text(
                      '이전',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                ],
                if (!isLast)
                  OutlinedButton(
                    onPressed: () => moveTo(pIndex + 1),
                    child: const Text(
                      '다음',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                if (isLast)
                  OutlinedButton(
                    onPressed: () {
                      final result = widget.problemSet.solve(answers);
                      final manager = Manager();
                      manager.addHistory(result);
                      manager.save();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ResultScreen(
                            result: result,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      '제출!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
