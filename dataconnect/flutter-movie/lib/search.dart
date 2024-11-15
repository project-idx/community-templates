import 'package:dataconnect/models/movie.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/list_actors.dart';
import 'package:dataconnect/widgets/list_movies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class SearchFormState {
  String title = '';
  int maxYear = 2024;
  int minYear = 1900;
  double minRating = 1.0;
  double maxRating = 5.0;
  String genre = '';
  @override
  String toString() {
    return {
      'title': title,
      'maxYear': maxYear,
      'minYear': minYear,
      'minRating': minRating,
      'maxRating': maxRating,
      'genre': genre
    }.toString();
  }
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final SearchFormState _searchFormState = SearchFormState();
  List<SearchAllMoviesMatchingTitle> _resultsMovieMatchingTitle = [];
  List<SearchAllMoviesMatchingDescription> _resultsMovieMatchingDescription =
      [];
  List<SearchAllActorsMatchingName> _actorsMatchingName = [];
  List<SearchAllReviewsMatchingText> _reviewsMatchingText = [];

  void _searchMovie() {
    MoviesConnector.instance
        .searchAll(
          minYear: _searchFormState.minYear,
          maxYear: _searchFormState.maxYear,
          minRating: _searchFormState.minRating,
          maxRating: _searchFormState.maxRating,
          genre: _searchFormState.genre,
        )
        .input(_searchFormState.title)
        .execute()
        .then((value) {
      setState(() {
        _actorsMatchingName = value.data.actorsMatchingName;
        _resultsMovieMatchingTitle = value.data.moviesMatchingTitle;
        _resultsMovieMatchingDescription = value.data.moviesMatchingDescription;
        _reviewsMatchingText = value.data.reviewsMatchingText;
      });
    });
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    initialValue: _searchFormState.title,
                    decoration: const InputDecoration(hintText: 'Title'),
                    onChanged: (value) {
                      setState(() {
                        _searchFormState.title = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchMovie();
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: _searchFormState.minYear.toString(),
                    decoration:
                        const InputDecoration(hintText: 'Release Year From'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _searchFormState.minYear = int.parse(value);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: _searchFormState.genre,
                    decoration: const InputDecoration(hintText: 'Genre'),
                    onChanged: (value) {
                      setState(() {
                        _searchFormState.genre = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: _searchFormState.minRating.toString(),
                    decoration: const InputDecoration(hintText: 'Rating From'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _searchFormState.minRating =
                            value.isEmpty ? 0 : double.parse(value);
                      });
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: _searchFormState.maxYear.toString(),
                    decoration:
                        const InputDecoration(hintText: 'Release Year To'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _searchFormState.maxYear = int.parse(value);
                      });
                    },
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: _searchFormState.maxRating.toString(),
                    decoration: const InputDecoration(hintText: 'Rating To'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _searchFormState.maxRating =
                            value.isEmpty ? 0 : double.parse(value);
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget _buildRatingList() {
    return SizedBox(
        height: 125,
        child: Expanded(
            child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var rating = _reviewsMatchingText[index];
            return Card(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rating.user.username),
                      Row(
                        children: [
                          Text(DateFormat.yMMMd().format(rating.reviewDate)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Rating ${rating.rating}")
                        ],
                      ),
                      Text(rating.reviewText!)
                    ],
                  )),
            );
          },
          itemCount: _reviewsMatchingText.length,
        )));

    // return Expanded(child: Text('abc'));
  }

  Widget _buildResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Results',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ListMovies(
            movies: _resultsMovieMatchingTitle
                .map((e) =>
                    Movie(id: e.id, title: e.title, imageUrl: e.imageUrl))
                .toList(),
            title: "Movies Matching Title"),
        ListMovies(
            movies: _resultsMovieMatchingDescription
                .map((e) =>
                    Movie(id: e.id, title: e.title, imageUrl: e.imageUrl))
                .toList(),
            title: "Movies Matching Description"),
        const Text('Results matching reviews',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Advanced Search',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                        _buildForm(),
                        _buildResults(),
                        _buildRatingList(),
                        ListActors(
                            title: "Actors Matching Title",
                            actors: _actorsMatchingName
                                .map((actor) => Actor(
                                    id: actor.id,
                                    imageUrl: actor.imageUrl,
                                    name: actor.name))
                                .toList())
                      ],
                    )))));
  }
}
