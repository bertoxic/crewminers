

class LoginDetails {
  final String email;
  final String password;

  LoginDetails({required this.email, required this.password});

  bool validateCredentials() {
    // TODO: will add  validation logic here (e.g., check against a database)
    return email.isNotEmpty && password.isNotEmpty;
  }
}