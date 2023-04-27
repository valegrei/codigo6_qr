class QRModel {
  String title;
  String observation;
  String url;
  String dateTime;

  QRModel({
    required this.title,
    required this.observation,
    required this.url,
    required this.dateTime,
  });

  factory QRModel.fromJson(Map<String, dynamic> json) => QRModel(
        title: json["title"],
        observation: json["observation"],
        url: json["url"],
        dateTime: json["dateTime"],
      );

  toJson() => {
        "title": title,
        "observation": observation,
        "url": url,
        "dateTime": dateTime,
      };
}
