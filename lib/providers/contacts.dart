import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final contactsProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  if (await Permission.contacts.request().isGranted) {
    ref.keepAlive();
    return await FlutterContacts.getContacts();
  }

  return [];
});
