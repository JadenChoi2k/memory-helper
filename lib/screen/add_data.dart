import 'package:flutter/material.dart';
import 'package:memory_helper/model/group.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/model/problem.dart';
import 'package:memory_helper/model/subject.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final manager = Manager();
  List<String> groupNames = [];
  String groupName = '';
  List<String> subjectNames = [];
  List<List<Map<String, String>>> problems = [];

  Group generateGroup() {
    return Group(
      name: groupName,
      subjects: List.generate(
        subjectNames.length,
        (index) => Subject(
          name: subjectNames[index],
          problems: List.generate(
            problems[index].length,
            (pIndex) => Problem(
              question: problems[index][pIndex]['problem'] ?? 'problem',
              answer: problems[index][pIndex]['answer'] ?? 'answer',
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget inputField(String title, void Function(String) onChanged,
          {Widget? suffix}) =>
      Row(
        children: [
          Text('$title:', style: const TextStyle(fontSize: 20.0)),
          const SizedBox(width: 16.0),
          Expanded(child: TextField(onChanged: onChanged)),
          if (suffix != null) suffix,
        ],
      );

  Widget subjectSection(int index) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        const Divider(color: Colors.grey),
        inputField(
          '주제${index + 1} 이름',
          (val) => subjectNames[index] = val,
          suffix: IconButton(
            onPressed: () => setState(() {
              subjectNames.removeAt(index);
              problems.removeAt(index);
            }),
            icon: const Icon(Icons.delete),
          ),
        ),
        ...List.generate(
          problems[index].length,
          (pIndex) => Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                    text: problems[index][pIndex]['problem'],
                  ),
                  decoration: InputDecoration(
                    hintText: '문제 ${pIndex + 1}',
                  ),
                  onChanged: (val) => problems[index][pIndex]['problem'] = val,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                    text: problems[index][pIndex]['answer'],
                  ),
                  decoration: InputDecoration(
                    hintText: '정답 ${pIndex + 1}',
                  ),
                  onChanged: (val) => problems[index][pIndex]['answer'] = val,
                ),
              ),
              IconButton(
                onPressed: () => setState(
                  () => problems[index].removeAt(pIndex),
                ),
                icon: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => setState(
              () => problems[index].add({'problem': '', 'answer': ''}),
            ),
            child: const Text('문제 추가'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('데이터 입력')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('그룹 이름:', style: TextStyle(fontSize: 20.0)),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextField(
                          onChanged: (val) => groupName = val,
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(subjectNames.length, subjectSection),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(
                        () {
                          subjectNames.add('');
                          problems.add([]);
                        },
                      ),
                      child: const Text('주제 추가'),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final generatedGroup = generateGroup();
                        manager.addGroup(generatedGroup);
                        manager.save();
                        Navigator.of(context).pop();
                      },
                      child: const Text('제출!'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
