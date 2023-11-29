import 'option_model.dart';

class Folder {
  String? title;
  String? id;
  String? icon;
  List<Folder>? folder;
  List<Option>? option;

  Folder({this.title, this.id, this.icon, this.folder, this.option});

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      title: json['TITLE'],
      id: json['_id'],
      icon: json['_icon'],
      folder: _parseFolderList(json['FOLDER']),
      option: _parseOptionList(json['OPTION']),
    );
  }

  static List<Folder>? _parseFolderList(dynamic folderList) {
    if (folderList is List) {
      return folderList.map((item) => Folder.fromJson(item)).toList();
    } else if (folderList is Map<String, dynamic>) {
     
      return [Folder.fromJson(folderList)];
    }
    return null;
  }

  static List<Option>? _parseOptionList(dynamic optionList) {
    if (optionList is List) {
      return optionList.map((item) => Option.fromJson(item)).toList();
    }
    return null;
  }
}

