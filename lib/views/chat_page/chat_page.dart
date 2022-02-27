import 'package:chat_app/data/models/message_json.dart';
import 'package:flutter/material.dart';
import 'chat_page_bloc.dart';

class ChatPage extends StatelessWidget {
  final String senderName;

  const ChatPage({Key? key, required this.senderName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatPageBloc chatPageBloc = ChatPageBloc();
    chatPageBloc.init();
    TextEditingController c = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Room'),
        ),
        body: Column(
          children: [
            Flexible(
                child: StreamBuilder(
                    stream: chatPageBloc.messageStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        var listMessage = snapshot.data as List<MessageModel>;

                        return ListView.builder(
                          itemCount: listMessage.length,
                          // controller: listScrollController,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(listMessage[index].senderName),
                              subtitle: Text(listMessage[index].messagage),
                              leading: CircleAvatar(
                                  child: Text(
                                listMessage[index].senderName[0],
                                style: const TextStyle(color: Colors.blue),
                              )),
                            );
                          },
                        );
                      }
                    })),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Expanded(
                      child: TextField(
                    controller: c,
                  )),
                  IconButton(
                      onPressed: () {
                        chatPageBloc.clientToServer(MessageModel(
                            messagage: c.text, senderName: senderName));
                        c.clear();
                      },
                      icon: const Icon(Icons.send))
                ])),
          ],
        ));
  }
}
