class FriendModel {
  final String docID;
  final String chatGroupID;
  final String friendID;
  final String name;
  final String lastMessage;

  FriendModel({
    required this.friendID,
    required this.name,
    required this.lastMessage,
    required this.docID,
    required this.chatGroupID,
  });
}
