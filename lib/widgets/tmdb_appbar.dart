 import 'package:flutter/material.dart';
import 'package:upcoming_movies/config/routes_names.dart';
import 'package:upcoming_movies/utils/shared/colors.dart';
import 'package:upcoming_movies/utils/shared/font_sizes.dart';
import 'package:upcoming_movies/utils/shared/spacings.dart';
import 'package:upcoming_movies/utils/shared/width_height_sizes.dart';
import 'package:upcoming_movies/views/movies/search_movies.dart';
import 'package:upcoming_movies/widgets/background_circle_widget.dart';

AppBar tmdbAppBar(String text, BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      elevation: 1,
      backgroundColor: appbarColor,
      title: Text(text, style: const TextStyle(
        fontSize: normalHeadingTextSizes, 
        fontWeight: FontWeight.bold, 
        color: Colors.white, letterSpacing: 2)
      ),
      actions: [


        IconButton(
          onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieSearchScreen(),));


          }, 
          icon: const Icon(
            Icons.search, 
            size: normalIconSize, 
            color: iconsColor
          )
        ),
        width10,
        // BackgroundCircle(
        //   child: IconButton(
        //     onPressed: (){
        //     }, 
        //     icon: const Icon(
        //       Icons.person, 
        //       size: personIconSize,
        //       color: iconsColor,
        //     )
        //   ),
        //   color: const Color.fromARGB(255, 255, 255, 255),
        //   height: 30,
        //   width: 30
        // ),
        // width10

      ],
    );
  }
