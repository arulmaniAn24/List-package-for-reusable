class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String dateOfBirth;
  final String bio;
  final String location;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.dateOfBirth,
    required this.bio,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      dateOfBirth: json['date_of_birth'],
      bio: json['bio'],
      location: json['location'],
    );
  }
}
