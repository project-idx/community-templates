import 'package:dataconnect/widgets/list_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Actor {
  Actor({
    required this.imageUrl,
    required this.name,
    required this.id,
  });
  String imageUrl;
  String name;
  String id;
}

class ListActors extends StatelessWidget {
  const ListActors({
    super.key,
    required this.actors,
    required this.title,
  });
  final List<Actor> actors;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTitle(title: title),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final actor = actors[index];
              return SizedBox(
                  width: 100,
                  child: InkWell(
                    onTap: () => context.push("/actors/${actor.id}"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 30,
                            child:
                                ClipOval(child: Image.network(actor.imageUrl))),
                        Text(
                          actor.name,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ));
            },
            itemCount: actors.length,
          ))
        ],
      ),
    );
  }
}
