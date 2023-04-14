import 'package:flutter/material.dart';
import 'package:memory_helper/component/list_button.dart';
import 'package:memory_helper/model/group.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/model/subject.dart';
import 'package:memory_helper/screen/subject_problems.dart';

class GroupSubjectsScreen extends StatefulWidget {
  final String groupName;

  const GroupSubjectsScreen({required this.groupName, Key? key})
      : super(key: key);

  @override
  State<GroupSubjectsScreen> createState() => _GroupSubjectsScreenState();
}

class _GroupSubjectsScreenState extends State<GroupSubjectsScreen> {
  final Manager manager = Manager();

  Group get group => manager.findGroupByName(widget.groupName);

  Future<void> addSubjectPrompt() async {
    final textController = TextEditingController();

    void submit() {
      final text = textController.value.text;
      group.addSubject(Subject(name: text, problems: []));
      manager.save();
      setState(() {});
      Navigator.of(context).pop();
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('주제 추가'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: '주제 이름만 입력',
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
        title: Text('${widget.groupName} 주제들'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...manager.findGroupByName(widget.groupName).subjects.map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListButton(
                      title: e.name,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SubjectProblemsScreen(
                            groupName: widget.groupName,
                            subjectName: e.name,
                          ),
                        ),
                      ),
                      postfix: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('삭제하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    group.removeSubject(e.name);
                                    manager.save();
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('확인'),
                                )
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text('삭제'),
                      ),
                    ),
                  ),
                ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: addSubjectPrompt,
              child: const Text('주제 추가'),
            )
          ],
        ),
      ),
    );
  }
}
