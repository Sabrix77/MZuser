import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mzady/base.dart';
import 'package:mzady/model/chat.dart';
import 'package:mzady/screens/settings/settings_sections/messages/messages_navigator.dart';
import 'package:mzady/services/db_utils_messages.dart';
import 'package:mzady/shared/constants/app_strings.dart';

import '../../../../model/message.dart';

class MessagesViewModel extends BaseViewModel<MessagesNavigator> {
  Stream<QuerySnapshot<Message>> getMessages(String userId) {
    return DBUtilsMessages.getUserMessages(userId);
  }

  void sendMessage({required Message message,required Chat chat}) async {
    try {
      await DBUtilsMessages.setChat(chat);
      await DBUtilsMessages.setMessage(message);
    } catch (e) {
      navigator!.showMessage(AppStrings.someThingWentWrong, AppStrings.ok);
    }
  }
}
