import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_server/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  toJSON() {
    return {
      "UserName": userName,
      "FirstName": firstName,
      "LastName": lastName,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
    };
  }

  // --- Create UserModel from a Firebase document data in Firestore
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        userName: data["UserName"] ?? '',
        firstName: data["FirstName"] ?? '',
        lastName: data["LastName"] ?? '',
        phoneNumber: data["PhoneNumber"] ?? '',
        profilePicture: data["ProfilePicture"] ?? '',
      );
    } else {
      return empty();
    }
  }

  // Helper Functions
  // ----- Full name
  String get fullName => '$firstName $lastName';

  // ----- Formatted Phone Number
  String get formattedPhoneNumber => Formatter.formatPhoneNumber(phoneNumber);

  // ----- Split full name into first name and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // ----- Generate username form full name
  static String generateUserNameFormFullName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = "$firstName$lastName"; // Combine of first name and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername";

    return usernameWithPrefix;
  }

  // ----- Create empty user
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      phoneNumber: '',
      profilePicture: '',
  );
}
