import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;

Future<void> downloadFile(String fileUrl, File file) async {
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(fileUrl));
  final response = await request.close();
  //response.toString();
  await response.pipe(file.openWrite());
  //client.close();
}

Future<void> extractZipFile(File file, String targetDir) async {
  final bytes = file.readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);
  for (final archiveFile in archive) {
    final fullPath = p.join(targetDir, archiveFile.name);
    if (archiveFile.isFile) {
      final data = archiveFile.content as List<int>;
      final f = File(fullPath);
      if (!await f.exists()) {
        await f.create(recursive: true);
        await f.writeAsBytes(data);
      }
    } else {
      final dir = Directory(fullPath);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
    }
  }
}
