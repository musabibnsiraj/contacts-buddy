import '../providers/contact_provider.dart';
import '../widgets/common_widget.dart';
import 'package:contacts_buddy/models/contact_model.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import 'package:flutter/material.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({Key? key, required this.contact})
      : super(key: key);
  final Contact contact;
  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController(text: '');
  bool loading = false;
  bool saving = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String contactId = "";

  @override
  void initState() {
    super.initState();
    setValues();
  }

  //Set value to form fields
  void setValues() async {
    contactId = widget.contact.id;
    _firstName.text = widget.contact.firstname;
    _lastName.text = widget.contact.lastname;
    _phone.text = widget.contact.phone;
    if (widget.contact.email != null) _email.text = widget.contact.email ?? "";
  }

  //Update contact
  void updateContact(ctx, id) async {
    setState(() => saving = true);
    try {
      final bool isValid = _formKey.currentState!.validate();
      final bool isValidForm = formValidate();

      if (isValid && isValidForm) {
        Map<String, dynamic> data = {};
        data['firstname'] = _firstName.text;
        data['lastname'] = _lastName.text;
        data['phone'] = _phone.text;
        data['email'] = _email.text;

        if (mounted) {
          await Provider.of<ContactProvider>(context, listen: false)
              .updateContact(id, data);

          showSuccessMsg(
              "Your contact have been updated!", "Success", "Back to Contacts");
        }
      }
    } catch (e) {
      if (e is String) {
        showSuccessMsg(e.toString(), "Sorry!", "Back to Contacts");
      }
    } finally {
      setState(() => saving = false);
    }
  }

  bool formValidate() {
    if (_firstName.text != "" &&
        _lastName.text != "" &&
        _phone.text != "" &&
        widget.contact.id != "") {
      return true;
    }
    return false;
  }

  showSuccessMsg(String content, String title, String btnName) {
    showDialog(
        context: context,
        builder: (context) {
          return Showdialoguebox(
            content: content,
            title: title,
            actions1: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: ShapeDecoration(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            color: primaryButtonBGColor,
                          ),
                          child: Text(
                            btnName,
                            style: TextStyle(
                              color: primaryButtonTextColor,
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ))),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar('Contact Details'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 64,
                                    backgroundColor: primaryAppColor,
                                    child: Text(
                                      widget.contact.initials() ?? "",
                                      style: const TextStyle(fontSize: 40),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            UserInput(
                              textEditingControllerl: _firstName,
                              textInputType: TextInputType.text,
                              hintText: 'First Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            UserInput(
                              textEditingControllerl: _lastName,
                              textInputType: TextInputType.text,
                              hintText: 'Last Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            UserInput(
                              textEditingControllerl: _phone,
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                signed: true,
                                decimal: true,
                              ),
                              hintText: 'Phone',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            UserInput(
                              textEditingControllerl: _email,
                              textInputType: TextInputType.text,
                              hintText: 'Email',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          notchMargin: 0,
          child: Container(
            color: appBgColor,
            height: 70,
            width: double.maxFinite,
            child: Column(
              children: [
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          primaryAppColorAccent),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return primaryAppColor.withOpacity(0.04);
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return primaryAppColor.withOpacity(0.12);
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () async =>
                        !saving ? updateContact(context, contactId) : null,
                    child: !saving
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              color: primaryAppColor,
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                                color: appWhite,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                        : const Spinner())
              ],
            ),
          ),
        ));
  }
}
