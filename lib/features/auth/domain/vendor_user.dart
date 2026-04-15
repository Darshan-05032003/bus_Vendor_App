class VendorUser {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String? displayName;

  VendorUser({
    required this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
  });

  //Helper method to easily check if the vendor has completed registaration later
  bool get hasEmail => email != null && email!.isNotEmpty;
  bool get hasPhone => phoneNumber != null && phoneNumber!.isNotEmpty;
}
