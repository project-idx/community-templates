import 'package:dataconnect/models/movie.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({super.key, required this.movies, required this.title});

  final List<Movie> movies;
  final String title;
  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  Widget _buildMovieList(String title, List<Movie> movies) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        movies.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "No $title",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ))
            : SizedBox(
                height: 300, // Adjust the height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return _buildMovieItem(movies[index]);
                  },
                ),
              ),
      ],
    );
  }

  void _visitDetail(String id) {
    context.push("/movies/$id");
  }

  Widget _buildMovieItem(Movie movie) {
    return Container(
      width: 150, // Adjust the width as needed
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: InkWell(
            onTap: () {
              _visitDetail(movie.id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16, // 9:16 aspect ratio for the image
                  child: Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMovieList(widget.title, widget.movies);
  }
}
