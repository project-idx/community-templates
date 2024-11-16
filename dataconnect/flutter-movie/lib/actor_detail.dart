import 'package:flutter/material.dart';

import 'movie_state.dart';
import 'widgets/list_movies.dart';

class ActorDetail extends StatelessWidget {
  const ActorDetail({
    super.key,
    required this.actorId,
  });

  final String actorId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieState.getActorById(actorId),
      builder: (context, snapshot) {
        final actor = snapshot.data?.data.actor;
        final loading = snapshot.connectionState == ConnectionState.waiting;
        return Scaffold(
          body: SafeArea(
            child: () {
              if (actor == null || loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            actor.name,
                            style: const TextStyle(fontSize: 30),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio:
                                  9 / 16, // 9:16 aspect ratio for the image
                              child: Image.network(
                                actor.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListMovies(
                        movies: MovieState.convertMainActorDetail(
                          actor.mainActors,
                        ),
                        title: "Main Roles",
                      ),
                      ListMovies(
                        movies: MovieState.convertSupportingActorDetail(
                          actor.supportingActors,
                        ),
                        title: "Supporting Roles",
                      ),
                    ],
                  ),
                ),
              );
            }(),
          ),
        );
      },
    );
  }
}
