import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/message.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/settings/settings_sections/messages/message_widget.dart';
import 'package:mzady/screens/settings/settings_sections/messages/messages_navigator.dart';
import 'package:mzady/screens/settings/settings_sections/messages/messages_vm.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  static const String routeName = 'MessagesScreen';

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends BaseView<MessagesScreen, MessagesViewModel>
    implements MessagesNavigator {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  MessagesViewModel initViewModel() {
    return MessagesViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot<Message>>(
              stream: viewModel.getMessages(mainProvider.user!.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("something went wrong"));
                }
                var messages =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                print('-------+++++++++-----${messages.length}');
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return MessageWidget(messages[index]);
                  },
                  itemCount: messages.length ?? 0,
                );
              },
            )),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: "type a message",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                            ),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                            ),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2))),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                ElevatedButton(
                    onPressed: () {
                      String id = DateTime.now().toIso8601String();
                      int timestamp = DateTime.now().millisecondsSinceEpoch;
                      //  Message messsage=Message(
                      //      id: id,
                      //      senderId: mainProvider.user!.id,
                      //      content: messageController.text,
                      //      receiverId: mainProvider.adminId!,
                      //      timestamp: timestamp,
                      //  );
                      // viewModel.sendMessage(messsage);
                    },
                    child: Row(
                      children: const [
                        Text("Send"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.send)
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
