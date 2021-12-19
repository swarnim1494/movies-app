import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/models/user.dart';
import 'package:movies_app/view_models/pages/otp.dart';
import 'package:movies_app/views/components/shared_widgets.dart';
import 'package:provider/provider.dart';


class OTPScreen extends StatelessWidget {
  final User? user;
  const OTPScreen({Key? key,this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OTPViewModel otpViewModel = Provider.of<OTPViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  SignUpHeaderText(text: "OTP sent to "+user!.phone!),
                  const SizedBox(height: 32.0,),
                  const OTPTextField()

                ],
              ),
              Column(
                children: [
                  ErrorText(text: otpViewModel.error,),
                  VerifyOTPButton(user: user)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class OTPTextField extends StatelessWidget {
  const OTPTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OTPViewModel registerViewModel = Provider.of<OTPViewModel>(context);
    return TextField(
      decoration: outlineInputDecoration(context,label:"OTP",hintText: "123456"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can b
      onChanged: (otp){
        registerViewModel.setOtp(otp);
      },
      maxLength: 6,
    );
  }
}

class VerifyOTPButton extends StatelessWidget {
  final User? user;
  const VerifyOTPButton({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OTPViewModel otpViewModel = Provider.of<OTPViewModel>(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("Continue"),
        onPressed: (){
          otpViewModel.verifyOTP(context,user);
        },
      ),
    );
  }
}

