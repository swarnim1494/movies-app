import 'package:movies_app/services/auth.dart';

Future<void> init ()async{
  await AuthService.initialize();
}