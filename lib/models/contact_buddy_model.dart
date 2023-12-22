class ContactBuddy {
  final String id;
  final String firstname;
  final String lastname;
  final String phone;
  final String? email;

  ContactBuddy(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.phone,
      this.email});

  factory ContactBuddy.fromJson(Map<String, dynamic> json) {
    return ContactBuddy(
        id: json['_id'].toString(),
        firstname: json['firstname'].toString(),
        lastname: json['lastname'].toString(),
        phone: json['phone'].toString(),
        email: json['email'].toString());
  }

  String? firstLetter() {
    var letter =
        ((firstname.isNotEmpty == true ? firstname[0] : "")).toUpperCase();
    if (letter.contains(RegExp('^[a-zA-Z]+'))) {
      return letter;
    }
    return null;
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

  // Implement toString to make it easier to see information about
  // each userContact when using the print statement.
  @override
  String toString() {
    return 'ContactBuddy{id: $id, firstname: $firstname, lastname: $lastname,phone: $phone,email: $email}';
  }

  // Convert a ContactBuddy into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'email': email
    };
  }

  Map<String, dynamic> toSyncMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'status': true
    };
  }

  static List<ContactBuddy> fromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ContactBuddy.fromJson(data);
    }).toList();
  }
}
