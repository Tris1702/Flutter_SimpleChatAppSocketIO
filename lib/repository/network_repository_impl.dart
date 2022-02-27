import 'package:chat_app/data/models/message_json.dart';
import 'package:chat_app/repository/network_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NetworkRepositoryImpl implements NetworkRepository {
  NetworkRepositoryImpl() {
    try {
      channel = IO.io(
          'http://192.168.1.14:3000',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .build());
      channel.connect();
    } catch (e) {
      print(e);
    }
    channel.onConnect((_) {
      print('connected');
      channel.emit('send', 'tris');
    });
    channel.on('message', (data) {
      print("On message" + data.toString());
      channelSink.add(MessageModel.fromJson(data));
    });
  }

  late IO.Socket channel;

  final BehaviorSubject<MessageModel?> message = BehaviorSubject.seeded(null);

  Stream<MessageModel?> get channelStream => message.stream;
  Sink<MessageModel?> get channelSink => message.sink;

  @override
  Future<void> clientToServer(MessageModel message) async {
    print('on messagedetection');
    channel.emit('messagedetection', [message.senderName, message.messagage]);
  }
}
