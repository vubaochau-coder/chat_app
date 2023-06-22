import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';

class ChatLeftItem extends StatelessWidget {
  final String message;
  const ChatLeftItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 0,
            maxWidth: 250,
          ),
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xff49454F),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
