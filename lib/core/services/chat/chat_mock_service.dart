import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'dart:async';

class ChatMockService implements ChatService {
  /* Independente da instância de ChatMockService a lista de mensagens
  será a mesma*/
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia. Teremos reunião hoje?',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Marcos',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Sim horário normal.',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Vitoria',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '1',
      text: 'Ok.',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Marcos',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageUrl: user.imageUrl);
    _msgs.add(newMessage);

    _controller?.add(_msgs);

    return newMessage;
  }
}
