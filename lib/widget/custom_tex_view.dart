import 'package:flutter/material.dart';

class custom_texet_view extends StatelessWidget {
  const custom_texet_view({
    Key? key,
    required this.title,
    required this.subject,
    this.color,
  }) : super(key: key);

  final String title;
  final String subject;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          VerticalDivider(),
          Text(
            subject,
            style: TextStyle(fontSize: 20, color: color),
          )
        ],
      ),
    );
  }
}
