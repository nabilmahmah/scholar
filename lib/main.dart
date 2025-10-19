import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar/firebase_options.dart';
import 'package:scholar/views/Login_view.dart';
import 'package:scholar/views/Register_view.dart';
import 'package:scholar/views/chat_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const scholar());
}

class scholar extends StatelessWidget {
  const scholar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView(),
        ChatView.routeName: (context) => ChatView(),
      },
      initialRoute: LoginView.routeName,
    );
  }
}
