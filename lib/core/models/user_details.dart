
class UserDetails{
  String userName;
  String firstName;
  String lastName;
  String phone;
  String email;
  String walletAddress;
  UserDetails({
    required this.userName ,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.walletAddress,
});

  UserDetails.fromJSON(Map<String, dynamic>?js):
      userName = js?['username']??"",
      firstName = js?['firstname'],
      lastName = js?['lastname'],
      phone = js?['phone_number'],
      email = js?['email'],
      walletAddress = js?['wallet_address'];

 Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'username':userName,
      'firstname':firstName,
      'lastname':lastName,
      'phone_number':phone,
      'wallet_address':walletAddress,
    };
  }

  @override
  String toString() {
    return UserDetails(userName: userName, firstName: firstName, lastName: lastName, phone: phone, walletAddress: walletAddress, email: email).toString();
  }
}