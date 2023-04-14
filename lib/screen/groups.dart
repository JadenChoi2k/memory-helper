import 'package:flutter/material.dart';
import 'package:memory_helper/component/list_button.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/screen/group_subjects.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final Manager manager = Manager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('문제 그룹'),
      ),
      body: manager.groups.isEmpty
          ? const Text('데이터가 없습니다')
          : SingleChildScrollView(
              child: Column(
                children: manager.groups
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListButton(
                          title: e.name,
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  GroupSubjectsScreen(groupName: e.name),
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
                                        manager.removeGroup(e.name);
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
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: Text('삭제'),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
