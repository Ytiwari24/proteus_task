import 'dart:convert';

class Folder {
  String title;
  List<Folder> subFolders;
  List<Option> options;
  String id;
  String icon;

  Folder({
    required this.title,
    required this.subFolders,
    required this.options,
    required this.id,
    required this.icon,
  });
}

class Option {
  String title;
  String id;
  String icon;

  Option({
    required this.title,
    required this.id,
    required this.icon,
  });
}

Folder parseFolder(String jsonData) {
  final Map<String, dynamic> data = json.decode(jsonData);
  return _parseFolder(data['APPLICATION']['FOLDER']);
}

Folder _parseFolder(dynamic data) {
  if (data is Map<String, dynamic>) {
    final List<Folder> subFolders = [];
    final List<Option> options = [];

    if (data['FOLDER'] != null) {
      if (data['FOLDER'] is List) {
        subFolders.addAll((data['FOLDER'] as List).map((folder) {
          return _parseFolder(folder);
        }).cast<Folder>());
      } else if (data['FOLDER'] is Map) {
        subFolders.add(_parseFolder(data['FOLDER']));
      }
    }

    if (data['OPTION'] != null) {
      options.addAll((data['OPTION'] as List).map((option) {
        return Option(
          title: option['TITLE'],
          id: option['_id'],
          icon: option['_icon'],
        );
      }).cast<Option>());
    }

    return Folder(
      title: data['TITLE'],
      subFolders: subFolders,
      options: options,
      id: data['_id'],
      icon: data['_icon'],
    );
  } else {
    throw ArgumentError('Invalid data type for folder');
  }
}