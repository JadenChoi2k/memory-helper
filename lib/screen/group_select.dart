import 'package:flutter/material.dart';
import 'package:memory_helper/component/list_button.dart';
import 'package:memory_helper/model/group.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/screen/subject_select.dart';

class GroupSelectScreen extends StatelessWidget {
  final manager = Manager();

  GroupSelectScreen({Key? key}) : super(key: key);

  Widget groupButton(BuildContext context, Group group) {
    return ListButton(
      title: group.name,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SubjectSelectScreen(group: group),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('그룹 선택'),
      ),
      body: Column(
        children: [manager.wholeGroup, ...manager.groups]
            .map((e) => groupButton(context, e))
            .toList(),
      ),
    );
  }
}
