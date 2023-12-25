import 'dart:async';
import 'package:contacts_buddy/helpers/utill.dart';
import 'package:contacts_buddy/models/contact_buddy_model.dart';
import 'package:contacts_buddy/providers/contact_provider.dart';
import 'package:contacts_buddy/screens/add_new_contact_screen.dart';
import 'package:contacts_buddy/screens/contact_detail_screen.dart';
import '../../widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/constant.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<ContactBuddy> userContacts = [];
  List<ContactBuddy> filteredContacts = [];
  List<ContactBuddy> allContacts = [];
  TextEditingController searchController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }

  filterContacts() {
    List<ContactBuddy> filtered = [];
    filtered.addAll(userContacts);
    if (searchController.text.isNotEmpty) {
      filtered.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
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
      setState(() {
        allContacts = filtered;
      });
    } else {
      setState(() {
        allContacts = userContacts;
      });
    }
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  // Update your getAllContacts function
  Future<void> getAllContacts() async {
    setState(() => loading = true);
    try {
      ContactProvider contactProvider =
          Provider.of<ContactProvider>(context, listen: false);
      if (mounted) {
        await contactProvider.getAllContacts();
      }
    } catch (e) {
      Utill.showError("Error: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  removeContact(String id, BuildContext context) async {
    setState(() => loading = true);
    try {
      await Provider.of<ContactProvider>(context, listen: false)
          .deleteContact(id);
    } catch (e) {
      Utill.showError("Error: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context, listen: true);
    final isLoading = contactProvider.isLoading;

    bool isSearching = searchController.text.isNotEmpty;
    if (!isSearching) {
      userContacts = contactProvider.getAllContact;
      allContacts = userContacts;
    }

    return Scaffold(
      appBar: appBar('Contact Buddy'),
      body: SafeArea(
          child: Stack(
        children: [
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ListTile(
                onTap: () async {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const NewContactScreen();
                  }));
                },
                leading: Container(
                  height: 52,
                  width: 52,
                  margin: const EdgeInsets.only(left: 5),
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: primaryAppColor,
                    child: Icon(
                      Icons.add,
                      color: appIconColor,
                    ),
                  ),
                ),
                title: const Text(
                  'Add new contact',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Contacts',
                      prefixIcon: Icon(
                        Icons.search,
                        color: appTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: appGrey)),
                ),
              ),
              if (!isLoading && !loading && userContacts.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Text('You don’t have any contacts saved yet'),
                ),
              Expanded(
                  child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: allContacts.length,
                  itemBuilder: (ctx, i) {
                    ContactBuddy c = allContacts.elementAt(i);
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      onDismissed: (!isLoading && !loading)
                          ? (direction) async {
                              setState(() {
                                // Remove the item from the list.
                                allContacts.removeAt(i);
                              });
                              await removeContact(c.id, context);
                            }
                          : null,
                      background: Container(
                        color: appRemoveColor,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: appWhite,
                                ),
                                const Text('Remove'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: appRemoveColor,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: appWhite,
                                ),
                                const Text('Remove'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 4, right: 4),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ContactDetailScreen(contact: c);
                              }));
                            },
                            leading: CircleAvatar(
                                backgroundColor: appGreen,
                                child: Text(c.initials() ?? "")),
                            title: Text("${c.firstname} ${c.lastname}"),
                            subtitle: Text(
                              c.phone,
                              style: TextStyle(color: appTextColor),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
          if (loading || isLoading) const Spinner()
        ],
      )),
    );
  }
}
