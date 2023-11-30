import 'package:flutter/material.dart';

import '../model/data_model.dart';

class HomePage extends StatelessWidget {
  final String jsonData;

  const HomePage({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    Folder rootFolder = parseFolder(jsonData);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tree View'),
      ),
      body: _buildTreeView(rootFolder),
    );
  }

  Widget _buildTreeView(Folder folder) {
    return ListTile(
      title: Text(folder.title),
      leading: const Icon(Icons.folder),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...folder.options.map((option) => ListTile(
                title: Text(option.title),
                leading: const Icon(Icons.file_copy),
              )),
          ...folder.subFolders.map((subFolder) => _buildTreeView(subFolder)),
        ],
      ),
    );
  }
}
