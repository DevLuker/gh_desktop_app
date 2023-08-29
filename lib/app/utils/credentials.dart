final authorizationEndpoint = Uri.parse(
  'https://github.com/login/oauth/authorize',
);
final tokenEndpoint = Uri.parse(
  'https://github.com/login/oauth/access_token',
);

const githubScopes = [
  'repo',
  'read:org',
];

const ghClientId = 'YOUR_GITHUB_CLIENT_ID_HERE';
const ghClientSecret = 'YOUR_GITHUB_CLIENT_SECRET_HERE';
