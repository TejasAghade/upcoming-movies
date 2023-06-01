import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:upcoming_movies/config/routes_names.dart';
import 'package:upcoming_movies/models/movie_details_model.dart';
import 'package:upcoming_movies/models/movie_images_model.dart';
import 'package:upcoming_movies/models/movie_videos_model.dart';
import 'package:upcoming_movies/services/api_services.dart';
import 'package:upcoming_movies/utils/constants/urls.dart';
import 'package:upcoming_movies/utils/shared/font_sizes.dart';
import 'package:upcoming_movies/utils/shared/spacings.dart';
import 'package:upcoming_movies/views/trailer_player/video_player_screen.dart';
import 'package:upcoming_movies/widgets/common_widgets.dart';
import 'package:upcoming_movies/widgets/tmdb_appbar.dart';

class MovieDetailsScreen extends StatefulWidget {
  String movieId;

  MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailsModel> movieDetails;

  String genres = "";

  // MovieImagesModel movieImages = MovieImagesModel();

  @override
  void initState() {
    // TODO: implement initState
    // movieDetails = ;
    getImags();
    super.initState();

  }

  getImags() async {
    // movieImages = await fetchMovieImages(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tmdbAppBar("Movie Details", context),
      body: FutureBuilder<MovieDetailsModel>(
          future: fetchMovieDetails(widget.movieId),
          builder: (context, AsyncSnapshot<MovieDetailsModel> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                              width: 140,
                              image: NetworkImage(
                                  imageBaseUrl + snapshot.data!.posterPath!)),
                          SizedBox(
                            width: 190,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${snapshot.data!.originalTitle!} ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                      // Text(
                                      //   "(${DateFormat("yyyy").format(snapshot.data!.releaseDate!)})",
                                      //   style: const TextStyle(
                                      //       fontSize: 22, letterSpacing: 2),
                                      // ),
                                    ],
                                  ),
                                  height10,
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat("dd/MM/yyyy")
                                            .format(snapshot.data!.releaseDate!),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "(${snapshot.data!.originalLanguage!})",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  //  Text(
                                  //       "(${snapshot.data!.!})",
                                  //       style: const TextStyle(fontSize: 16),
                                  //     ),
                                  Wrap(
                                    children: [
                                      for (var g in snapshot.data!.genres!)
                                        Text(
                                          "${g.name!} ",
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        )
                                    ],
                                  ),
                                  height10,
                                  Text(
                                    "Language : ${snapshot.data!.originalLanguage} ",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  height10,
                                  Container(
                                    width: 30,
                                    alignment: Alignment.center,
                                    // padding: EdgeInsets.all(10),
                                    color: Colors.deepPurple,
                                    child: Text(
                                      snapshot.data!.adult == true
                                          ? '18+'
                                          : '13+',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                  height10,
                                  InkWell(
                                    onTap: () async {
                                      MovieVideosModel videoModelList =
                                          await fetchMovieVideos(
                                              snapshot.data!.id.toString());
              
                                      String key = videoModelList.results!
                                          .firstWhere((element) =>
                                              element.type == "Trailer")
                                          .key!; // }
              
                                      log(key);
              
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScreen(videoKey: key),
                                          ));
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start  ,
                                      children: [
                                        Icon(
                                          Icons.play_circle,
                                          size: 48,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "Play Trailer",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  height10,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Backdrops",
                            style: TextStyle(
                                fontSize: normalHeadingTextSizes,
                                fontWeight: FontWeight.bold),
                          )),
                      height10,
                      FutureBuilder(
                          future: fetchMovieImages(widget.movieId),
                          builder: (context,
                              AsyncSnapshot<MovieImagesModel> snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.backdrops!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Image(
                                        image: NetworkImage(imageBaseUrl +
                                            snapshot.data!.backdrops![index]
                                                .filePath!),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("error occured"),
                              );
                            } else {
                              return CircularProgressIndicatorWidget();
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Overview",
                            style: TextStyle(
                                fontSize: normalHeadingTextSizes,
                                fontWeight: FontWeight.bold),
                          )),
                      height10,
                      Text(
                        "${snapshot.data!.overview!}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return const Center(child: Text("error occured"));
            } else {
              return CircularProgressIndicatorWidget();
            }
          }),
    );
  }
}
