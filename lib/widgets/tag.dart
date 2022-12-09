import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color tagColor;
  const Tag({Key? key, required this.text, required this.tagColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: tagColor,
            width: 4,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: tagColor,
          fontSize: 30,
        ),
      ),
    );
  }
}
