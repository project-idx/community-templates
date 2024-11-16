import 'package:flutter/material.dart';

class Route extends NavigationDestination {
  Route({
    super.key,
    required this.path,
    required super.label,
    required this.iconData,
  }) : super(icon: Icon(iconData));
  final String path;
  final IconData iconData;
}

final homePath = Route(
  path: '/home',
  label: 'Home',
  iconData: Icons.home,
);
final searchPath = Route(
  path: '/search',
  label: 'Search',
  iconData: Icons.search,
);
final profilePath = Route(
  path: '/profile',
  label: 'Profile',
  iconData: Icons.person,
);

final paths = [homePath, searchPath, profilePath];
