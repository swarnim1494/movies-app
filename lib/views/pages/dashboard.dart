import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/services/auth.dart';
import 'package:movies_app/view_models/pages/dashboard.dart';
import 'package:movies_app/views/components/shared_widgets.dart';
import 'package:movies_app/views/pages/movie_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = Provider.of<DashboardViewModel>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              "Hello " + AuthService.instance.user.name!,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  dashboardViewModel.logout(context);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SearchMovieTextField(),
                if (dashboardViewModel.loading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: LoadingWidget()),
                  )
                else
                  const Expanded(child: MovieListView()),
                const SortingButton()
              ],
            ),
          )),
    );
  }
}

class SearchMovieTextField extends StatelessWidget {
  const SearchMovieTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = Provider.of<DashboardViewModel>(context);
    return TextField(
      decoration: outlineInputDecoration(context, prefixIcon: Icon(Icons.search), hintText: "Search by title"),
      keyboardType: TextInputType.name,
      onChanged: (searchTerm) {
        dashboardViewModel.onSearch(searchTerm);
      },
    );
  }
}

class SortingButton extends StatelessWidget {
  const SortingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = Provider.of<DashboardViewModel>(context);
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              dashboardViewModel.sortMovies();
            },
            child: Text(dashboardViewModel.sortDecreasing ? "Sort: Title A to Z" : "Sort: Title Z to A")));
  }
}

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = Provider.of<DashboardViewModel>(context);
    List<Widget> movieWidgets() {
      List<Widget> widgetList = [];
      for (var movie in dashboardViewModel.filteredMovies) {
        widgetList.add(MovieCard(movie: movie));
      }
      return widgetList;
    }

    return ListView(
      children: movieWidgets(),
      shrinkWrap: true,
    );
  }
}

class IMDbWidgetDashboard extends StatelessWidget {
  final Color widgetColor;
  final Movie movie;

  const IMDbWidgetDashboard({Key? key, required this.movie, required this.widgetColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: widgetColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
            child: Text(
              "IMDb",
              style: TextStyle(fontWeight: FontWeight.bold, color: widgetColor),
            ),
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          movie.imdbRating,
          style: TextStyle(fontWeight: FontWeight.bold, color: widgetColor),
        )
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoviePage(
                      movie: movie,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5, spreadRadius: 3, offset: Offset(3, 3))]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 120,
                      child: CachedNetworkImage(
                        imageUrl: movie.poster.replaceAll("http://", "https://"),
                        imageBuilder: (context, imageProvider) => Container(
                          height: 120.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                              //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: const LoadingWidget()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IMDbWidgetDashboard(
                              movie: movie,
                              widgetColor: Theme.of(context).colorScheme.onSurface,
                            ),
                            Text(
                              movie.title,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            MovieCardMetadata(header: "Director: ", value: movie.director),
                            MovieCardMetadata(header: "Starring: ", value: movie.actors)
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieCardMetadata extends StatelessWidget {
  final String header, value;

  const MovieCardMetadata({Key? key, required this.header, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(header, style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 4,
          child: Text(value, style: Theme.of(context).textTheme.caption),
        )
      ],
    );
  }
}
