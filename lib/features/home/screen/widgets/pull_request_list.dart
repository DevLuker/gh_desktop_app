import 'package:flutter/material.dart';
import 'package:gh_desktop_app/app/utils/launch_url.dart';
import 'package:github/github.dart';

class PullRequestsList extends StatefulWidget {
  const PullRequestsList({required this.gitHub, Key? key}) : super(key: key);
  final GitHub gitHub;

  @override
  State<PullRequestsList> createState() => _PullRequestsListState();
}

class _PullRequestsListState extends State<PullRequestsList> {
  late Future<List<PullRequest>> _pullRequests;

  @override
  initState() {
    super.initState();
    _pullRequests = widget.gitHub.pullRequests
        .list(RepositorySlug('flutter', 'flutter'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PullRequest>>(
      future: _pullRequests,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var pullRequests = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) {
            var pullRequest = pullRequests[index];
            return ListTile(
              title: Text(pullRequest.title ?? ''),
              subtitle: Text('flutter/flutter '
                  'PR #${pullRequest.number} '
                  'opened by ${pullRequest.user?.login ?? ''} '
                  '(${pullRequest.state?.toLowerCase() ?? ''})'),
              onTap: () => customLaunchUrl(
                context,
                Uri.parse(
                  pullRequest.htmlUrl ?? '',
                ),
              ),
            );
          },
          itemCount: pullRequests!.length,
        );
      },
    );
  }
}
