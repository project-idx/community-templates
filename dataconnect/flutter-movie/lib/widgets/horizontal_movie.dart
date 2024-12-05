import 'package:dataconnect/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalMovie extends StatelessWidget {
  const HorizontalMovie({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: SizedBox(
                width: 150,
                child: Image.network(movie.imageUrl, fit: BoxFit.fitWidth)),
            onTap: () {
              context.push("/movies/${movie.id}");
            },
            title: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: movie.description != null
                ? Text(movie.description!, overflow: TextOverflow.ellipsis)
                : const Text(''),
          ),
        ],
      ),
    );
  }
}
