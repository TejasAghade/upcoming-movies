// To parse this JSON data, do
//
//     final movieImagesModel = movieImagesModelFromJson(jsonString);

import 'dart:convert';

MovieImagesModel movieImagesModelFromJson(String str) => MovieImagesModel.fromJson(json.decode(str));

String movieImagesModelToJson(MovieImagesModel data) => json.encode(data.toJson());

class MovieImagesModel {
    List<Backdrop>? backdrops;

    MovieImagesModel({
        this.backdrops,
    });

    factory MovieImagesModel.fromJson(Map<String, dynamic> json) => MovieImagesModel(
        backdrops: json["backdrops"] == null ? [] : List<Backdrop>.from(json["backdrops"]!.map((x) => Backdrop.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "backdrops": backdrops == null ? [] : List<dynamic>.from(backdrops!.map((x) => x.toJson())),
    };
}

class Backdrop {
    double? aspectRatio;
    int? height;
    String? iso6391;
    String? filePath;
    double? voteAverage;
    int? voteCount;
    int? width;

    Backdrop({
        this.aspectRatio,
        this.height,
        this.iso6391,
        this.filePath,
        this.voteAverage,
        this.voteCount,
        this.width,
    });

    factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"]?.toDouble(),
        height: json["height"],
        iso6391: json["iso_639_1"],
        filePath: json["file_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "height": height,
        "iso_639_1": iso6391,
        "file_path": filePath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
    };
}
