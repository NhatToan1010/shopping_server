import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String addressName;
  final String phoneNo;
  final String street;
  final String postalCode;
  final String city;
  String? state;
  final String country;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.addressName,
    required this.phoneNo,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
    required this.selectedAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "AddressName": addressName,
      "PhoneNo": phoneNo,
      "Street": street,
      "PostalCode": postalCode,
      "City": city,
      "State": state,
      "Country": country,
      "SelectedAddress": selectedAddress,
    };
  }

  static AddressModel empty() {
    return AddressModel(
      id: '',
      addressName: '',
      street: '',
      postalCode: '',
      city: '',
      country: '',
      selectedAddress: true,
      phoneNo: '',
      state: ''
    );
  }

  factory AddressModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data()!.isNotEmpty) {
      final data = document.data()!;

      return AddressModel(
        id: document.id,
        addressName: data["AddressName"] ?? '',
        street: data["Street"] ?? '',
        state: data["State"] ?? '',
        postalCode: data["PostalCode"] ?? '',
        city: data["City"] ?? '',
        country: data["Country"] ?? '',
        selectedAddress: data["SelectedAddress"] ?? false,
        phoneNo: data["PhoneNo"] ?? '',
      );
    } else {
      return empty();
    }
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: '',
      addressName: data["AddressName"] as String,
      street: data["Street"] as String,
      postalCode: data["PostalCode"] as String,
      city: data["City"] as String,
      country: data["Country"] as String,
      state: data["State"] as String,
      selectedAddress: data["SelectedAddress"] as bool,
      phoneNo: data["PhoneNo"] as String,
    );
  }

  String getAddress() {
    return '$postalCode, $street, $city,${state == '' ? '' : ' $state,'} $country.';
  }
}
