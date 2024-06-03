import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MultiModel {
  final int id;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  final String? title;
  final String? name;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  final double? voteAverage;
  final String? releaseDate;
  final String? firstAirDate;
  final String? backdropPath;

  MultiModel({
    required this.id,
    required this.mediaType,
    this.title,
    this.name,
    required this.overview,
    String? posterPath,
    required this.genreIds,
    this.voteAverage,
    this.releaseDate,
    this.firstAirDate,
    String? backdropPath,
  })  : backdropPath = backdropPath != null
            ? 'https://image.tmdb.org/t/p/w500/$backdropPath'
            : null,
        posterPath = posterPath != null
            ? 'https://image.tmdb.org/t/p/w500/$posterPath'
            : null;

  factory MultiModel.fromJson(Map<String, dynamic> json) {
    return MultiModel(
      id: json['id'],
      mediaType: json['media_type'],
      title: json['title'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      genreIds: List<int>.from(json['genre_ids']),
      voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      firstAirDate: json['first_air_date'],
      backdropPath: json['backdrop_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'media_type': mediaType,
      'title': title,
      'name': name,
      'overview': overview,
      'poster_path': posterPath,
      'genre_ids': genreIds,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'first_air_date': firstAirDate,
      'backdrop_path': backdropPath
    };
  }
}
