import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class Route {
  Route({required this.path, required this.label, required this.iconData});
  final String path;
  final String label;
  final IconData iconData;
}

var homePath = Route(path: '/home', label: 'Home', iconData: Icons.home);
var searchPath =
    Route(path: '/search', label: 'Search', iconData: Icons.search);
var profilePath =
    Route(path: '/profile', label: 'Profile', iconData: Icons.person);
var paths = [homePath, searchPath, profilePath];
