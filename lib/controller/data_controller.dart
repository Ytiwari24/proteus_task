import '../model/data_model.dart';

class ApplicationResponse {
  Folder? folder;

  ApplicationResponse({this.folder});

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationResponse(
      folder: json['APPLICATION'] == null
          ? null
          : Folder.fromJson(json['APPLICATION']['FOLDER']),
    );
  }
}
