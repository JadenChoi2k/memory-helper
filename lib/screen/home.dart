import 'package:flutter/material.dart';
import 'package:memory_helper/screen/add_data.dart';
import 'package:memory_helper/screen/group_select.dart';

class HomeScreen extends StatelessWidget {
  static const buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  const HomeScreen({Key? key}) : super(key: key);

  Widget get title => const Text(
        '메모리헬퍼',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget buttonText(String s) => Text(s, style: buttonTextStyle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title,
            const SizedBox(height: 16.0),
            SizedBox(
              width: 160,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GroupSelectScreen(),
                  ),
                ),
                child: buttonText('문제 풀기'),
              ),
            ),
            // const SizedBox(height: 4.0),
            // SizedBox(
            //   width: 160,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: buttonText('둘러보기'),
            //   ),
            // ),
            const SizedBox(height: 4.0),
            SizedBox(
              width: 160,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddDataScreen(),
                  ),
                ),
                child: buttonText('데이터 추가'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
