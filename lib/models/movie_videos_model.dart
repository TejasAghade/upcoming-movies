// To parse this JSON data, do
//
//     final movieDataModel = movieDataModelFromJson(jsonString);

import 'dart:convert';

MovieVideosModel movieDataModelFromJson(String str) => MovieVideosModel.fromJson(json.decode(str));

String movieDataModelToJson(MovieVideosModel data) => json.encode(data.toJson());

class MovieVideosModel {
    int? id;
    List<result>? results;

    MovieVideosModel({
        this.id,
        this.results,
    });

    factory MovieVideosModel.fromJson(Map<String, dynamic> json) => MovieVideosModel(
        id: json["id"],
        results: json["results"] == null ? [] : List<result>.from(json["results"]!.map((x) => result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class result {
    Iso6391? iso6391;
    Iso31661? iso31661;
    String? name;
    String? key;
    Site? site;
    int? size;
    String? type;
    bool? official;
    DateTime? publishedAt;
    String? id;

    result({
        this.iso6391,
        this.iso31661,
        this.name,
        this.key,
        this.site,
        this.size,
        this.type,
        this.official,
        this.publishedAt,
        this.id,
    });

    factory result.fromJson(Map<String, dynamic> json) => result(
        iso6391: iso6391Values.map[json["iso_639_1"]]!,
        iso31661: iso31661Values.map[json["iso_3166_1"]]!,
        name: json["name"],
        key: json["key"],
        site: siteValues.map[json["site"]]!,
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391Values.reverse[iso6391],
        "iso_3166_1": iso31661Values.reverse[iso31661],
        "name": name,
        "key": key,
        "site": siteValues.reverse[site],
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt?.toIso8601String(),
        "id": id,
    };
}

enum Iso31661 { US }

final iso31661Values = EnumValues({
    "US": Iso31661.US
});

enum Iso6391 { EN }

final iso6391Values = EnumValues({
    "en": Iso6391.EN
});

enum Site { YOU_TUBE }

final siteValues = EnumValues({
    "YouTube": Site.YOU_TUBE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
