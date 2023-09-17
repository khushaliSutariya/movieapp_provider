import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/models/Movie.dart';
import 'package:movieapp/screens/Homepage.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../controllers/Movie_Provider.dart';
import '../resources/URLResources.dart';
import 'Add_Review_Screens.dart';
import 'View_Review_Screens.dart';

class DiscriptionScreens extends StatefulWidget {
  Movie alldata;
  DiscriptionScreens({Key? key, required this.alldata}) : super(key: key);

  @override
  State<DiscriptionScreens> createState() => _DiscriptionScreensState();
}

class _DiscriptionScreensState extends State<DiscriptionScreens> {
  MovieProvider provider = MovieProvider();
  getData() async {
    await provider.movielist();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<MovieProvider>(context, listen: false);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    provider = Provider.of<MovieProvider>(context, listen: true);
    var posterPath = widget.alldata.posterPath.toString();
    var image = URLResources.imageUrl + posterPath;
    var rateing = widget.alldata.voteAverage.toString();
    var myrateing = double.parse(rateing);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: size.width * double.infinity,
                    height: size.height * 0.4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: Image.asset(
                          "img/joker.jpg",
                          height: size.height * 0.15,
                        )),
                        errorWidget: (context, url, error) => Image.asset(
                          "img/Movie.jpg",
                          height: size.height * 0.15,
                          width: size.width * 0.3,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.06,
                    left: size.width * 0.05,
                    child: Container(
                      width: size.width * 0.07,
                      height: size.height * 0.035,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Homepage(),
                          ));
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.055,
                    right: size.width * 0.05,
                    child: Container(
                      width: size.width * 0.07,
                      height: size.height * 0.035,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.alldata.title.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            fontFamily: "Oswald")),
                    const SizedBox(
                      height: 10.0,
                    ),
                    RatingBar.builder(
                      initialRating: myrateing,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 10,
                      itemSize: 25,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text("Language: ${widget.alldata.originalLanguage}",
                        style: const TextStyle(
                            fontSize: 20.0, fontFamily: "Roboto")),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Overview:",
                        style: TextStyle(fontSize: 20.0, fontFamily: "Roboto")),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ReadMoreText(
                      widget.alldata.overview.toString(),
                      trimLines: 3,
                      style: const TextStyle(fontSize: 17.0),
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Read less',
                      lessStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      moreStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.1,
          width: size.width * 0.05,
          decoration: BoxDecoration(
            color: const Color(0xff0F0D3C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      var id = widget.alldata.id;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewReviewScreens(reviewid: id ?? 0),
                      ));
                    },
                    child: Text(
                      "View Review",
                      style: TextStyle(fontSize: 17.0, color: Colors.white),
                    )),
                InkWell(
                  onTap: () {
                    var id = widget.alldata.id;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddReviewScreens(movieid: id ?? 0,),
                    ));
                  },
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Colors.white),
                    child: const Center(
                        child: Text(
                      "Add Review",
                      style: TextStyle(color: Colors.blue, fontSize: 17.0),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
