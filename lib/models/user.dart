typedef UserId = String;

enum UserType {
  organization,
  personal,
}

// convert UserType from string to enum
UserType userTypeFromString(String type) {
  switch (type) {
    case 'organization':
      return UserType.organization;
    case 'personal':
      return UserType.personal;
    default:
      throw Exception('Unknown user type: $type');
  }
}

class User {
  final UserId id;
  final UserType type;
  final String firstname;
  final String lastname;
  final String? phoneticName;
  final String? localContactName;
  final String? phoneNumber;
  final String? avatarUrl;

  final bool isOnline;
  final bool hasStatus;

  final bool isLocalContact;

  const User({
    required this.id,
    required this.type,
    required this.firstname,
    required this.lastname,
    this.phoneticName,
    this.localContactName,
    this.phoneNumber,
    this.avatarUrl,
    this.isOnline = false,
    this.hasStatus = false,
    this.isLocalContact = false,
  });

  User copyWith({
    UserType? type,
    String? firstname,
    String? lastname,
    String? phoneticName,
    String? localContactName,
    String? phoneNumber,
    String? avatarUrl,
    bool? isOnline,
    bool? hasStatus,
    bool? isLocalContact,
  }) {
    return User(
      id: id,
      type: type ?? this.type,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phoneticName: phoneticName ?? this.phoneticName,
      localContactName: localContactName ?? this.localContactName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
      hasStatus: hasStatus ?? this.hasStatus,
      isLocalContact: isLocalContact ?? this.isLocalContact,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      type: userTypeFromString(json['type']),
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneticName: json['phoneticName'],
      localContactName: json['localContactName'],
      phoneNumber: json['phoneNumber'],
      avatarUrl: json['avatarUrl'],
      isOnline: json['isOnline'],
      hasStatus: json['hasStatus'],
      isLocalContact: json['isLocalContact'],
    );
  }

  String get displayName =>
      localContactName ?? phoneticName ?? '$firstname $lastname';
}
