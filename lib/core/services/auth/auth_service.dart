import 'dart:io';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_firebase_service.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;
  /* o Stream lança uma mudança (stream de dados) sempre que o estado do ChatUser mudar
  */

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {}

  Future<void> login(
    String email,
    String password,
  ) async {}

  Future<void> logout() async {}

  factory AuthService() {
    //return AuthMockService();
    return AuthFirebaseService();
  }
}
