typedef UserId = String;

enum UserType {
  organization,
  personal,
}

class User {
  final UserId id;
  final UserType type;
  final String firstname;
  final String lastname;
  final String? phoneticName;
  final String? displayName;
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
    this.displayName,
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
    String? displayName,
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
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
      hasStatus: hasStatus ?? this.hasStatus,
      isLocalContact: isLocalContact ?? this.isLocalContact,
    );
  }
}
