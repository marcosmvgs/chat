import 'dart:async';
import 'dart:math';

import 'package:chat/core/models/chat_user.dart';
import 'dart:io';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  /* Esse atributos são estáticos, isso significa que eles INDEPENDEM da classe,
  ou seja, eu posso criar várias instâncias de AuthMockService na aplicação, que
  o _currentUser será o mesmo, a não ser que eu atribua um outro valor a ele, pois
  ele não é final. A mesma explicação serve para o _users.
  Ele vai "zerar" os static's quando eu der um refresh na aplicação
  */
  static final _defaultUser = ChatUser(
    id: '1',
    name: 'Teste',
    email: '@',
    imageUrl: 'assets/images/avatar.png',
  );

  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  // Preciso criar esse controller para utilizar ele fora do método .multi...
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    /* O updateUser vai zerar o usuário atual e vai gerar um novo dado na stream
    de valor nulo*/
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  /* sempre que o _userStream gerar um novo valor, quem estiver monitorando o
  getter userChanges será notificado */
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
