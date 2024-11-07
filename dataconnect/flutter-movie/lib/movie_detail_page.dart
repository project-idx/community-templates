import 'package:flutter/material.dart';
import 'package:movie_app_clone/generated/movie_connector.dart';

class MovieDetailPage extends StatefulWidget {
  MovieDetailPage({super.key, required this.id});
  String id;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPage(id);
}

class _MovieDetailPage extends State<MovieDetailPage> {
  String id;
  GetMovieByIdMovie? _movie;
  _MovieDetailPage(this.id);
  @override
  void initState() {
    super.initState();
    MovieConnectorConnector.instance
        .getMovieById(id: id)
        .execute()
        .then((value) {
      setState(() {
        _movie = value.data.movie!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: _movie == null
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Image.network(
                            _movie!.imageUrl,
                            height: 400,
                          ),
                          Center(
                            child: Text(
                              _movie!.description!,
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                            height: 30,
                                            color: const Color.fromARGB(
                                                199, 86, 86, 86),
                                            child: Row(children: [
                                              const Icon(Icons.star),
                                              Text(_movie!.rating!.toString())
                                            ])))
                                  ],
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                        height: 30,
                                        color: const Color.fromARGB(
                                            199, 86, 86, 86),
                                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Align(
                                          child: Text(
                                              _movie!.releaseYear!.toString()),
                                          alignment: Alignment.center,
                                        )))
                              ],
                            ),
                          )
                        ],
                      ))));
  }
}
