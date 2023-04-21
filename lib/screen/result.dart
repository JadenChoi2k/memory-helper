import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memory_helper/component/problem_card.dart';
import 'package:memory_helper/model/problem_set.dart';
import 'package:memory_helper/model/result.dart';
import 'package:intl/intl.dart';
import 'package:memory_helper/screen/problem_solve.dart';

class ResultScreen extends StatefulWidget {
  final Result result;
  const ResultScreen({required this.result, Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int pIndex = -1;

  void correctionNote() {
    final incorrectList = widget.result.incorrectList;
    if (incorrectList.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('모두 맞았습니다. 오답 노트는 필요 없습니다.'),
        ),
      );
      return;
    }
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ProblemSolveScreen(
            title: '${'${widget.result.title} '}오답 노트',
            problemSet: ProblemSet(problems: incorrectList..shuffle()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final score = widget.result.score;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${DateFormat('y/M/d hh:mm').format(widget.result.answerAt)} 결과'),
      ),
      body: Center(
        child: pIndex < 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '점수',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '${score[0]} / ${score[1]}',
                    style: const TextStyle(fontSize: 48.0),
                  ),
                  OutlinedButton(
                    onPressed: () => setState(() => pIndex = 0),
                    child: const Text(
                      '결과 보기',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  OutlinedButton(
                    onPressed: correctionNote,
                    child: const Text(
                      '오답 노트',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProblemCard(
                    num: pIndex + 1,
                    content: widget.result.problems[pIndex].question,
                  ),
                  const SizedBox(height: 16.0),
                  if (widget.result.correct[pIndex]) ...[
                    Text(
                      widget.result.problems[pIndex].answer,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 24.0,
                      ),
                    ),
                    const Text(
                      '정답!!',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                  if (!widget.result.correct[pIndex]) ...[
                    Text(
                      widget.result.answers[pIndex],
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                      ),
                    ),
                    const Text(
                      '오답..',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    Text('정답은 ${widget.result.problems[pIndex].answer}입니다'),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () => setState(() => pIndex--),
                        child: const Text(
                          '이전',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      if (pIndex == widget.result.problems.length - 1) ...[
                        const SizedBox(width: 4.0),
                        OutlinedButton(
                          onPressed: () => setState(() => pIndex = -1),
                          child: const Text(
                            '처음으로',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                      if (pIndex < widget.result.problems.length - 1) ...[
                        const SizedBox(width: 4.0),
                        OutlinedButton(
                          onPressed: () => setState(() => pIndex++),
                          child: const Text(
                            '다음',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ]
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
