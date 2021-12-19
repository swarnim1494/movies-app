import 'package:flutter/material.dart';



abstract class AViewModel extends ChangeNotifier {

  late bool _loading = false;
  late String _error = '';

  bool get loading => _loading;
  String get error => _error;

  setLoading(bool loading) {
    _loading = loading;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifyListeners();
    });

  }

  setError(String error) {
    _error = error;
    notifyListeners();
  }



}
