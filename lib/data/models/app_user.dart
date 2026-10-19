import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    this.displayName,
    this.handle,
    this.role = 'user',
    this.accountStatus = 'active',
    this.photoUrl,
    this.bio,
    this.location,
    this.verified = false,
    this.swapCount = 0,
    this.reportCount = 0,
    this.createdAt,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? handle;
  final String role;
  final String accountStatus;
  final String? photoUrl;
  final String? bio;
  final String? location;
  final bool verified;
  final int swapCount;
  final int reportCount;
  final DateTime? createdAt;

  bool get isBanned => accountStatus == 'banned';
  bool get isRestricted => accountStatus == 'restricted';

  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return AppUser(
      id: doc.id,
      email: data['email'] as String? ?? '',
      displayName: data['displayName'] as String?,
      handle: data['handle'] as String?,
      role: data['role'] as String? ?? 'user',
      accountStatus: data['accountStatus'] as String? ?? 'active',
      photoUrl: data['photoUrl'] as String?,
      bio: data['bio'] as String?,
      location: data['location'] as String?,
      verified: data['verified'] as bool? ?? false,
      swapCount: (data['swapCount'] as num?)?.toInt() ?? 0,
      reportCount: (data['reportCount'] as num?)?.toInt() ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toProfilePatch({
    String? displayName,
    String? handle,
    String? bio,
    String? location,
  }) {
    return {
      if (displayName != null) 'displayName': displayName,
      if (handle != null) 'handle': handle,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
