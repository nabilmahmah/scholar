import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/constans.dart';
import 'package:scholar/helper/ShowSnackBar.dart';
import 'package:scholar/views/chat_view.dart';
import 'package:scholar/widgets/custom_buttom.dart';
import 'package:scholar/widgets/custom_textfield.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});
  static final String routeName = "RegisterView";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
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
                      "Register",
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
                  text: "REGISTER",
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});

                      try {
                        await registerUser();
                        // showSnackBar(context, "success");
                        Navigator.pushNamed(
                          context,
                          ChatView.routeName,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            "'The password provided is too weak.'",
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            "'The account already exists for that email.'",
                          );
                        } else {
                          showSnackBar(context, 'Error: ${e.message}');
                        }
                      } catch (e) {
                        showSnackBar(context, "error");
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "  Login",
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

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
