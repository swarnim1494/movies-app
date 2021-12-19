import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/views/pages/dashboard.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  const MoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HeaderImage(
            movie: movie,
          ),
          DetailsRow(
            movie: movie,
          ),
          MetaDataColumn(movie: movie),
          Plot(movie: movie),
          MovieImageSlider(movie: movie)
        ],
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  final Movie movie;

  const HeaderImage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageContainerHeight = 400.0;
    double headerImageRadius = 20.0;
    BorderRadius borderRadius = BorderRadius.vertical(bottom: Radius.circular(headerImageRadius));
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: imageContainerHeight,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: movie.poster.replaceAll("http://", "https://"),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    //colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              height: imageContainerHeight,
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: const LinearGradient(
                      colors: [Colors.black,Colors.transparent, Colors.black],stops: [0.0,0.3,0.8],  begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.chevron_left,color: Colors.white,)),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IMDbWidgetDashboard(movie: movie, widgetColor: Colors.white),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          movie.title,
                          style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          movie.genre,
                          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  final Movie movie;

  const DetailsRow({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Details(header: "Duration", value: movie.runtime),
          Details(header: "Rated", value: movie.rated),
          Details(header: "Metacritics", value: movie.metascore),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String header, value;

  const Details({Key? key, required this.header, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 4.0,
        ),
        Text(
          header,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class MetaDataColumn extends StatelessWidget {
  final Movie movie;

  const MetaDataColumn({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Metadata(header: "Release Date", value: movie.released),
            Metadata(header: "Director", value: movie.director),
            Metadata(header: "Starring", value: movie.actors),
            Metadata(header: "Language", value: movie.language),
            Metadata(header: "Awards", value: movie.awards),
          ],
        ),
      ),
    );
  }
}

class Metadata extends StatelessWidget {
  final String header, value;

  const Metadata({Key? key, required this.header, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              header,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
            ),
          )
        ],
      ),
    );
  }
}

class Plot extends StatelessWidget {
  final Movie movie;

  const Plot({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Plot", style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            movie.plot,
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}

class MovieImageSlider extends StatelessWidget {
  final Movie movie;

  const MovieImageSlider({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Images", style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            height: 200.0,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: movie.images
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(e),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
