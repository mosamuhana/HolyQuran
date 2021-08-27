import 'quran-data.dart';
import 'utils.dart';

Future<void> runApp(List<String> arguments) async {
  await compressZipFile(resourcesDir, resourcesZipFile);
  /*
  final loader = DataLoader();
  final data = await loader.load();
  if (data == null) {
    print('Data cannot be downloaded');
  } else {
    print("surahs: ${data['surahs'].length}");
    print("ayahs: ${data['ayahs'].length}");
  }
  */
}
