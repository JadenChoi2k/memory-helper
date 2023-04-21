import 'package:flutter/material.dart';

class ProblemCard extends StatelessWidget {
  final int num;
  final int? wholeSize;
  final String content;

  const ProblemCard({
    required this.num,
    this.wholeSize,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$num번 문제${wholeSize != null ? ' / $wholeSize개' : ''}'),
        const SizedBox(height: 8.0),
        Text(
          content,
          style: const TextStyle(
            fontSize: 48.0,
          ),
        )
      ],
    );
  }
}
