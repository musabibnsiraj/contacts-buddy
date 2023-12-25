import '../providers/contact_provider.dart';
import '../widgets/common_widget.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import 'package:flutter/material.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({Key? key}) : super(key: key);

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String firstname = "";
  String lastname = "";
  String phone = "";
  String email = "";

  //Create New Contact
  void saveContact() async {
    try {
      //Contact form validation check
      final bool isValid = _formKey.currentState!.validate();
      final bool isValidForm = formValidate();
      if (isValid && isValidForm) {
        if (mounted) setState(() => loading = true);

        firstname = _firstName.text;
        lastname = _lastName.text;
        phone = _phone.text;
        email = _email.text;

        //Create contact
        var created = await Provider.of<ContactProvider>(context, listen: false)
            .addContact(firstname, lastname, phone, email);

        //Created suuccess
        if (created) {
          showSuccessMsg(
              "Your contact has been added!", "Success", "Back to Contacts");
        }
      }
    } catch (e) {
      if (e is String) {
        showSuccessMsg(e.toString(), "Sorry!", "Back to Contacts");
      }
    } finally {
      setState(() => loading = false);
    }
  }

  bool formValidate() {
    if (_firstName.text != "" && _lastName.text != "" && _phone.text != "") {
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
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
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
      appBar: appBar('Add New Contact'),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 64,
                              backgroundColor: primaryAppColor,
                              child: const Text('New Contact',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          UserFormInput(
                              textEditingControllerl: _firstName,
                              textInputType: TextInputType.emailAddress,
                              hintText: 'First Name',
                              maxCharacter: 1),
                          const SizedBox(
                            height: 20,
                          ),
                          UserFormInput(
                            textEditingControllerl: _lastName,
                            textInputType: TextInputType.text,
                            hintText: 'Last Name',
                            maxCharacter: 1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          UserFormInput(
                            textEditingControllerl: _phone,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                            hintText: 'Phone',
                            maxCharacter: 1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          UserFormInput(
                            textEditingControllerl: _email,
                            textInputType: TextInputType.text,
                            hintText: 'Email',
                            maxCharacter: 1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: PrimaryBtn(
                                  data: 'Cancel',
                                  color: secondaryButtonBGColor,
                                ),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    )),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            primaryAppColorAccent),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          return primaryAppColor
                                              .withOpacity(0.04);
                                        }
                                        if (states.contains(
                                                MaterialState.focused) ||
                                            states.contains(
                                                MaterialState.pressed)) {
                                          return primaryAppColor
                                              .withOpacity(0.12);
                                        }
                                        return null; // Defer to the widget's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () async =>
                                      !loading ? saveContact() : null,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: 60,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: ShapeDecoration(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      color: primaryAppColor,
                                    ),
                                    child: Text(
                                      !loading ? "Save" : "Loading..",
                                      style: const TextStyle(
                                        color: Color(0xfff5f5f5),
                                        fontSize: 16,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
