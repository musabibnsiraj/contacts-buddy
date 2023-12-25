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

  Future<Map<String, dynamic>?> getContactById(String id) async {
    try {
      List<Map<String, dynamic>> result =
          await DB.getByWhere('contacts', null, 'id = ?', [id], 1);

      // If a contact is found, return it; otherwise, return null
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      // If an error occurs during the process, show an error message
      Utill.showError("Error: $e");
      // You might want to handle the error further or log it for debugging
      return null; // Indicate that there was an error while fetching the contact
    }
  }

  Future<dynamic> addContact(
      String firstname, String lastname, String phone, String? email) async {
    try {
      // Create a Map to represent the contact information
      Map<String, dynamic> contact = {
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'email': email ?? ""
      };

      // Use the 'DB' object to insert the contact into the 'contacts' table
      await DB.insert('contacts', contact);

      // Fetch all contacts after inserting the new one
      getAllContacts();

      // Notify listeners about the change in data
      notifyListeners();

      // Return true to indicate that the contact was successfully added
      return true;
    } catch (e) {
      // If an error occurs during the process, show an error message
      Utill.showError("Error: $e");
      // You might want to handle the error further or log it for debugging
    }
  }

  Future<int> updateContact(String id, Map<String, dynamic> data) async {
    try {
      // Create a Map to represent the updated contact information
      Map<String, dynamic> updatedContact = {
        'firstname': data['firstname'],
        'lastname': data['lastname'],
        'phone': data['phone'],
        'email': data['email']
      };

      // Use the 'DB' object to update the contact in the 'contacts' table
      int rowsAffected =
          await DB.update('contacts', 'id = ?', [id], updatedContact);

      // Fetch all contacts after updating
      getAllContacts();

      // Notify listeners about the change in data
      notifyListeners();

      // Return the number of rows affected to indicate that the contact was successfully updated
      return rowsAffected;
    } catch (e) {
      // If an error occurs during the process, show an error message
      Utill.showError("Error: $e");
      // You might want to handle the error further or log it for debugging
      return -1; // Indicate that the update was not successful
    }
  }

  Future<int> deleteContact(String id) async {
    try {
      // Use the 'DB' object to delete the contact in the 'contacts' table
      int rowsAffected = await DB.delete('contacts', 'id = ?', [id]);

      // Fetch all contacts after deleting
      getAllContacts();

      // Notify listeners about the change in data
      notifyListeners();

      // Return the number of rows affected to indicate that the contact was successfully deleted
      return rowsAffected;
    } catch (e) {
      // If an error occurs during the process, show an error message
      Utill.showError("Error: $e");
      // You might want to handle the error further or log it for debugging
      return -1; // Indicate that the deletion was not successful
    }
  }
}
