import 'package:dataconnect/widgets/display_movie.dart';
import 'package:dataconnect/widgets/list_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/models/movie.dart';

class ListMovies extends StatelessWidget {
  const ListMovies(
      {super.key,
      required this.movies,
      this.title,
      this.scrollDirection = Axis.horizontal});

  final List<Movie> movies;
  final String? title;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTitle(title: title!))
            : const SizedBox(),
        movies.isEmpty
            ? title != null
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "No $title",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ))
                : const SizedBox()
            : SizedBox(
                height: 300, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: scrollDirection,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return DisplayMovie(movie: movie);
                  },
                ),
              ),
      ],
    );
  }
}
