import 'package:random_user/random_user.dart';

main() async {
  final api = RandomUser();

  final randomUser = await api.getUser();
  print("Just a random user's email:");
  print(randomUser.email);

  final randomList = await api.getUsers(results: 3);
  print("Three random users:");
  randomList.forEach((u) => print("${u.name.first} ${u.name.last}"));

  final knownUser = await api.getUsersWithInfo(seed: 'flutter');
  print("Always the same user:");
  print(knownUser.results.first.login.username);
}
