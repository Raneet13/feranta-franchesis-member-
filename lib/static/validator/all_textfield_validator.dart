class ValidateAll {
  static validateEmail(value) {
    if (value.isEmpty) {
      return "Enter Email address";
    } else {
      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value!)) {
        //value!.isEmpty
        return "Enter Cocrrect Email";
      }

      return null;
    }
  }

  static validateMobile(value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    // if (value.isEmpty) {
    //   return 'Please enter mobile number';
    // } else
    if (value.length != 10) {
      return 'Please enter valid mobile number';
    } else
      return null;
  }

  static validatePassword(value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  static inputValidate(value) {
    if (value.isEmpty) {
      return 'Please enter details';
    } else
      return null;
  }

  static validateAadhar(value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

    // if (value.isEmpty) {
    //   return 'Please enter mobile number';
    // } else
    if (value.length != 12) {
      return 'Please enter valid mobile number';
    } else
      return null;
  }
}
