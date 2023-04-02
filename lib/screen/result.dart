import 'package:flutter/material.dart';
import 'package:memory_helper/component/problem_card.dart';
import 'package:memory_helper/model/result.dart';

class ResultScreen extends StatefulWidget {
  final Result result;
  const ResultScreen({required this.result, Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int pIndex = -1;

  @override
  Widget build(BuildContext context) {
    final score = widget.result.score;
    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
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
