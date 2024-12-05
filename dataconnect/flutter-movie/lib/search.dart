import 'package:dataconnect/models/movie.dart';
import 'package:dataconnect/movie_state.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/horizontal_movie.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class SearchFormState {
  String title = '';
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  List<ListMoviesByPartialTitleMovies> _resultsMovieMatchingTitle = [];

  void _searchMovie() {
    MovieState.searchByPartialTitle(title).then((value) {
      setState(() {
        _resultsMovieMatchingTitle = value.data.movies;
      });
    });
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
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: TextFormField(
                                        initialValue: title,
                                        decoration: const InputDecoration(
                                            hintText: 'Title'),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? 'Please enter some text'
                                                : null,
                                        onFieldSubmitted: (value) =>
                                            _searchMovie(),
                                        onChanged: (value) {
                                          setState(() {
                                            title = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed:
                                            _formKey.currentState?.validate() ==
                                                    true
                                                ? _searchMovie
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _resultsMovieMatchingTitle.map(
                              (e) {
                                final Movie movie = Movie(
                                    id: e.id,
                                    title: e.title,
                                    imageUrl: e.imageUrl,
                                    description: e.description);
                                return HorizontalMovie(movie: movie);
                              },
                            ).toList()),
                      ],
                    )))));
  }
}
