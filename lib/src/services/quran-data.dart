import 'dart:io';
import 'dart:convert';

import '../app-context.dart';

const _AR_SURAH = 'سُورَةُ';
const _MECCAN = 'Meccan';
const _MEDINAN = 'Medinan';

class Surah {
  final int id; // number
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;

  Surah({
    required this.id,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
  });

  @override
  String toString() => 'Surah(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Surah &&
        other.id == id &&
        other.name == name &&
        other.englishName == englishName &&
        other.englishNameTranslation == englishNameTranslation &&
        other.revelationType == revelationType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        englishName.hashCode ^
        englishNameTranslation.hashCode ^
        revelationType.hashCode;
  }
}

class Ayah {
  final int id; // number
  final String content;
  final int order; // numberInSurah
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;
  final int surah;

  Ayah({
    required this.id,
    required this.content,
    required this.order,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    required this.surah,
  });

  @override
  String toString() =>
      'Ayah(id: $id, surah: $surah, text: $content, order: $order)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ayah &&
        other.id == id &&
        other.content == content &&
        other.order == order &&
        other.juz == juz &&
        other.manzil == manzil &&
        other.page == page &&
        other.ruku == ruku &&
        other.hizbQuarter == hizbQuarter &&
        other.sajda == sajda &&
        other.surah == surah;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        order.hashCode ^
        juz.hashCode ^
        manzil.hashCode ^
        page.hashCode ^
        ruku.hashCode ^
        hizbQuarter.hashCode ^
        sajda.hashCode ^
        surah.hashCode;
  }
}

class SajdaInfo {
  final Ayah ayah;
  final Surah surah;

  SajdaInfo({
    required this.surah,
    required this.ayah,
  });
}

class JuzzInfo {
  final int index;
  final Surah firstSurah;
  final List<Ayah> ayahList;

  JuzzInfo({
    required this.index,
    required this.firstSurah,
    required this.ayahList,
  });
}

class QuranData {
  static bool _isInitialized = false;
  static List<Surah> _surahs = [];
  static List<Ayah> _ayahs = [];

  QuranData._();

  static List<Surah> get surahs => _surahs;
  static List<Ayah> get ayahs => _ayahs;

  static Future<void> initialize() async {
    if (_isInitialized) return;
    await _load(File(AppContext.getPath('data.json')));
    _isInitialized = true;
  }

  static Future<void> _load(File file) async {
    Map<String, dynamic> raw = jsonDecode(await file.readAsString());
    final surahList = raw['surahs'] as Iterable;
    final ayahList = raw['ayahs'] as Iterable;
    _surahs = surahList.map((x) => _surahFromMap(x)).toList();
    _ayahs = ayahList.map((x) => _ayahFromMap(x)).toList();
  }

  static List<Ayah> getAyatInSurah(int surahId) {
    return _ayahs.where((x) => x.surah == surahId).toList();
  }

  static int getSurahAyatCount(int surahId) {
    return _ayahs.where((x) => x.surah == surahId).length;
  }

  static Surah getOneSurah(int index) =>
      surahs.firstWhere((x) => x.id == index);

  static Ayah getOneAyah(int index) => ayahs.firstWhere((x) => x.id == index);

  static List<Ayah> getSajdaAyat() => ayahs.where((x) => x.sajda).toList();

  static List<SajdaInfo> getSajdas() {
    return getSajdaAyat()
        .map(
          (sajdaAyah) => SajdaInfo(
            surah: getOneSurah(sajdaAyah.surah),
            ayah: sajdaAyah,
          ),
        )
        .toList();
  }

  static JuzzInfo getJuzzInfo(int juzIndex) {
    final ayahList = ayahs.where((x) => x.juz == juzIndex).toList();
    final firstSurah = getOneSurah(ayahList[0].surah);
    return JuzzInfo(
      index: juzIndex,
      firstSurah: firstSurah,
      ayahList: ayahList,
    );
  }
}

Surah _surahFromMap(List a) {
  return Surah(
    id: a[0],
    name: '$_AR_SURAH ${a[1]}',
    englishName: a[2],
    englishNameTranslation: a[3],
    revelationType: _toInt(a[4]) == 1 ? _MECCAN : _MEDINAN,
  );
}

Ayah _ayahFromMap(List a) {
  return Ayah(
    id: _toInt(a[0]),
    content: a[1],
    order: _toInt(a[2]),
    juz: _toInt(a[3]),
    manzil: _toInt(a[4]),
    page: (a[5]),
    ruku: _toInt(a[6]),
    hizbQuarter: _toInt(a[7]),
    sajda: _toInt(a[8]) == 1,
    surah: _toInt(a[9]),
  );
}

int _toInt(num n) => n.toInt();
