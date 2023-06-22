import 'package:chat_app/Chat/bloc/chat_bloc.dart';
import 'package:chat_app/Chat/ui/chat_left_item.dart';
import 'package:chat_app/Chat/ui/chat_loading_page.dart';
import 'package:chat_app/Chat/ui/chat_right_item.dart';
import 'package:chat_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String chatGroupID;
  final String friendName;
  const ChatPage(
      {super.key, required this.chatGroupID, required this.friendName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ChatBloc>(context)
        .add(ChatLoadingEvent(chatGroupID: widget.chatGroupID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: themeColor,
        title: Text(widget.friendName),
        titleTextStyle: TextStyle(
          color: themeColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadingSuccessfulState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.messaages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      if (state.messaages[index].sendByMe) {
                        return ChatRightItem(
                            message: state.messaages[index].message);
                      } else {
                        return ChatLeftItem(
                            message: state.messaages[index].message);
                      }
                    },
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 16, right: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messController,
                          decoration: messInputDecoration('Aa'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (messController.text.trim().isNotEmpty) {
                            String mess = messController.text.trim();
                            BlocProvider.of<ChatBloc>(context)
                                .add(ChatSendMessageEvent(
                              message: mess,
                              groupID: widget.chatGroupID,
                            ));
                            messController.clear();
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color(0xff49454F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const ChatLoadingPage();
          }
        },
      ),
    );
  }
}
