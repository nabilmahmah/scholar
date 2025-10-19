import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/constans.dart';
import 'package:scholar/helper/ShowSnackBar.dart';
import 'package:scholar/views/Register_view.dart';
import 'package:scholar/views/chat_view.dart';
import 'package:scholar/widgets/custom_buttom.dart';
import 'package:scholar/widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static final String routeName = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;

  bool islooding = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: islooding,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                SizedBox(height: 75),
                Image.asset(klogo, height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Scholar chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: "Pacifico",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                customTextFormField(
                  hintText: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 15),
                customTextFormField(
                  obscureText: true,
                  hintText: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 20),
                CustomButtom(
                  text: "LOGIN",
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      islooding = true;
                      setState(() {});
                      try {
                        await signinUser();
                        // showSnackBar(context, 'success');
                        Navigator.pushNamed(
                          context,
                          ChatView.routeName,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                            context,
                            'Wrong password provided for that user.',
                          );
                        } else if (e.code == 'invalid-credential') {
                          showSnackBar(
                            context,
                            'Error: Invalid email or password.',
                          );
                        } else {
                          showSnackBar(context, 'Error: ${e.message}');
                        }
                      } catch (e) {
                        showSnackBar(context, 'error');
                      }
                      islooding = false;
                      setState(() {});
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterView.routeName);
                      },
                      child: Text(
                        "  Register",
                        style: TextStyle(
                          color: Color.fromARGB(255, 195, 231, 230),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signinUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
