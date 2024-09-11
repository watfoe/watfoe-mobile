import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/models/user.dart';
import 'package:watfoe/providers/contacts.dart';

const users = [
  {
    "id": "1",
    "type": "personal",
    "firstname": "John",
    "lastname": "Doe",
    "phoneNumber": "+254798033746",
    "isOnline": true,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "2",
    "type": "personal",
    "firstname": "Jane",
    "lastname": "Smith",
    "phoneNumber": "+254724025743",
    "isOnline": false,
    "hasStatus": true,
    "isLocalContact": false
  },
  {
    "id": "3",
    "type": "organization",
    "firstname": "Alice",
    "lastname": "Johnson",
    "phoneNumber": "+254733893980",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "4",
    "type": "personal",
    "firstname": "Bob",
    "lastname": "Brown",
    "phoneNumber": "+254713659101",
    "avatarUrl": "https://example.com/avatar1.jpg",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "5",
    "type": "personal",
    "firstname": "Emma",
    "lastname": "Davis",
    "phoneNumber": "+254719647651",
    "isOnline": true,
    "hasStatus": true,
    "isLocalContact": false
  },
  {
    "id": "6",
    "type": "personal",
    "firstname": "Michael",
    "lastname": "Wilson",
    "phoneNumber": "+17806809081",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "7",
    "type": "organization",
    "firstname": "Olivia",
    "lastname": "Taylor",
    "phoneNumber": "+254720207392",
    "avatarUrl": "https://example.com/avatar2.jpg",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "8",
    "type": "personal",
    "firstname": "William",
    "lastname": "Anderson",
    "phoneNumber": "+254729444987",
    "isOnline": true,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "9",
    "type": "personal",
    "firstname": "Sophia",
    "lastname": "Thomas",
    "phoneNumber": "+254729920461",
    "isOnline": false,
    "hasStatus": true,
    "isLocalContact": false
  },
  {
    "id": "10",
    "type": "personal",
    "firstname": "James",
    "lastname": "Jackson",
    "phoneNumber": "+15555228243",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "11",
    "type": "organization",
    "firstname": "Emily",
    "lastname": "White",
    "phoneNumber": "+18885555512",
    "avatarUrl": "https://example.com/avatar3.jpg",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "12",
    "type": "personal",
    "firstname": "Daniel",
    "lastname": "Harris",
    "phoneNumber": "+15554787672",
    "isOnline": true,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "13",
    "type": "personal",
    "firstname": "Ava",
    "lastname": "Martin",
    "phoneNumber": "+254711223344",
    "isOnline": false,
    "hasStatus": true,
    "isLocalContact": false
  },
  {
    "id": "14",
    "type": "personal",
    "firstname": "David",
    "lastname": "Thompson",
    "phoneNumber": "+254755667788",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "15",
    "type": "organization",
    "firstname": "Grace",
    "lastname": "Garcia",
    "phoneNumber": "+254799001122",
    "avatarUrl": "https://example.com/avatar4.jpg",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "16",
    "type": "personal",
    "firstname": "Christopher",
    "lastname": "Martinez",
    "phoneticName": "kris-tuh-fer",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "17",
    "type": "personal",
    "firstname": "Mia",
    "lastname": "Robinson",
    "phoneticName": "mee-uh",
    "isOnline": true,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "18",
    "type": "personal",
    "firstname": "Andrew",
    "lastname": "Clark",
    "isOnline": false,
    "hasStatus": true,
    "isLocalContact": false
  },
  {
    "id": "19",
    "type": "organization",
    "firstname": "Chloe",
    "lastname": "Rodriguez",
    "avatarUrl": "https://example.com/avatar5.jpg",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "20",
    "type": "personal",
    "firstname": "Ethan",
    "lastname": "Lewis",
    "phoneticName": "ee-thuhn",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "21",
    "type": "personal",
    "firstname": "Isabella",
    "lastname": "Walker",
    "isOnline": true,
    "hasStatus": true,
    "isLocalContact": false
  },
  {
    "id": "22",
    "type": "personal",
    "firstname": "Alexander",
    "lastname": "Hall",
    "phoneticName": "al-ig-zan-der",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "23",
    "type": "organization",
    "firstname": "Sofia",
    "lastname": "Allen",
    "avatarUrl": "https://example.com/avatar6.jpg",
    "isOnline": false,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "24",
    "type": "personal",
    "firstname": "Joseph",
    "lastname": "Young",
    "isOnline": true,
    "hasStatus": false,
    "isLocalContact": false
  },
  {
    "id": "25",
    "type": "personal",
    "firstname": "Charlotte",
    "lastname": "Hernandez",
    "phoneticName": "shahr-luht",
    "isOnline": false,
    "hasStatus": true,
    "isLocalContact": false
  }
];

final usersProvider =
    StateNotifierProvider<UsersNotifier, Map<UserId, User>>((ref) {
  return UsersNotifier();
});

class UsersNotifier extends StateNotifier<Map<UserId, User>> {
  UsersNotifier()
      : super(Map.fromEntries(users.map((user) => MapEntry(
              user["id"] as String,
              User.fromJson(user),
            ))));

  void addUser(User user) {
    if (state.containsKey(user.id)) {
      return;
    }

    state = {...state, user.id: user};
  }

  void updateUser(UserId userId, User Function(User) update) {
    state = {
      ...state,
      if (state.containsKey(userId)) userId: update(state[userId]!),
    };
  }

  void removeUser(UserId userId) {
    final newState = Map<UserId, User>.from(state);
    newState.remove(userId);
    state = newState;
  }
}

final userProvider = Provider.family<User?, UserId>((ref, userId) {
  final user = ref.watch(usersProvider)[userId];
  if (user == null) return null;

  final contactsMap = ref.watch(contactsMapProvider);

  if (user.phoneNumber == null) return user;

  final matchingContact = contactsMap[user.phoneNumber];

  if (matchingContact != null && !user.isLocalContact) {
    // Update the user in the usersProvider
    ref.read(usersProvider.notifier).updateUser(
          userId,
          (u) => u.copyWith(
            localContactName: matchingContact.displayName,
            isLocalContact: true,
          ),
        );
    // Return the updated user
    return user.copyWith(
      localContactName: matchingContact.displayName,
      isLocalContact: true,
    );
  }

  return user;
});

final interpolatedUsersAndContactsProvider =
    Provider<(List<UserId>, List<UserId>, List<Contact>)>((ref) {
  final users = ref.watch(usersProvider);
  final contactsMap = ref.watch(contactsMapProvider);

  final userIdsInContacts = <UserId>[];
  final otherUserIds = <UserId>[];
  final remainingContacts = List<Contact>.from(contactsMap.values);

  for (final userId in users.keys) {
    final user = ref.watch(userProvider(userId));
    if (user!.isLocalContact) {
      userIdsInContacts.add(userId);
      remainingContacts.removeWhere(
          (contact) => contact.phones?.first.value == user.phoneNumber);
    } else {
      otherUserIds.add(userId);
    }
  }

  return (userIdsInContacts, otherUserIds, remainingContacts);
});
