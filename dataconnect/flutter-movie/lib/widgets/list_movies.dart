import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/models/movie.dart';

class ListMovies extends StatelessWidget {
  const ListMovies({
    super.key,
    required this.movies,
    required this.title,
  });

  final List<Movie> movies;
  final String title;

  @override
  Widget build(BuildContext context) {
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
                    final movie = movies[index];
                    return Container(
                      width: 150, // Adjust the width as needed
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            context.push("/movies/${movie.id}");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio:
                                    9 / 16, // 9:16 aspect ratio for the image
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
