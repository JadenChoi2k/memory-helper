import 'package:flutter/material.dart';
import 'package:memory_helper/model/group.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/model/problem.dart';
import 'package:memory_helper/model/subject.dart';

class SubjectProblemsScreen extends StatefulWidget {
  final String groupName;
  final String subjectName;

  const SubjectProblemsScreen({
    required this.groupName,
    required this.subjectName,
    Key? key,
  }) : super(key: key);

  @override
  State<SubjectProblemsScreen> createState() => _SubjectProblemsScreenState();
}

class _SubjectProblemsScreenState extends State<SubjectProblemsScreen> {
  final Manager manager = Manager();

  Group get group => manager.findGroupByName(widget.groupName);
  Subject get subject => group.findSubjectByName(widget.subjectName);

  Widget problemWidget(Problem p) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            p.question,
            style: const TextStyle(fontSize: 28.0),
          ),
          const SizedBox(width: 8.0),
          const Text(
            '→',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            p.answer,
            style: const TextStyle(fontSize: 28.0),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            onPressed: () {
              subject.removeProblemByQuestion(p.question);
              setState(() {});
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      );

  Future<void> addProblemPrompt() async {
    final textController = TextEditingController();

    void submit() {
      final text = textController.value.text;
      if (!text.contains(':')) {
        return;
      }
      final q = text.split(':')[0];
      final a = text.split(':')[1];
      subject.addProblem(q, a);
      manager.save();
      setState(() {});
      Navigator.of(context).pop();
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('문제 추가'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: '질문:답 형태로 입력',
          ),
          onSubmitted: (val) => submit(),
        ),
        actions: [
          ElevatedButton(
            onPressed: submit,
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.groupName} > ${widget.subjectName} > 문제들'),
      ),
      body: Center(
        child: Column(
          children: [
            ...manager
                .findGroupByName(widget.groupName)
                .findSubjectByName(widget.subjectName)
                .problems
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: problemWidget(e),
                  ),
                ),
            ElevatedButton(
              onPressed: addProblemPrompt,
              child: const Text('문제 추가'),
            ),
          ],
        ),
      ),
    );
  }
}
