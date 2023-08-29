import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gh_desktop_app/app/utils/launch_url.dart';
import 'package:github/github.dart';

class RepositoriesList extends StatefulWidget {
  const RepositoriesList({required this.gitHub, Key? key}) : super(key: key);
  final GitHub gitHub;

  @override
  State<RepositoriesList> createState() => _RepositoriesListState();
}

class _RepositoriesListState extends State<RepositoriesList> {
  late Future<List<Repository>> _repositories;

  @override
  initState() {
    super.initState();
    _repositories = widget.gitHub.repositories.listRepositories().toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Repository>>(
      future: _repositories,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var repositories = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) {
            var repository = repositories[index];
            return ListTile(
              title:
                  Text('${repository.owner?.login ?? ''}/${repository.name}'),
              subtitle: Text(repository.description),
              onTap: () => customLaunchUrl(
                context,
                Uri.parse(
                  repository.htmlUrl,
                ),
              ),
            );
          },
          itemCount: repositories!.length,
        );
      },
    );
  }
}
