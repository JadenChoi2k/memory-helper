import 'package:flutter/material.dart';

class ListButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Widget? postfix;

  const ListButton({
    required this.title,
    required this.onPressed,
    this.postfix,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 460),
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                primary: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          if (postfix != null) ...[
            const SizedBox(width: 16.0),
            postfix!,
          ],
        ],
      ),
    );
  }
}
