class UserModel {
  String avatar_url;
  String name;
  String login;
  String html_url;
  int followers;
  int following;
  int public_repos;

  UserModel({
    required this.avatar_url,
    required this.name,
    required this.login,
    required this.html_url,
    required this.followers,
    required this.following,
    required this.public_repos,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    String avatar_url = jsonData['avatar_url'] as String;
    String name = jsonData['name'] as String;
    String login = jsonData['login'] as String;
    String html_url = jsonData['html_url'] as String;
    int followers = jsonData['followers'] as int;
    int following = jsonData['following'] as int;
    int public_repos = jsonData['public_repos'] as int;

    return UserModel(
      avatar_url: avatar_url,
      name: name,
      login: login,
      html_url: html_url,
      followers: followers,
      following: following,
      public_repos: public_repos,
    );
  }
}
