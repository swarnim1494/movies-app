import 'package:flutter/material.dart';
import 'package:movies_app/models/user.dart';
import 'package:movies_app/services/auth.dart';
import 'package:movies_app/view_models/base.dart';
import 'package:movies_app/view_models/errors.dart';
import 'package:movies_app/views/pages/dashboard.dart';

class OTPViewModel extends AViewModel{
  late String otp;

  setOtp(String value){
    otp = value;
  }

  verifyOTP(BuildContext context, User? user){
    try{
      setLoading(true);
      AuthService.instance.verifyOTP(phone: user!.phone!, name: user.name!, otp: otp);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const DashboardPage()), (route) => false);
    }on UserFriendlyException catch (e){
      setError(e.message);
    }

  }
}