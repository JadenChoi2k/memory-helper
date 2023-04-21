import 'package:flutter/material.dart';
import 'package:memory_helper/component/list_button.dart';
import 'package:memory_helper/model/history.dart';
import 'package:memory_helper/model/manager.dart';
import 'package:memory_helper/screen/result.dart';
import 'package:intl/intl.dart';

class HistoryListScreen extends StatelessWidget {
  Manager manager = Manager();

  History get history => manager.history;

  HistoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: history.history
                .map(
                  (r) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListButton(
                        title:
                            '${DateFormat('y/M/d hh:mm').format(r.answerAt)} ${r.title ?? ''}',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(result: r),
                            ),
                          );
                        }),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
