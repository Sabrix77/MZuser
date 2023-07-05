import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/chat.dart';
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
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.support),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10, right: 10, bottom: 30, left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.background,

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
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return MessageWidget(messages[index]);
                  },
                  itemCount: messages.length ?? 0,
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 12, bottom: 10, right: 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration:  InputDecoration(

                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          hintText: "type a message",
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff528485),
                    ),
                    child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          //TODO Refactor this سباكتي
                          String id = DateTime.now().toIso8601String();
                          int timestamp = DateTime.now().millisecondsSinceEpoch;
                          Message message = Message(
                            id: id,
                            senderId: mainProvider.user!.id,
                            content: messageController.text,
                            timestamp: timestamp,
                          );
                          Chat chat=Chat(
                              id: mainProvider.user!.id,
                              name: '${mainProvider.user!.firstName} ${mainProvider.user!.lastName}',
                              lastContent: messageController.text,
                          );
                          viewModel.sendMessage(chat: chat,message:message);
                          messageController.clear();
                        },
                        child: const Icon(Icons.send,
                            size: 26, color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
