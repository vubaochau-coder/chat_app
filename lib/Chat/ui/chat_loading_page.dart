import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatLoadingPage extends StatelessWidget {
  const ChatLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: themeColor,
              size: 60,
            ),
          ),
        ),
        Container(
          height: 48,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: themeColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const Icon(
                Icons.send,
                color: Color(0xff49454F),
              )
            ],
          ),
        ),
      ],
    );
  }
}
