import 'package:dataconnect/models/movie.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/display_movie.dart';
import 'package:dataconnect/widgets/horizontal_movie.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class SearchFormState {
  String title = '';
  @override
  String toString() {
    return {
      'title': title,
    }.toString();
  }
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final SearchFormState _searchFormState = SearchFormState();
  List<ListMoviesByPartialTitleMovies> _resultsMovieMatchingTitle = [];

  void _searchMovie() {
    MoviesConnector.instance
        .listMoviesByPartialTitle(input: _searchFormState.title)
        .execute()
        .then((value) {
      setState(() {
        _resultsMovieMatchingTitle = value.data.movies;
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
                  flex: 6,
                  child: TextFormField(
                    initialValue: _searchFormState.title,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter some text'
                        : null,
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
                    onPressed: _formKey.currentState?.validate() == true
                        ? _searchMovie
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildResults() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _resultsMovieMatchingTitle.map(
          (e) {
            final Movie movie =
                Movie(id: e.id, title: e.title, imageUrl: e.imageUrl);
            return HorizontalMovie(movie: movie);
          },
        ).toList());
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
                        _buildForm(),
                        _buildResults(),
                      ],
                    )))));
  }
}
