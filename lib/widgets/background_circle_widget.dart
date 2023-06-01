
import 'package:flutter/material.dart';
import 'package:upcoming_movies/utils/shared/width_height_sizes.dart';

Container BackgroundCircle({required Widget child, required Color color,required double height, required double width}) {
  return Container(
        height: height,
        width: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(1000)
        ),
        child: child 
      );
}