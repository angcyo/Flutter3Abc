import 'dart:developer';
import 'dart:ui';

import 'package:flutter3_app/flutter3_app.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2025/07/04
///
@testPoint
void testAbc() {
  //p dst[4] = {{20.0f, 20.0f}, {160.0f, 20.0f}, {160.0f, 160.0f}, {20.0f, 160.0f}};
  //p src[4] = {{13.0f, 13.0f}, {166.5f, 18.5f}, {163.0f, 163.5f}, {10.5f, 160.5f}};

  //H[0]:0.892207;H[1]:0.014188;H[2]:8.176287;
  //H[3]:-0.035836;H[4]:0.939148;H[5]:8.216367;
  //H[6]:-0.000108;H[7]:-0.000049;H[8]:1.00000
  //--
  //输出可视化时:
  //[0] [0.8922067941243021,0.01418820853094108,8.176286297216732]
  //[1] [-0.03583605628807174,0.9391478601047357,8.216367882118266]
  //[2] [0.0,0.0,1.0]
  //写入数组[行:列]索引0开始.:
  //[ [0:0], [1:0], [2:0], [0:1], [1:1], [2:1], [0:2], [1:2], [2:2], ]

  final from = [
    Offset(13, 13),
    Offset(166.5, 18.5),
    Offset(163, 163.5),
    Offset(10.5, 160.5),
  ];
  final to = [
    Offset(20, 20),
    Offset(160, 20),
    Offset(160, 160),
    Offset(20, 160),
  ];
  final matrix4 = createPerspectiveMatrix(from, to);
  final matrix3 = matrix4.toMatrix3();
  final str = matrix3.toString();

  //内存中的数组数据排列
  //[ 0.8922067941243021, -0.03583605628807174, 0.0, 0.01418820853094108, 0.9391478601047357, 0.0, 8.176286297216732, 8.216367882118266, 1.0 ]
  //输出可视化:
  //[ arr[0], arr[3], arr[6] ]
  //[ arr[1], arr[4], arr[7] ]
  //[ arr[2], arr[5], arr[8] ]
  final values = matrix3.storage;
  //debugger();
}
