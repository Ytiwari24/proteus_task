import 'dart:convert';

import 'package:flutter/material.dart';

import '../controller/data_controller.dart';
import '../data/data.dart';
import '../model/data_model.dart';
import '../model/option_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool sales = true;
bool foreign = true;
bool benefit = true;


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var response = ApplicationResponse.fromJson(jsonDecode(jsonData));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tree View'),
      ),
      body: Center(
        child: buildFolderWidget(response.folder),
      ),
    );
  }

  Widget buildFolderWidget(Folder? folder) {
    if (folder == null) {
      return const Text('No data available.');
    }

    return Column(
      children: [
        ListTile(
          leading: Icon(
              folder.title == 'Sales' ? Icons.shopping_cart : Icons.newspaper),
          title: Text(
            '${folder.title}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  folder.title == 'Sales' ? sales = !sales : null;
                  folder.title == 'Foreign Trade' ? foreign = !foreign : null;
                  folder.title == 'Benefits' ? benefit = !benefit : null;
                });
              },
              icon: const Icon(
                
                Icons.remove_circle_outline_outlined)),
        ),
        Visibility(
          visible: sales,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        if (folder.folder != null)
                          Column(
                            children: [
                              if (folder.option != null)
                                Visibility(
                                  visible: foreign,
                                  child: Column(
                                    children: [
                                      for (var option in folder.option!)
                                        buildOptionWidget(option),
                                    ],
                                  ),
                                ),
                              for (var subFolder in folder.folder!)
                                buildFolderWidget(subFolder),
                            ],
                          ),
                        if (folder.option != null)
                          Visibility(
                            visible: benefit,
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < folder.option!.length && i < 2;
                                    i++) ...[
                                  Visibility(
                                    visible:
                                        folder.option![i].title == 'DEPB' ||
                                            folder.option![i].title ==
                                                'Advance Licence',
                                    child: ListTile(
                                      leading: Icon(
                                          folder.option![i].title == 'DEPB'
                                              ? Icons.percent
                                              : Icons.newspaper),
                                      title: Text('${folder.option![i].title}'),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOptionWidget(Option option) {
    return Column(
      children: [
        ListTile(
          leading:
              Icon(option.title == 'DEPB' ? Icons.percent : Icons.newspaper),
          title: Text('${option.title}'),
        ),
      ],
    );
  }
}
