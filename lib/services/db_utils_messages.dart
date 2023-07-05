import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mzady/model/message.dart';

import '../model/chat.dart';

class DBUtilsMessages {

  static CollectionReference<Chat> getChatCollectionRef() {
    return FirebaseFirestore.instance.collection('chat').withConverter<Chat>(
      fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
      toFirestore: (chat, options) => chat.toJson(),
    );
  }


  static setChat(Chat chat)async{
    var ref=getChatCollectionRef();
    //chat.id  means client id
    return await ref.doc(chat.id).set(chat);
  }



  //change to message
  static CollectionReference<Message> getMessageCollectionRef(String userId) {
    return FirebaseFirestore.instance
        .collection('chat').doc(userId).collection('messages')
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
        );
  }

  static setMessage(Message message) async {
    var ref = await getMessageCollectionRef(message.senderId);
    return await ref.doc(message.id).set(message);
  }

  static Stream<QuerySnapshot<Message>> getUserMessages(String userId) {
    try {
      var ref = getMessageCollectionRef(userId);
      Stream<QuerySnapshot<Message>> messagesSnapshot = ref.orderBy('timestamp').snapshots();
      return messagesSnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
