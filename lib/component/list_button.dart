import 'package:flutter/material.dart';

class ListButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const ListButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
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
    );
  }
}
