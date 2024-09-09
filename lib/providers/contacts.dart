import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final _contactsProvider = FutureProvider<List<Contact>>((ref) async {
  if (await Permission.contacts.request().isGranted) {
    return await FlutterContacts.getContacts(withProperties: true);
  }

  return [];
});

final contactsMapProvider = Provider<Map<String, Contact>>((ref) {
  final contacts = ref.watch(_contactsProvider).value ?? [];
  return {
    for (final contact in contacts)
      if (contact.phones.isNotEmpty) contact.phones.first.number: contact
  };
});
