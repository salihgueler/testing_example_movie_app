import 'package:flutter/material.dart';
import 'package:testing_example_movie_app/movie/data/movie.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final movies = const <Movie>[
    Movie(
      title: 'Palm Springs',
      price: 16,
    ),
    Movie(
      title: 'Jojo Rabbit',
      price: 20,
    ),
    Movie(
      title: 'Waves',
      price: 14,
    ),
    Movie(
      title: 'The Last Black Man in San Francisco',
      price: 18,
    ),
    Movie(
      title: 'Hamilton',
      price: 32,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/empty-page': (BuildContext context) => MovieEmptyDetail(),
        '/with-sent-data': (BuildContext context) => MovieDetailWithArguments()
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: ListView.builder(
          key: Key('movie-list'),
          itemCount: movies.length,
          itemBuilder: (BuildContext builderContext, int position) => ListTile(
            key: Key(movies[position].title),
            title: Text(movies[position].title),
            subtitle: Text(
              'Price: ${movies[position].price.toString()}',
            ),
            onTap: () {
              if (position.isEven) {
                Navigator.push(
                  builderContext,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailInjectedData(
                      movies[position],
                    ),
                  ),
                );
              } else {
                Navigator.pushNamed(
                  builderContext,
                  '/with-sent-data',
                  arguments: movies[position],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MovieEmptyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Empty Detail Page',
        ),
      ),
    );
  }
}

class MovieDetailInjectedData extends StatelessWidget {
  final Movie movie;

  const MovieDetailInjectedData(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Injected Data Page',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              movie.price.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailWithArguments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context).settings.arguments as Movie;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Page',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              movie.price.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
