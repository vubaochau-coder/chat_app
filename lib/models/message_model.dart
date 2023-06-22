class MessageModel {
  final String id;
  final String message;
  final DateTime sendingTime;
  final bool sendByMe;

  MessageModel({
    required this.id,
    required this.message,
    required this.sendingTime,
    required this.sendByMe,
  });

  static List<MessageModel> temp = [
    MessageModel(
      id: '1',
      message: 'Hello Spider Man!',
      sendingTime: DateTime(2023, 6, 20, 9, 30),
      sendByMe: false,
    ),
    MessageModel(
      id: '2',
      message: 'Hey Bat Man! How are you doing?',
      sendingTime: DateTime(2023, 6, 20, 9, 32),
      sendByMe: true,
    ),
    MessageModel(
      id: '3',
      message: 'I\'m good, thanks! Just fighting crime as usual.',
      sendingTime: DateTime(2023, 6, 20, 9, 35),
      sendByMe: false,
    ),
    MessageModel(
      id: '4',
      message: 'That\'s great! Keep up the good work.',
      sendingTime: DateTime(2023, 6, 20, 9, 37),
      sendByMe: true,
    ),
    MessageModel(
      id: '5',
      message: 'Spider Man, have you heard about the new villain in town?',
      sendingTime: DateTime(2023, 6, 20, 9, 40),
      sendByMe: true,
    ),
    MessageModel(
      id: '6',
      message: 'No, what\'s going on?',
      sendingTime: DateTime(2023, 6, 20, 9, 42),
      sendByMe: false,
    ),
    MessageModel(
      id: '7',
      message: 'They call themselves "The Joker". We need to stop them.',
      sendingTime: DateTime(2023, 6, 20, 9, 45),
      sendByMe: true,
    ),
    MessageModel(
      id: '8',
      message: 'I\'m in. Let\'s catch this Joker!',
      sendingTime: DateTime(2023, 6, 20, 9, 47),
      sendByMe: false,
    ),
    MessageModel(
      id: '9',
      message: 'Bat Man, I have some information about The Joker\'s hideout.',
      sendingTime: DateTime(2023, 6, 20, 9, 50),
      sendByMe: true,
    ),
    MessageModel(
      id: '10',
      message: 'That\'s great, Spider Man! Share the details with me.',
      sendingTime: DateTime(2023, 6, 20, 9, 52),
      sendByMe: false,
    ),
    MessageModel(
      id: '11',
      message: 'I\'ve gathered some information about The Joker\'s henchmen.',
      sendingTime: DateTime(2023, 6, 20, 10, 0),
      sendByMe: true,
    ),
    MessageModel(
      id: '12',
      message: 'Excellent! We need to find out their plans.',
      sendingTime: DateTime(2023, 6, 20, 10, 2),
      sendByMe: false,
    ),
    MessageModel(
      id: '13',
      message: 'Agreed. Let\'s meet up at the Bat Cave tonight.',
      sendingTime: DateTime(2023, 6, 20, 10, 5),
      sendByMe: true,
    ),
    MessageModel(
      id: '14',
      message: 'I\'ll be there. See you tonight!',
      sendingTime: DateTime(2023, 6, 20, 10, 7),
      sendByMe: false,
    ),
    MessageModel(
      id: '15',
      message:
          'Spider Man, I\'ve received a distress call from the police. They need our help!',
      sendingTime: DateTime(2023, 6, 20, 10, 10),
      sendByMe: true,
    ),
    MessageModel(
      id: '16',
      message: 'I\'m on my way. We can deal with The Joker later.',
      sendingTime: DateTime(2023, 6, 20, 10, 12),
      sendByMe: false,
    ),
    MessageModel(
      id: '17',
      message: 'The situation is under control. Thanks for your assistance.',
      sendingTime: DateTime(2023, 6, 20, 10, 20),
      sendByMe: true,
    ),
    MessageModel(
      id: '18',
      message: 'Glad to help. Let me know if you need any more support.',
      sendingTime: DateTime(2023, 6, 20, 10, 22),
      sendByMe: false,
    ),
    MessageModel(
      id: '19',
      message:
          'Spider Man, let\'s continue our investigation on The Joker tonight.',
      sendingTime: DateTime(2023, 6, 20, 10, 25),
      sendByMe: true,
    ),
    MessageModel(
      id: '20',
      message: 'Sounds like a plan, Bat Man. I\'ll be ready.',
      sendingTime: DateTime(2023, 6, 20, 10, 27),
      sendByMe: false,
    ),
  ];
}
