import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/firebase/collection_names.dart';
import '../models/chat_models.dart';

class ChatRepository {
  ChatRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Stream<List<ChatRoom>> watchMyChats() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(const []);

    return _firestore
        .collection(CollectionNames.chats)
        .where('memberIds', arrayContains: uid)
        .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ChatRoom.fromFirestore).toList());
  }

  Stream<List<ChatMessage>> watchMessages(String chatId) {
    return _firestore
        .collection(CollectionNames.chats)
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map(ChatMessage.fromFirestore).toList());
  }

  Future<String> ensureChatForMembers({
    required List<String> memberIds,
    String? offerId,
  }) async {
    final sorted = [...memberIds]..sort();
    final existing = await _firestore
        .collection(CollectionNames.chats)
        .where('memberIds', arrayContains: sorted.first)
        .get();

    for (final doc in existing.docs) {
      final ids = List<String>.from(doc.data()['memberIds'] as List? ?? []);
      if (ids.length == sorted.length && ids.every(sorted.contains)) {
        return doc.id;
      }
    }

    final ref = _firestore.collection(CollectionNames.chats).doc();
    await ref.set({
      'memberIds': sorted,
      if (offerId != null) 'offerId': offerId,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastMessage': '',
    });
    return ref.id;
  }

  Future<void> sendMessage(String chatId, String text) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('Sign in required');
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    final chatRef = _firestore.collection(CollectionNames.chats).doc(chatId);
    final msgRef = chatRef.collection('messages').doc();
    await msgRef.set({
      'senderId': uid,
      'text': trimmed,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await chatRef.update({
      'lastMessage': trimmed,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }
}
