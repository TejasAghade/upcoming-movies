import 'package:flutter/material.dart';
import 'package:upcoming_movies/models/all_movies_model.dart';
import 'package:upcoming_movies/services/api_services.dart';
import 'package:upcoming_movies/views/movies/movie_widgets/movie_list_widget.dart';
import 'package:upcoming_movies/widgets/tmdb_appbar.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  TextEditingController searchController = TextEditingController();

   late Future<GetAllMoviesModel> searchModel;

  @override
  void initState() {
    super.initState();
    searchModel = fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tmdbAppBar("Search Movie", context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 39,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      searchModel = searchMovies(searchController.text);
                      setState(() {
                        
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search...",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  color: Colors.red,
                  height: 39,
                  onPressed: () {
                    // if(searchController.text !=""){
                      searchModel = searchMovies(searchController.text);
                      setState(() {
                        
                      });
                    // }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
           const SizedBox(
              height: 10,
            ),
           const Divider(),
           const SizedBox(
              height: 10,
            ),
            MoviesListWidget(
                moviesList: searchModel,
                screenHeight: MediaQuery.of(context).size.height,
                screenWidth: MediaQuery.of(context).size.width)
          ],
        ),
      ),
    );
  }
}
