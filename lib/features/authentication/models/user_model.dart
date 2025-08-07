import 'package:admin_panel/features/shop/model/address_model.dart';
import 'package:admin_panel/features/shop/model/order_modal.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses;

  UserModel({
    this.id,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    required this.email,
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName';
  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  static UserModel empty() => UserModel(email: '');
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role.name,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('firstName') ? data['firstName'] ?? '' : '',
        lastName: data.containsKey('lastName') ? data['lastName'] ?? '' : '',
        userName: data.containsKey('userName') ? data['userName'] ?? '' : '',
        email: data.containsKey('email') ? data['email'] ?? '' : '',
        phoneNumber:
            data.containsKey('phoneNumber') ? data['phoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('profilePicture')
            ? data['profilePicture'] ?? ''
            : '',
        role: data.containsKey('role')
            ? (data['role'] ?? AppRole.user) == AppRole.admin.name.toString()
                ? AppRole.admin
                : AppRole.user
            : AppRole.user,
        createdAt: data.containsKey('createdAt')
            ? data['createdAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey('updatedAt')
            ? data['updatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
      ); // UserModel
    } else {
      return empty();
    }
  }
}
