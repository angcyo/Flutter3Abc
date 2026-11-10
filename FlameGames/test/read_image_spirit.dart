import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2026/11/09
///
/// 从一张图片中读取指定区域的像素, 拼成一张新的图片
void main() {
  final inputPath =
      r"E:\projects\games\Tiny RPG Character Asset Pack 01 v2.0 -Free Soldier&Orc\Tiny RPG Character Asset Pack 01 v2.0 -Free Soldier&Orc\Characters(100x100 split)\Soldier\Soldier\Soldier.png";
      //r"E:\projects\games\Tiny RPG Character Asset Pack 01 v2.0 -Free Soldier&Orc\Tiny RPG Character Asset Pack 01 v2.0 -Free Soldier&Orc\Characters(100x100 split)\Orc\Orc\Orc.png";
  final inputBytes = File(inputPath).readAsBytesSync();
  final w = 100;
  //--attach2
  //final y = 332;
  //final y = 328;
  //--hurt
  //final y = 432;
  //final y = 530;
  //--death
  //final y = 532;
  //final y = 630;
  //--idle
  final y = 132;
  //final y = 130;
  //--walk
  final offsetX = (w - spiritSize) ~/ 2;
  final offsetY = 0;
  final outputBytes = cropAndMerge(inputBytes, [
    (w * 0 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 1 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 2 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 3 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 4 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 5 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 6 + offsetX, y + offsetY, spiritSize, spiritSize),
    (w * 7 + offsetX, y + offsetY, spiritSize, spiritSize),
  ]);
  File("build/output.png").writeAsBytesSync(outputBytes);
  print("...end");
}

final spiritSize = 36;

/// 从原图读取指定区域，拼接成新图片
Uint8List cropAndMerge(
  Uint8List sourceBytes,
  List<(int x, int y, int w, int h)> cropRect,
) {
  // 解码原图
  final source = img.decodeImage(sourceBytes);

  if (source == null) {
    throw Exception('图片解码失败');
  }

  // 创建新的图片
  final result = img.Image(
    width: spiritSize * cropRect.length,
    height: spiritSize,
    numChannels: 4,
  );

  for (final (index, rect) in cropRect.indexed) {
    final crop = img.copyCrop(
      source,
      x: rect.$1,
      y: rect.$2,
      width: rect.$3,
      height: rect.$4,
    );
    // 将区域绘制到结果图片
    img.compositeImage(result, crop, dstX: spiritSize * index, dstY: 0);
  }

  // 编码为 PNG
  return Uint8List.fromList(img.encodePng(result));
}
