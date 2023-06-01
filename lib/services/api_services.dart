import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:upcoming_movies/models/all_movies_model.dart';
import 'package:upcoming_movies/models/movie_details_model.dart';
import 'package:upcoming_movies/models/movie_images_model.dart';
import 'package:upcoming_movies/models/movie_videos_model.dart';
import 'package:upcoming_movies/utils/constants/api_keys.dart';
import 'package:upcoming_movies/utils/constants/api_request_urls.dart';


// get all the upcoming movie list

Future<GetAllMoviesModel> fetchAllMovies() async{

  GetAllMoviesModel movies = GetAllMoviesModel();

  try{
    final response = await http.get(Uri.parse("$the_movie_db_upcoming_movies_api/upcoming?page=2&api_key=$tmdb_api_key"));
    if(response.statusCode == 200){
       var moviesJsonList = json.decode(response.body);
      log("called api");
      movies=  GetAllMoviesModel.fromJson(moviesJsonList);
      return movies;
    }else{
      log("failed");
      throw Exception("failed to fetch movies");
    }

    
  }catch(err){
    throw Exception(err);
  }

}
Future<GetAllMoviesModel> searchMovies(String query) async{

  GetAllMoviesModel movies = GetAllMoviesModel();

  try{
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?query=$query&api_key=$tmdb_api_key"));
    if(response.statusCode == 200){
       var moviesJsonList = json.decode(response.body);
      log("called api");
      movies=  GetAllMoviesModel.fromJson(moviesJsonList);
      return movies;
    }else{
      log("failed");
      throw Exception("failed to fetch movies");
    }

    
  }catch(err){
    throw Exception(err);
  }

}


// api call to get all videos of movie by movieId

Future<MovieVideosModel> fetchMovieVideos(String movieId) async{

  // MovieVideosModel videos;

  try{
    final response = await http.get(Uri.parse("$the_movie_db_upcoming_movies_api/$movieId/videos?api_key=$tmdb_api_key"));
    if(response.statusCode == 200){
       var movieVideosList = json.decode(response.body);
      
      // return movieVideosList.map((json) => MovieVideosModel.fromJson(json)).toList();
      return MovieVideosModel.fromJson(movieVideosList);
    }else{
      throw Exception("failed to fetch movies");
    }

    
  }catch(err){
    throw Exception(err);
  }

}

// api call to get movie detail by movieId

Future<MovieDetailsModel> fetchMovieDetails(String movieId) async{
  try{
    final response = await http.get(Uri.parse("$the_movie_db_upcoming_movies_api/$movieId?api_key=$tmdb_api_key"));
    if(response.statusCode == 200){
      var movieDetails = json.decode(response.body);
      return MovieDetailsModel.fromJson(movieDetails);
    }else{
      throw Exception("failed to fetch movies");
    }

    
  }catch(err){
    throw Exception(err);
  }

}

// get movie images

Future<MovieImagesModel> fetchMovieImages(String movieId) async{
  try{
    final response = await http.get(Uri.parse("$the_movie_db_upcoming_movies_api/$movieId/images?api_key=$tmdb_api_key"));
    if(response.statusCode == 200){
       var movieImages = json.decode(response.body);

      return MovieImagesModel.fromJson(movieImages);
    }else{
      throw Exception("failed to fetch movies");
    }

    
  }catch(err){
    throw Exception(err);
  }

}