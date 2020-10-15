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
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder:
                            (BuildContext builderContext, int position) =>
                                ListTile(
                          title: Text(snapshot.data[position].title),
                          subtitle: Text(
                            'Price: ${snapshot.data[position].price.toString()}',
                          ),
                          onTap: () async {
                            final movie = snapshot.data[position];
                            final purchaseResult =
                                _movieRepository.buyTicket(movie);

                            if (!purchaseResult.result) {
                              showDialog(
                                context: builderContext,
                                builder: (_) => AlertDialog(
                                  title: const Text('Sorry!'),
                                  content: Text(
                                    'Your last purchase for ${movie.title}\nwas not successful.\n\nYour remaining cash is ${purchaseResult.remainingMoney}.\n\nPlease either try again after topping up your account or buy a movie in your price range.',
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Close me!'),
                                      onPressed: () =>
                                          Navigator.of(builderContext).pop(),
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      );
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
