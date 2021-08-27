enum RevelationType { Meccan, Medinan }

class Surah {
  final int id; // number
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final bool isMeccan;

  Surah({
    required this.id,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.isMeccan,
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
        other.isMeccan == isMeccan;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        englishName.hashCode ^
        englishNameTranslation.hashCode ^
        isMeccan.hashCode;
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
