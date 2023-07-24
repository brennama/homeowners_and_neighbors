String input = '''
N N0 E:7 W:7 R:10
N N1 E:2 W:1 R:1
N N2 E:7 W:6 R:4
H H0 E:3 W:9 R:2 N2>N0>N1
H H1 E:4 W:3 R:7 N0>N2>N1
H H2 E:4 W:0 R:10 N0>N2>N1
H H3 E:10 W:3 R:8 N2>N0>N1
H H4 E:6 W:10 R:1 N0>N2>N1
H H5 E:6 W:7 R:7 N0>N2>N1
H H6 E:8 W:6 R:9 N2>N1>N0
H H7 E:7 W:1 R:5 N2>N1>N0
H H8 E:8 W:2 R:3 N1>N0>N2
H H9 E:10 W:2 R:1 N1>N2>N0
H H10 E:6 W:4 R:5 N0>N2>N1
H H11 E:8 W:4 R:7 N0>N1>N2
''';

class Neighborhood {
  final String id;
  final Map<String, int> scores;

  Neighborhood(this.id, this.scores);
}

class HomeBuyer {
  final String id;
  final Map<String, int> goals;
  final List<String> preferences;

  HomeBuyer(this.id, this.goals, this.preferences);
}

List<Neighborhood> setN = [];
List<HomeBuyer> setH = [];

void parseInput(String input) {
  final lines = input.split('\n');
  for (final line in lines) {
    if (line.startsWith('N')) {
      final neighborhood = parseNeighborhood(line.substring(2));
      setN.add(neighborhood);
    } else if (line.startsWith('H')) {
      final homeBuyer = parseHomeBuyer(line.substring(2));
      setH.add(homeBuyer);
    }
  }
}

Neighborhood parseNeighborhood(String data) {
  final parts = data.split(' ');
  final id = parts[0];
  final scores = Map<String, int>();
  for (int i = 1; i < parts.length; i++) {
    final keyValuePair = parts[i].split(':');
    final key = keyValuePair[0];
    final value = int.parse(keyValuePair[1]);
    scores[key] = value;
  }
  return Neighborhood(id, scores);
}

HomeBuyer parseHomeBuyer(String data) {
  final parts = data.split(' ');
  final id = parts[0];
  final goals = Map<String, int>();
  final preferences = parts.last.split('>');
  for (int i = 1; i < parts.length - 1; i++) {
    final keyValuePair = parts[i].split(':');
    final key = keyValuePair[0];
    final value = int.parse(keyValuePair[1]);
    goals[key] = value;
  }
  return HomeBuyer(id, goals, preferences);
}
