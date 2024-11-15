import 'package:dataconnect/movie_state.dart';
import 'package:dataconnect/movies_connector/movies.dart';
import 'package:dataconnect/widgets/list_movies.dart';
import 'package:flutter/material.dart';

class ActorDetail extends StatefulWidget {
  const ActorDetail({super.key, required this.actorId});

  final String actorId;

  @override
  State<ActorDetail> createState() => _ActorDetailState();
}

class _ActorDetailState extends State<ActorDetail> {
  bool loading = true;
  GetActorByIdActor? actor;
  @override
  void initState() {
    super.initState();

    MovieState.getActorById(widget.actorId).then((value) {
      setState(() {
        loading = false;
        actor = value.data.actor;
      });
    });
  }

  _buildActorInfo() {
    return [
      Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              actor!.name,
              style: const TextStyle(fontSize: 30),
            ),
          )),
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 9 / 16, // 9:16 aspect ratio for the image
                child: Image.network(
                  actor!.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
    ];
  }

  Widget _buildMainRoles() {
    return ListMovies(
        movies: MovieState.convertMainActorDetail(actor!.mainActors),
        title: "Main Roles");
  }

  Widget _buildSupportingRoles() {
    return ListMovies(
        movies:
            MovieState.convertSupportingActorDetail(actor!.supportingActors),
        title: "Supporting Roles");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: actor == null
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
                      ..._buildActorInfo(),
                      _buildMainRoles(),
                      _buildSupportingRoles()
                    ],
                  )))),
    );
  }
}
