class ValidateForm {

  static String? isValidUsername(String? username) {
    if (username!.length > 6 || username.isEmpty) {
      return null;
    } else {
      return "Username must be more than 6 characters";
    }
  }

  static String? isValidPassword(String? password) {
    if (password!.length > 6 || password.isEmpty) {
      return null;
    } else {
      return "Password must be more than 6 characters";
    }
  }

  static String? isValidCnfPassword(String? password, String? cnfpassword) {
    if (password == cnfpassword) {
      return null;
    } else {
      return "Password incorrect";
    }
  }

  static String? isValidEmail(String? email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    // final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email!.isNotEmpty) {
      if (emailRegExp.hasMatch(email)) {
        return null;
      } else {
        return "Please enter the correct format of an email";
      }
    } else {
      return null;
    }
  }

  static String? isValidPhone(String? phone) {
    // RegExp regExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    // RegExp regExp = RegExp("^0[0-9]{9}");
    if (phone!.isNotEmpty) {
      if (phone.length < 10) {
        return "Phone number must be 10 characters";
      } else {
        if (phone.length == 10) {
          // if (regExp.hasMatch(phone)) {
          //   return null;
          // } else {
          //   return "Phone number with start 0 character";
          // }
          return null;
        } else {
          // return "Phone number must be 10 characters";
          return null;
        }
      }
    } else {
      return null;
    }
  }  

}