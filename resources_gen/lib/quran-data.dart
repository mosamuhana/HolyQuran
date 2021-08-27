import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

final _FILE_PATH = path.join(path.current, 'resources', 'data.json');
//const API_BASE_URL = 'http://api.alquran.cloud/v1';
//const USER_AGENT_HEADER = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36';
const _API_URL = 'http://api.alquran.cloud/v1/quran/quran-uthmani';
const _AR_SURAH = 'سُورَةُ';
const _MECCAN = 'Meccan';
//const _MEDINAN = 'Medinan';

class DataLoader {
  final File file;
  DataLoader() : file = File(_FILE_PATH);

  Future<Map<String, dynamic>?> load() async {
    try {
      final map = await _load();
      await file.writeAsString(_jsonEncode(map));
      final prettyFile = File(path.setExtension(file.path, '.prettified.json'));
      await prettyFile.writeAsString(_jsonEncode(map, prettify: true));
      return map;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> _load() async {
    final r = await http.get(Uri.parse(_API_URL));
    if (r.statusCode != 200) throw Exception(r.reasonPhrase);
    Map<String, dynamic> rawData = jsonDecode(r.body);

    final list = rawData['data']['surahs'] as List;
    final surahs = [];
    final ayahs = [];
    for (var surahMap in list) {
      final rawAyahs = surahMap['ayahs'] as Iterable<dynamic>;
      surahs.add(_transformSurah(surahMap));
      for (var ayahData in rawAyahs) {
        ayahs.add(_transformAyah(ayahData, surahMap['number']?.toInt()));
      }
    }
    return {'surahs': surahs, 'ayahs': ayahs};
  }

  static List _transformSurah(Map<String, dynamic> map) {
    final revelationType = map['revelationType'] as String;
    final int id = map['number']?.toInt();
    final name = (map['name'] as String).split(_AR_SURAH)[1].trim();
    final englishName = map['englishName'] as String;
    final englishNameTranslation = map['englishNameTranslation'] as String;
    final isMeccan = revelationType == _MECCAN ? 1 : 0;
    return [
      id,
      name,
      englishName,
      englishNameTranslation,
      isMeccan,
    ];
  }

  static List _transformAyah(Map<String, dynamic> map, int surah) {
    final int id = map['number'].toInt();
    final content = map['text'] as String;
    final int order = map['numberInSurah'].toInt();
    final int juz = map['juz'].toInt();
    final int manzil = map['manzil'].toInt();
    final int page = map['page'].toInt();
    final int ruku = map['ruku'].toInt();
    final int hizbQuarter = map['hizbQuarter'].toInt();
    final sajda = !(map['sajda'] is bool) ? 1 : 0;

    return [
      id,
      content,
      order,
      juz,
      manzil,
      page,
      ruku,
      hizbQuarter,
      sajda,
      surah,
    ];
  }
}

String _jsonEncode(Object? object, {bool prettify = false}) {
  if (!prettify) return jsonEncode(object);
  final encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(object);
}
