import 'package:dataconnect/movie_state.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/login_guard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({super.key, required this.id});

  final String id;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  double _ratingValue = 0;
  bool loading = true;
  GetMovieByIdData? data;
  bool _favorited = false;

  final TextEditingController _reviewTextController = TextEditingController();
  @override
  void initState() {
    super.initState();

    MovieState.subscribeToMovieById(widget.id).listen((value) {
      if (mounted) {
        setState(() {
          loading = false;
          data = value.data;
        });
      }
    });

    MovieState.subscribeToGetMovieInfo(widget.id).listen((value) {
      if (mounted) {
        setState(() {
          _favorited = value.data.favorite_movie != null;
        });
      }
    });
  }

  void _refreshData() {
    MovieState.refreshMovieDetail(widget.id);
  }

  void _toggleFavorite() {
    MovieState.toggleFavorite(widget.id, _favorited).then((_) {
      setState(() {
        _favorited = !_favorited;
      });
    });
  }

  String _getFavoriteLabelText() {
    return _favorited ? 'Remove From Favorites' : 'Add To Favorites';
  }

  List<Widget> _buildMainDescription() {
    var movie = data!.movie!;
    return [
      Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 30),
            ),
          )),
      Row(
        children: [
          Text(movie.releaseYear.toString()),
          const SizedBox(width: 10),
          Row(
            children: [const Icon(Icons.star), Text(movie.rating.toString())],
          )
        ],
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 9 / 16, // 9:16 aspect ratio for the image
                child: Image.network(
                  movie.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(children: [
                Row(
                  children: movie.tags!.map((tag) {
                    return Chip(
                        label: Text(
                      tag,
                      overflow: TextOverflow.ellipsis,
                    ));
                  }).toList(),
                ),
                Text(movie.description!)
              ]),
            ))
          ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LoginGuard(
              widgetToGuard: OutlinedButton.icon(
            onPressed: () {
              _toggleFavorite();
            },
            icon: Icon(_favorited ? Icons.favorite : Icons.favorite_border),
            label: Text(_getFavoriteLabelText()),
          ))
        ],
      )
    ];
  }

  void _visitActorDetail(String id) {
    context.push("/actors/$id");
  }

  Widget _buildMainActorsList() {
    return Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Main Actors",
              style: TextStyle(fontSize: 30),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                GetMovieByIdMovieMainActors actor =
                    data!.movie!.mainActors[index];
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 30,
                          child:
                              ClipOval(child: Image.network(actor.imageUrl))),
                      Text(
                        actor.name,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]);
              },
              itemCount: data!.movie!.mainActors.length,
            ))
          ],
        ));
  }

  Widget _buildSupportingActorsList() {
    return Container(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Supporting Actors",
              style: TextStyle(fontSize: 30),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  GetMovieByIdMovieSupportingActors actor =
                      data!.movie!.supportingActors[index];
                  return InkWell(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: ClipOval(
                                  child: Image.network(actor.imageUrl))),
                          Text(
                            actor.name,
                            overflow: TextOverflow.ellipsis,
                          )
                        ]),
                    onTap: () {
                      _visitActorDetail(actor.id);
                    },
                  );
                },
                itemCount: data!.movie!.mainActors.length,
              ),
            )
          ],
        ));
  }

  List<Widget> _buildRatings() {
    return [
      Text("Rating: $_ratingValue"),
      Slider(
        value: _ratingValue,
        max: 10,
        divisions: 20,
        label: _ratingValue.toString(),
        onChanged: (double value) {
          setState(() {
            _ratingValue = value;
          });
        },
      ),
      LoginGuard(
          widgetToGuard: TextField(
            decoration: const InputDecoration(
              hintText: "Write your review",
              border: OutlineInputBorder(),
            ),
            controller: _reviewTextController,
          ),
          message: "writing a review"),
      LoginGuard(
        widgetToGuard: OutlinedButton.icon(
          onPressed: () {
            MoviesConnector.instance
                .addReview(
                    movieId: widget.id,
                    rating: _ratingValue.toInt(),
                    reviewText: _reviewTextController.text)
                .execute()
                .then((_) {
              _refreshData();
              _reviewTextController.clear();
              MovieState.triggerUpdateFavorite();
            });
          },
          label: const Text('Submit Review'),
        ),
      ),
      ...data!.movie!.reviews.map((review) {
        return Card(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.user.username),
                  Row(
                    children: [
                      Text(DateFormat.yMMMd().format(review.reviewDate)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Rating ${review.rating}")
                    ],
                  ),
                  Text(review.reviewText!)
                ],
              )),
        );
      })
    ];
/**/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: data == null
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                )
              : Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      ..._buildMainDescription(),
                      _buildMainActorsList(),
                      _buildSupportingActorsList(),
                      ..._buildRatings()
                    ],
                  )))),
    );
  }
}
