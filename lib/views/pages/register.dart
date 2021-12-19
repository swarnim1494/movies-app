import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/view_models/pages/register.dart';

import 'package:movies_app/views/components/shared_widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel = Provider.of<RegisterViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SignUpHeaderText(text: "Let's get you started"),
                  SizedBox(height: 32.0,),
                  NameTextFieldWidget(),
                  SizedBox(height: 16.0,),
                  PhoneTextField()
                ],
              ),
              Column(
                children: [
                  ErrorText(text: registerViewModel.error,),
                  const RegisterButton()
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class NameTextFieldWidget extends StatelessWidget {
  const NameTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel = Provider.of<RegisterViewModel>(context);
    return TextField(

      decoration: outlineInputDecoration(context,label: "Name",hintText: "Johnny Rose"),
      keyboardType: TextInputType.name,
      onChanged: (name){
        registerViewModel.setName(name);
      },
    );
  }
}

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel = Provider.of<RegisterViewModel>(context);
    return TextField(
      decoration: outlineInputDecoration(context,label:"Phone",hintText: "1234567890"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can b
      onChanged: (phone){
        registerViewModel.setPhone(phone);
      },
      maxLength: 10,
    );
  }
}


class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterViewModel registerViewModel = Provider.of<RegisterViewModel>(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("Continue"),
        onPressed: (){
          registerViewModel.registerUser(context);
        },
      ),
    );
  }
}



