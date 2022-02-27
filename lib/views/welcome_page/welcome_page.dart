import 'package:chat_app/views/welcome_page/welcome_page_bloc.dart';
import 'package:flutter/material.dart';
import '../chat_page/chat_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    WelcomePageBloc welcomePageBloc = WelcomePageBloc();
    return StreamBuilder(
        stream: welcomePageBloc.hasNameStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            String username = snapshot.data! as String;
            return Scaffold(
              appBar: AppBar(title: Text(title)),
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: TextField(
                          onChanged: (username) =>
                              welcomePageBloc.chageState(username),
                          decoration:
                              const InputDecoration(label: Text('Username')),
                        )),
                    IconButton(
                        onPressed: !username.isNotEmpty
                            ? null
                            : () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(senderName: username))),
                        icon: const Icon(Icons.send)),
                  ])),
            );
          }
        });
  }
}
