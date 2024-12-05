class Movie {
  Movie(
      {required this.id,
      required this.title,
      required this.imageUrl,
      this.description});
  String id;
  String title;
  String imageUrl;
  String? description;
}
