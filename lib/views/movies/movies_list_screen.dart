import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upcoming_movies/models/all_movies_model.dart';
import 'package:upcoming_movies/services/api_services.dart';
import 'package:upcoming_movies/utils/constants/titles_texts.dart';
import 'package:upcoming_movies/utils/constants/urls.dart';
import 'package:upcoming_movies/utils/shared/font_sizes.dart';
import 'package:upcoming_movies/utils/shared/spacings.dart';
import 'package:upcoming_movies/views/movies/movie_widgets/movie_list_widget.dart';
import 'package:upcoming_movies/widgets/common_widgets.dart';
import 'package:upcoming_movies/widgets/tmdb_appbar.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late Future<GetAllMoviesModel> moviesList;

  @override
  void initState() {
    super.initState();
    moviesList = fetchAllMovies();
  }

  // getMovieList() {
  //   setState(() {

  //   });
  //   log("called getmoveis");
  // }

  var screenWidth;
  var screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: tmdbAppBar("Upcoming Movies", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              MoviesListWidget(moviesList: moviesList, screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
  
}
