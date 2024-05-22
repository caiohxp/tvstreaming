class SerieModel {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final double? voteAverage;
  final int? voteCount;

  SerieModel({
    this.adult,
    String? backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    String? posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  })  : backdropPath = 'https://image.tmdb.org/t/p/original/$backdropPath',
        posterPath = 'https://image.tmdb.org/t/p/original/$posterPath';

  factory SerieModel.fromJson(Map<String, dynamic> json) {
    return SerieModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      firstAirDate: json['first_air_date'],
      name: json['name'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  @override
  String toString() {
    return 'SerieModel(adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originCountry: $originCountry, originalLanguage: $originalLanguage, originalName: $originalName, overview: $overview, popularity: $popularity, posterPath: $posterPath, firstAirDate: $firstAirDate, name: $name, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}
