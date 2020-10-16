import 'package:flutter/material.dart';
import 'package:testing_example_movie_app/movie/data/movie.dart';
import 'package:testing_example_movie_app/movie/data/movie_repository.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final MovieRepository _movieRepository = MovieRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<double>(
        stream: _movieRepository.currentValue,
        builder: (_, AsyncSnapshot<double> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Movie App'),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  key: Key('remaining-money-indicator'),
                  onPressed: null,
                  label: Text(
                    'Remaining Money: ${snapshot.data}',
                  ),
                ),
                body: FutureBuilder<List<Movie>>(
                  future: _movieRepository.fetchMovies(),
                  builder: (
                    _,
                    AsyncSnapshot<List<Movie>> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return MovieList(snapshot.data,
                          (Movie movie) => _movieRepository.buyTicket(movie));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _movieRepository.close();
    super.dispose();
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) buyMovieAction;
  const MovieList(this.movies, this.buyMovieAction);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key('movie-list'),
      itemCount: movies.length,
      itemBuilder: (BuildContext builderContext, int position) => ListTile(
        key: Key(movies[position].title),
        title: Text(movies[position].title),
        subtitle: Text(
          'Price: ${movies[position].price.toString()}',
        ),
        onTap: () async {
          final movie = movies[position];
          final purchaseResult = buyMovieAction.call(movie);

          if (!purchaseResult.result) {
            showDialog(
              context: builderContext,
              builder: (_) => AlertDialog(
                key: Key('info-dialog'),
                title: const Text('Sorry!'),
                content: Text(
                  'Your last purchase for ${movie.title}\nwas not successful.\n\nYour remaining cash is ${purchaseResult.remainingMoney}.\n\nPlease either try again after topping up your account or buy a movie in your price range.',
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Close me!'),
                    onPressed: () => Navigator.of(builderContext).pop(),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
