class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String image;
  late DateTime last_active;

  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.last_active,
  });

  factory ChatUser.fromJSON(Map<String, dynamic> _json) {
    print("object");
    return ChatUser(
      uid: _json['uid'],
      name: _json['name'],
      email: _json['email'],
      image: _json['image'],
      last_active: _json['last_active'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "last_active": last_active,
      "image": image,
    };
  }

  String lastDayActive() {
    return '${last_active.month}/${last_active.day}/${last_active.year}';
  }

  bool wasRecentlyActive() {
    return DateTime.now().difference(last_active).inHours < 2;
  }
}
