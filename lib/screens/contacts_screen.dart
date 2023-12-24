import 'dart:async';
import 'package:contacts_buddy/helpers/utill.dart';
import 'package:contacts_buddy/models/contact_buddy_model.dart';
import 'package:contacts_buddy/providers/contact_provider.dart';
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
  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await getAllContacts();
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
    final userContacts = contactProvider.getAllContact;
    final isLoading = contactProvider.isLoading;

    return Scaffold(
      appBar: appBar('Contact Buddy'),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              ListTile(
                onTap: () async {},
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
                  itemCount: userContacts.length,
                  itemBuilder: (ctx, i) {
                    ContactBuddy c = userContacts.elementAt(i);
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      onDismissed: (!isLoading && !loading)
                          ? (direction) async {
                              setState(() {
                                // Remove the item from the list.
                                userContacts.removeAt(i);
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
                            onTap: () {},
                            leading: CircleAvatar(
                                backgroundColor: appGreen,
                                child: Text(c.initials() ?? "")),
                            trailing: Text(c.phone),
                            title: Text(
                              "${c.firstname} ${c.lastname}",
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
