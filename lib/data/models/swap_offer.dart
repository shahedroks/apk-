import 'package:cloud_firestore/cloud_firestore.dart';

class SwapOffer {
  const SwapOffer({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.fromItemId,
    required this.toItemId,
    required this.status,
    this.message,
    this.chatId,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String fromUserId;
  final String toUserId;
  final String fromItemId;
  final String toItemId;
  final String status;
  final String? message;
  final String? chatId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SwapOffer.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return SwapOffer(
      id: doc.id,
      fromUserId: data['fromUserId'] as String? ?? '',
      toUserId: data['toUserId'] as String? ?? '',
      fromItemId: data['fromItemId'] as String? ?? '',
      toItemId: data['toItemId'] as String? ?? '',
      status: data['status'] as String? ?? 'pending',
      message: data['message'] as String?,
      chatId: data['chatId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  bool get isMatched =>
      status == 'accepted' || status == 'completed';
}
