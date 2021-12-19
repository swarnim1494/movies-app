import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/user.dart';
import 'package:movies_app/view_models/base.dart';
import 'package:movies_app/view_models/errors.dart';
import 'package:movies_app/views/pages/otp.dart';

class RegisterViewModel extends AViewModel {
  User? user;

  RegisterViewModel() {
    user = User();
  }

  setPhone(String phone) {
    user!.phone = phone;
  }

  setName(String name) {
    user!.name = name;
  }

  registerUser(BuildContext context) {
    try {
      setError("");
      nameValidator(user!.name);
      phoneValidator(user!.phone);
      Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(user: user,)));

    } on UserFriendlyException catch (e) {
      setError(e.message);
    }
  }

  nameValidator(String? name) {
    if (name==null|| name.isEmpty) {
      throw UserFriendlyException(message: "Please enter your name");
    }
  }

  phoneValidator(String? phone) {
    if (phone==null||phone.isEmpty) {
      throw UserFriendlyException(message: "Please enter your phone number");
    } else if (phone.length != 10) {
      throw UserFriendlyException(message: "Please enter a valid phone number");
    }
  }
}
