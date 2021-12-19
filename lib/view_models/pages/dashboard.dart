import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/services/auth.dart';
import 'package:movies_app/services/data.dart';
import 'package:movies_app/view_models/base.dart';

class DashboardViewModel extends AViewModel {
  DataService dataService = DataService();
  late List<Movie> movies;
  late List<Movie> filteredMovies;
  bool sortDecreasing = false;

  DashboardViewModel() {
    setLoading(true);
    dataService.getMovies().then((value) {
      movies = filteredMovies = value;
      sortMovies();
      setLoading(false);
    });
  }

  logout(BuildContext context) {
    AuthService.instance.logout();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthCheck()), (route) => false);
  }

  onSearch(String searchTerm) {
    filteredMovies = movies.where((element) => element.title.toLowerCase().contains(searchTerm.toLowerCase())).toList();
    notifyListeners();
  }

  sortMovies(){
    sortDecreasing = !sortDecreasing;
    if(sortDecreasing){
      filteredMovies.sort((a,b)=>a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    }else{
      filteredMovies.sort((a,b)=>b.title.toLowerCase().compareTo(a.title.toLowerCase()));
    }
    notifyListeners();
  }
}
