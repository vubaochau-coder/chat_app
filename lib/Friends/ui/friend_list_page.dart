import 'package:chat_app/Chat/ui/chat_page.dart';
import 'package:chat_app/Friends/bloc/friends_bloc.dart';
import 'package:chat_app/custom_page_route.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: themeColor,
        child: const Icon(
          Icons.person_add_alt,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: themeColor,
        title: const Text('Chat with friends'),
        titleTextStyle: TextStyle(
          color: themeColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
            icon: Icon(
              Icons.search,
              color: themeColor,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: themeColor.withOpacity(0.2),
              ),
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'U',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    'User name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              splashColor: themeColor.withOpacity(0.2),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: themeColor,
                ),
                title: const Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff49454F),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<FriendsBloc, FriendsState>(
        bloc: BlocProvider.of<FriendsBloc>(context)..add(FriendsLoadingEvent()),
        builder: (context, state) {
          if (state is FriendsLoadingState) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: themeColor,
                size: 60,
              ),
            );
          } else if (state is FriendsLoadingSuccessfulState) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: themeColor.withOpacity(0.2),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteSlideTransition(
                        child: ChatPage(
                          chatGroupID: state.friends[index].chatGroupID,
                          friendName: state.friends[index].name,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeColor.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        state.friends[index].name[0],
                        style: const TextStyle(
                          color: Color(0xff21005D),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    title: Text(
                      state.friends[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      state.friends[index].lastMessage == ''
                          ? "You and ${state.friends[index].name} have just become friends"
                          : state.friends[index].lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff49454F),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                );
              },
              itemCount: state.friends.length,
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: Icon(
          Icons.clear,
          color: themeColor,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        color: themeColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
