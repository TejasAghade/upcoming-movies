import 'package:flutter/material.dart';
import 'package:upcoming_movies/config/routes_names.dart';
import 'package:upcoming_movies/views/auth_screens/login_screen.dart';
import 'package:upcoming_movies/views/movies/movie_details_screen.dart';
import 'package:upcoming_movies/views/movies/movies_list_screen.dart';
import 'package:upcoming_movies/views/movies/search_movies.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const LoginScreen(),
  '/$moviesListPageRoute': (context) => const MoviesListScreen(),
  '/$movieDetailsPageRoute': (context) =>  MovieDetailsScreen(movieId: '',),
  '/$searchScreenRoute': (context) =>  MovieSearchScreen(),
};
