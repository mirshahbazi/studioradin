class User {
  final String id;
  final String email;
  final String fullName;
  final String profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });
}
