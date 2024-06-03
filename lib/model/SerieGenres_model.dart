class SerieGenreModel {
  final int id;
  final String name;

  SerieGenreModel({required this.id, required this.name});

  factory SerieGenreModel.fromJson(Map<String, dynamic> json) {
    return SerieGenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
