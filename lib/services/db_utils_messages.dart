import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mzady/model/message.dart';

class DBUtilsMessages {
  //change to message
  static CollectionReference<Message> getMessageCollectionRef() {
    return FirebaseFirestore.instance
        .collection('messages')
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
        );
  }

  static setMessage(Message message) async {
    var ref = await getMessageCollectionRef();
    return await ref.doc(message.id).set(message);
  }

  static Stream<QuerySnapshot<Message>> getUserMessages(String userId) {
    try {
      var ref = getMessageCollectionRef();
      print('[[]]');
      print(userId);
      Stream<QuerySnapshot<Message>> messagesSnapshot = ref
          .where('senderId', isEqualTo: userId)
          .where('receiverId', isEqualTo: userId)
          .snapshots();
      return messagesSnapshot;
    } catch (e) {
      throw (e);
    }
  }
}
