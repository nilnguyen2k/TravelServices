class SignUpForm {
  
  final String verify;
  final String phone;
  final String lastname;
  final String firstname;
  final String gender;
  final String password;
  final String email;
  final int role;
  final bool provider;

  SignUpForm({
    required this.verify,
    required this.phone,
    required this.lastname,
    required this.firstname,
    required this.gender,
    required this.password,
    required this.role,
    required this.email,
    required this.provider
  });

}