import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/resources/URLResources.dart';
import 'package:movieapp/screens/SearchResult_Screens.dart';
import 'package:provider/provider.dart';

import '../controllers/Movie_Provider.dart';
import 'Discription_Screens.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  MovieProvider provider = MovieProvider();
  ScrollController scrollController = ScrollController();

  FocusNode focusNode = FocusNode();
  bool defaultimage = true;
  bool imageloader = true;

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

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "Moviez",
                            style: TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text("Watch much easier",
                              style: TextStyle(
                                  fontSize: 14.0, color: Color(0xffD6D5D7))),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchResultScreens(),
                          ));
                        },
                        icon: Image.asset("img/search.png",
                            height: size.height * 0.03,
                            width: size.width * 0.05),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "From Disney",
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: (provider.isloading)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.allmoviedata.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        var posterpath =
                            provider.allmoviedata[index].posterPath.toString();
                        var image = URLResources.imageUrl + posterpath;
                        var rateing =
                            provider.allmoviedata[index].voteAverage.toString();
                        var myrateing = double.parse(rateing);

                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, left: 20.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DiscriptionScreens(
                                      alldata: provider.allmoviedata[index],
                                    ),
                                  ));
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        imageUrl: image,
                                        height: size.height * 0.15,
                                        placeholder: (context, url) => Center(
                                            child: Image.asset(
                                          "img/joker.jpg",
                                          height: size.height * 0.15,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "img/Movie.jpg",
                                          height: size.height * 0.15,
                                          width: size.width * 0.3,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Title: ${provider.allmoviedata[index].originalTitle}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                  fontFamily: "Oswald")),
                                          const SizedBox(height: 5.0),
                                          Text(
                                              "OverView: ${provider.allmoviedata[index].overview}",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: "Roboto")),
                                          const SizedBox(height: 7.0),
                                          RatingBar.builder(
                                            initialRating: myrateing,
                                            minRating: 1,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 10,
                                            itemSize: 25,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Divider(
                                color: Colors.black26,
                                height: 5,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
