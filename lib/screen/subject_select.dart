import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory_helper/component/list_button.dart';
import 'package:memory_helper/model/group.dart';
import 'package:memory_helper/model/problem.dart';
import 'package:memory_helper/model/problem_set.dart';
import 'package:memory_helper/model/subject.dart';
import 'package:memory_helper/screen/problem_solve.dart';

class SubjectSelectScreen extends StatelessWidget {
  final Group group;

  const SubjectSelectScreen({
    required this.group,
    Key? key,
  }) : super(key: key);

  ProblemSet generateProblemSet(Subject subject, int n) {
    if (n >= subject.problems.length) {
      return ProblemSet(problems: [...subject.problems]..shuffle());
    }
    print('random');
    final rand = Random();
    final selected = List.generate(subject.problems.length, (index) => false);
    final ret = <Problem>[];
    int cnt = 0;
    while (cnt < n) {
      final x = rand.nextInt(subject.problems.length);
      if (selected[x]) continue;
      selected[x] = true;
      ret.add(subject.problems[x]);
      cnt++;
    }
    return ProblemSet(problems: ret);
  }

  Widget challengeButton(BuildContext context, Subject subject) {
    final controller = TextEditingController(
      text: subject.problems.length.toString(),
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListButton(
        title: subject.name,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('개수를 입력해주세요'),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final num = int.parse(controller.value.text);
                    if (num <= 0) {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text('올바른 개수를 입력해주세요'),
                        ),
                      );
                      return;
                    }
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return ProblemSolveScreen(
                            title: subject.name,
                            problemSet: generateProblemSet(subject, num),
                          );
                        },
                      ),
                    );
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주제 선택'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [group.wholeSubject, ...group.subjects]
                .map((e) => challengeButton(context, e))
                .toList(),
          ),
        ),
      ),
    );
  }
}
