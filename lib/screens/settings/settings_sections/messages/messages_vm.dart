import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mzady/base.dart';
import 'package:mzady/screens/settings/settings_sections/messages/messages_navigator.dart';
import 'package:mzady/services/db_utils_messages.dart';

import '../../../../model/message.dart';

class MessagesViewModel extends BaseViewModel<MessagesNavigator> {
  Stream<QuerySnapshot<Message>> getMessages(String userId) {
    return DBUtilsMessages.getUserMessages(userId);
  }

  sendMessage(Message message) async {
    await DBUtilsMessages.setMessage(message);
  }
}
