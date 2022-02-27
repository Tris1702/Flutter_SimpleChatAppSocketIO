import '../data/models/message_json.dart';

abstract class NetworkRepository {
  Future<void> clientToServer(MessageModel messageModel);
}
