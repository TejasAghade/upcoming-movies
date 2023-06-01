import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:upcoming_movies/config/routes_names.dart';
import 'package:upcoming_movies/models/all_movies_model.dart';
import 'package:upcoming_movies/utils/constants/urls.dart';
import 'package:upcoming_movies/utils/shared/spacings.dart';
import 'package:upcoming_movies/views/movies/movie_details_screen.dart';
import 'package:upcoming_movies/widgets/common_widgets.dart';

FutureBuilder<GetAllMoviesModel> MoviesListWidget(
    {required Future<GetAllMoviesModel> moviesList,
    required double screenHeight,
    required double screenWidth}) {
  return FutureBuilder<GetAllMoviesModel>(
      future: moviesList,
      builder: (context, AsyncSnapshot<GetAllMoviesModel> snapshot) {
        return SizedBox(
          height: screenHeight * 0.9,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: (1 / 2.2)),
            itemCount: snapshot.data?.results?.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicatorWidget();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("data error"),
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: snapshot.data!.results![index].id.toString()),));
                    },
                    child: Card(
                      elevation: 1,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                image: NetworkImage(imageBaseUrl +
                                    snapshot.data!.results![index].posterPath!)),
                            height10,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                snapshot.data!.results![index].originalTitle!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),
                              ),
                            ),
                            height10,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                DateFormat("dd-MM-yyyy").format(
                                    snapshot.data!.results![index].releaseDate!),
                                style: const TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicatorWidget();
              }
            },
          ),
        );
      });
}
