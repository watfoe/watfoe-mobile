import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watfoe/models/user.dart';
import 'package:watfoe/providers/contacts.dart';

final usersProvider =
    StateNotifierProvider<UsersNotifier, Map<UserId, User>>((ref) {
  return UsersNotifier();
});

class UsersNotifier extends StateNotifier<Map<UserId, User>> {
  UsersNotifier() : super({});

  void addUser(User user) {
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
  final matchingContact = contactsMap[user.phoneNumber];

  if (matchingContact != null && !user.isLocalContact) {
    // Update the user in the usersProvider
    ref.read(usersProvider.notifier).updateUser(
          userId,
          (u) => u.copyWith(
            displayName: matchingContact.displayName,
            isLocalContact: true,
          ),
        );
    // Return the updated user
    return user.copyWith(
      displayName: matchingContact.displayName,
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
          (contact) => contact.phones.first.number == user.phoneNumber);
    } else {
      otherUserIds.add(userId);
    }
  }

  return (userIdsInContacts, otherUserIds, remainingContacts);
});
