import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Review {
  Review(
      {required this.reviewText,
      required this.rating,
      required this.username,
      required this.date});
  String reviewText;
  int rating;
  String username;
  DateTime date;
}

class ListReviews extends StatefulWidget {
  const ListReviews({super.key, required this.reviews, required this.title});
  final List<Review> reviews;
  final String title;
  @override
  State<ListReviews> createState() => _ListReviewsState();
}

class _ListReviewsState extends State<ListReviews> {
  Widget _buildRatingList() {
    List<Review> reviews = widget.reviews;
    return SizedBox(
        height: 125,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var rating = reviews[index];
            return Card(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rating.username),
                      Row(
                        children: [
                          Text(DateFormat.yMMMd().format(rating.date)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Rating ${rating.rating}")
                        ],
                      ),
                      Text(rating.reviewText!)
                    ],
                  )),
            );
          },
          itemCount: reviews.length,
        ));

    // return Expanded(child: Text('abc'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(widget.title), _buildRatingList()],
    );
  }
}
