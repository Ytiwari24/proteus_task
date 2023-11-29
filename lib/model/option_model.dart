class Option {
  String? title;
  String? id;
  String? icon;

  Option({this.title, this.id, this.icon});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      title: json['TITLE'],
      id: json['_id'],
      icon: json['_icon'],
    );
  }
}