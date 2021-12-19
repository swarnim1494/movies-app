class Movie {
  late String title;
  late String year;
  late String rated;
  late String released;
  late String runtime;
  late String genre;
  late String director;
  late String writer;
  late String actors;
  late String plot;
  late String language;
  late String country;
  late String awards;
  late String poster;
  late String metascore;
  late String imdbRating;
  late String imdbVotes;
  late String imdbID;
  late String type;
  late String response;
  late List<String> images;

  Movie(
      {required title,
        required year,
        required rated,
        required released,
        required runtime,
        required genre,
        required director,
        required writer,
        required actors,
        required plot,
        required language,
        required country,
        required awards,
        required poster,
        required metascore,
        required imdbRating,
        required imdbVotes,
        required imdbID,
        required type,
        required response,
        required images});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    rated = json['Rated'];
    released = json['Released'];
    runtime = json['Runtime'];
    genre = json['Genre'];
    director = json['Director'];
    writer = json['Writer'];
    actors = json['Actors'];
    plot = json['Plot'];
    language = json['Language'];
    country = json['Country'];
    awards = json['Awards'];
    poster = json['Poster'];
    metascore = json['Metascore'];
    imdbRating = json['imdbRating'];
    imdbVotes = json['imdbVotes'];
    imdbID = json['imdbID'];
    type = json['Type'];
    response = json['Response'];
    images = json['Images'].cast<String>();
  }

}