import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../controllers/Movie_Provider.dart';
import '../resources/URLResources.dart';

class SearchResultScreens extends StatefulWidget {
  const SearchResultScreens({Key? key}) : super(key: key);

  @override
  State<SearchResultScreens> createState() => _SearchResultScreensState();
}

class _SearchResultScreensState extends State<SearchResultScreens> {
  TextEditingController _searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  MovieProvider provider = MovieProvider();
  getData() async {
    await provider.searchmovie(_searchController.text);
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
        backgroundColor: Color(0xffF8F8FA),
        body: (provider.isloading)
            ? const Center(
                child: Text("No Data Found"),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      cursorColor: Colors.black,
                      focusNode: focusNode,
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) async {
                        await provider.searchmovie(_searchController.text);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Serch Result (${provider.allmoviedSerchdata.length})",
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.allmoviedSerchdata.length,
                        itemBuilder: (context, index) {
                          var posterpath = provider
                              .allmoviedSerchdata[index].posterPath
                              .toString();
                          var image = URLResources.imageUrl + posterpath;
                          var rateing = provider
                              .allmoviedSerchdata[index].voteAverage
                              .toString();
                          var myrateing = double.parse(rateing);

                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl:image, height: size.height * 0.15,
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => Image.asset("img/Movie.jpg", height: size.height * 0.15,
                                            width: size.width * 0.3,),
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
                                                "Title: ${provider
                                                        .allmoviedSerchdata[
                                                            index]
                                                        .originalTitle}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,fontFamily: "Oswald")),
                                            Text(
                                                "OverView: ${provider
                                                        .allmoviedSerchdata[
                                                            index]
                                                        .overview}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    TextStyle(fontSize: 12.0,fontFamily: "Roboto")),
                                            RatingBar.builder(
                                              initialRating: myrateing,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 10,
                                              itemSize: 25,
                                              itemPadding: const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.symmetric(
              horizontal: size.width * 0.2, vertical: size.width * 0.03),
          child: Container(
            height: size.height * 0.06,
            width: size.width * 0.05,
            decoration: BoxDecoration(
              color: const Color(0xff0F0D3C),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: const Center(
                child: Text(
              "Suggest Movie",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
