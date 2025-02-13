



class UserDetails{
  String userName;
  String firstName;
  String lastName;
  String phone;
  String walletAddress;
  UserDetails({
    required this.userName ,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.walletAddress,
});
  @override
  String toString() {
    return super.toString();
  }
}