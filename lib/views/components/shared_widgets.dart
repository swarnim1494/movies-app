import 'package:flutter/material.dart';

class SignUpHeaderText extends StatelessWidget {
  final String text;

  const SignUpHeaderText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headline4);
  }
}

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).colorScheme.error));
  }
}


outlineInputDecoration(BuildContext context, {String? label, String? hintText,Widget? prefixIcon}) {
  return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      labelText: label,
      hintText: hintText,
    prefixIcon: prefixIcon
  );
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(),
    );
  }
}
