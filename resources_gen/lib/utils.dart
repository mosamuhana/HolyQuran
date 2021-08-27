import 'dart:io';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;

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

Future<void> compressZipFile(Directory sourceDir, File targetFile) async {
  //await Future.delayed(Duration(milliseconds: 100));
  await sourceDir.list(recursive: true).forEach((FileSystemEntity e) async {
    if (await FileSystemEntity.isFile(e.path)) {
      //...
    } else if (await FileSystemEntity.isDirectory(e.path)) {
      //....
    }
    print(e.path);
  });
}

Directory get resourcesDir => Directory(p.join(p.current, 'resources'));
File get resourcesZipFile => File(p.join(p.current, 'resources2.zip'));
