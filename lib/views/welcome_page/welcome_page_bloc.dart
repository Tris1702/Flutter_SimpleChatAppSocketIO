import 'package:chat_app/base/bloc_base.dart';
import 'package:rxdart/subjects.dart';

class WelcomePageBloc implements BlocBase {
  @override
  void dispose() {
    userName.close();
  }

  @override
  void init() {
    // TODO: implement init
  }

  final BehaviorSubject<String> userName = BehaviorSubject.seeded('');
  Sink<String> get hasNameSink => userName.sink;
  Stream<String> get hasNameStream => userName.stream;

  chageState(String username) {
    userName.add(username);
  }
}
