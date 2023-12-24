import 'package:contacts_buddy/helpers/db_helper.dart';
import 'package:contacts_buddy/helpers/utill.dart';
import 'package:contacts_buddy/models/contact_buddy_model.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<ContactBuddy> _allContacts = [];
  List<ContactBuddy> get getAllContact => [..._allContacts];

  Future<void> getAllContacts() async {
    // Ensure that the method is not called during the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        _isLoading = true;
        notifyListeners(); // Notify listeners before the asynchronous operation

        var contacts = await DB.getAll("contacts");

        // Clear existing contacts before adding new ones
        _allContacts.clear();

        for (var contactMap in contacts) {
          _allContacts.add(ContactBuddy.fromJson(contactMap));
        }

        _isLoading = false;
        notifyListeners(); // Notify listeners after the asynchronous operation
      } catch (e) {
        // Handle errors
      } finally {
        _isLoading = false;
        notifyListeners(); // Notify listeners after completing the operation (even if there's an error)
      }
    });
  }

  bool _phoneExists(dynamic phone, dynamic datas) {
    if (phone != "") {
      return datas.any((contact) =>
          contact.phone == phone ||
          contact.phone == phone.toString() ||
          contact.phone.toString() == phone.toString());
    }
    return false;
  }

  filterContacts(searchText, fillteredContacts) async {
    if (searchText != "") {
      List<ContactBuddy> filtered = [];
      filtered.addAll(fillteredContacts);
      filtered.retainWhere((contact) {
        String searchTerm = searchText.toLowerCase();
        String contactName =
            '${contact.firstname.toLowerCase()} ${contact.lastname.toLowerCase()}';
        bool matches = contactName.contains(searchTerm);
        if (matches == true) {
          return true;
        }

        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        if (searchTermFlatten.isEmpty) return false;

        String contactPhone = flattenPhoneNumber(contact.phone);
        contactPhone = contactPhone.replaceAll(" ", "");
        searchTermFlatten = searchTermFlatten.replaceAll(" ", "");
        matches = contactPhone.contains(searchTermFlatten);
        if (matches == true) {
          return true;
        }

        return false;
      });
      return filtered;
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  Future<void> getContactById(String id) async {
    //
  }

  Future<dynamic> addContact(String firstname, String lastname, String phone,
      {String note = ""}) async {
    try {
      Map<String, dynamic> contact = {
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'note': note
      };

      await DB.insert('contacts', contact);
      Utill.showInfo("Contact inserted succesfully..!");
    } catch (e) {
      Utill.showError("Error: $e");
    }
  }

  Future<dynamic> updateContact(String id, Map<String, dynamic> data) async {
    //
  }

  Future<dynamic> deleteContact(String id) async {
    //
  }
}
