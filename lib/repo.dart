import 'dart:math';

class Repo {
  static Future<List<String>> getSiteList() async {
    return [
      'Site A',
      'Site B',
      'Site C',
      'Site D',
      'Site E',
      'Site F',
      'Site G',
      'Site H',
      'Site I',
      'Site J',
      'Site K',
    ];
  }

  static Future<List<int>> getSiteData(String site, String chart) async {
    Random r = Random();
    return List.generate(7, (index) => r.nextInt(11));
  }
}