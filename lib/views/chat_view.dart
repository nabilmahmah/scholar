import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar/constans.dart';
import 'package:scholar/models/message.dart';
import 'package:scholar/widgets/buble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  static final routeName = "ChatView";
  final message = FirebaseFirestore.instance.collection("messages");
  final TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];
  var scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder(
      stream: message.orderBy(ktime, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          messagesList.clear();
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(klogo, height: 40),
                  Text("Chat", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollcontroller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? buble(message: messagesList[index])
                          : bublefriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    top: 8,
                  ),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      message.add({
                        "message": value,
                        ktime: DateTime.now(),
                        kemail: email,
                      });
                      controller.clear();
                      scrollcontroller.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          message.add({
                            "message": controller.text,
                            ktime: DateTime.now(),
                            kemail: email,
                          });
                          controller.clear();

                          scrollcontroller.animateTo(
                            scrollcontroller.position.maxScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: Icon(Icons.send, color: kPrimaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(klogo, height: 40),
                    Text("Chat", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              body: Center(child: CircularProgressIndicator()),
            ),
          );
      },
    );
  }
}
