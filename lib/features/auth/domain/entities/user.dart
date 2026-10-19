class User {
  const User({
    required this.id,
    required this.email,
    this.name,
    this.role = 'user',
  });

  final String id;
  final String email;
  final String? name;
  final String role;
}
