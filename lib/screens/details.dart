import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';
import 'package:hyrule/utils/theme.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.entry});
  final Entry entry;

  final DaoController _daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detalhes"),
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.red,
          child: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          onPressed: () {
            _daoController.saveEntry(entry: entry);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Favoritado")));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      entry.name.toUpperCase(),
                      style: EntryDecoration.titleText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Wrap(
                      children: entry
                          .commonLocationsConverte()
                          .map((e) => Chip(label: Text(e)))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        entry.image,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Text(
                      entry.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
