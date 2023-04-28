class QRModel {
  int? id;
  String title;
  String observation;
  String url;
  String dateTime;

  QRModel({
    this.id,
    required this.title,
    required this.observation,
    required this.url,
    required this.dateTime,
  });

  factory QRModel.fromJson(Map<String, dynamic> json) => QRModel(
        id: json["id"],
        title: json["title"],
        observation: json["observation"],
        url: json["url"],
        dateTime: json["datetime"],
      );

  toJson() => {
        "title": title,
        "observation": observation,
        "url": url,
        "datetime": dateTime,
      };
}
