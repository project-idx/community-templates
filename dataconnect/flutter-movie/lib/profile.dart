import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'movie_state.dart';
import 'models/movie.dart';
import 'movies_connector/movies.dart';
import 'util/auth.dart';
import 'widgets/list_movies.dart';
import 'widgets/list_reviews.dart';
import 'widgets/login_guard.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginGuard(builder: (context) {
      return StreamBuilder(
          stream: MovieState.subscribeToCurrentUser(),
          builder: (context, snapshot) {
            final res = snapshot.data;
            if (res == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final displayName = res.data.user!.name;
            final favoriteMovies =
                res.data.user!.favoriteMovies.map((e) => e.movie).toList();
            final reviews = res.data.user!.reviews;
            return RefreshIndicator(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('Welcome back $displayName !'),
                          TextButton(
                              onPressed: () async {
                                FirebaseAuth.instance.signOut();
                                context.go('/login');
                              },
                              child: const Text('Sign out'))
                        ],
                      ),
                      ListMovies(
                          title: "Favorite Movies",
                          movies: favoriteMovies
                              .map(
                                (e) => Movie(
                                    id: e.id,
                                    title: e.title,
                                    imageUrl: e.imageUrl),
                              )
                              .toList()),
                      ListReviews(
                          reviews: reviews
                              .map(
                                (e) => Review(
                                    reviewText: e.reviewText!,
                                    rating: e.rating!,
                                    username: Auth.instance.currentUser!.email!,
                                    date: e.reviewDate),
                              )
                              .toList(),
                          title: "Reviews"),
                    ],
                  ),
                ),
              ),
              onRefresh: () async {
                MoviesConnector.instance.getCurrentUser().execute();
              },
            );
          });
    });
  }
}
