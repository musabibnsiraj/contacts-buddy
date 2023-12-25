class Contact {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String? email;

  Contact(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['id'].toString(),
        firstname: json['firstname'].toString(),
        lastname: json['lastname'].toString(),
        phone: json['phone'].toString(),
        email: json['email'].toString());
  }

  String? initials() {
    var letter = ((firstname.isNotEmpty == true ? firstname[0] : "") +
            (lastname.isNotEmpty == true ? lastname[0] : ""))
        .toUpperCase();
    if (letter.contains(RegExp('^[a-zA-Z]+'))) {
      return letter;
    }
    return null;
  }
}
