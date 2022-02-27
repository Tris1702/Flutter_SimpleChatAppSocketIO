import 'package:chat_app/base/bloc_base.dart';
import 'package:chat_app/repository/network_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../data/models/message_json.dart';
import '../../repository/network_repository.dart';

class ChatPageBloc implements BlocBase {
  @override
  void dispose() {
    listMessage.close();
  }

  @override
  void init() {
    (networkRepositoryImpl as NetworkRepositoryImpl)
        .channelStream
        .listen((event) {
      if (event != null) {
        print("chat_page_bloc on recieve" + event.toString());
        listMessage.value.insert(0, event);
        listMessage.add(listMessage.value);
      }
      // listMessage.add(listMessage.value);
    });
  }

  NetworkRepository networkRepositoryImpl = NetworkRepositoryImpl();
  final BehaviorSubject<List<MessageModel>> listMessage =
      BehaviorSubject.seeded(List<MessageModel>.empty(growable: true));
  Sink<List<MessageModel>> get messageSink => listMessage.sink;
  Stream<List<MessageModel>> get messageStream => listMessage.stream;

  clientToServer(MessageModel messageModel) async {
    networkRepositoryImpl.clientToServer(messageModel);
  }
}
