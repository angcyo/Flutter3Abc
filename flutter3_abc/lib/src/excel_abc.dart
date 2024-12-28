part of '../flutter3_abc.dart';

///
/// @author <a href="mailto:angcyo@126.com">angcyo</a>
/// @date 2024/06/28
///
class ExcelAbc extends StatefulWidget {
  const ExcelAbc({super.key});

  @override
  State<ExcelAbc> createState() => _ExcelAbcState();
}

class _ExcelAbcState extends State<ExcelAbc> with BaseAbcStateMixin {
  Map<String, List<List<dynamic>>>? excelData;

  @override
  void initState() {
    loadAssetBytes("test/test-xlsx.xlsx").get((value, error) {
      if (value is List<int>) {
        excelData = ExcelHelper.readExcel(data: value);
        updateState();
      }
    });
    super.initState();
  }

  @override
  WidgetList buildBodyList(BuildContext context) {
    return [
      [
        GradientButton.normal(() {
          loadAssetBytes("test/test-xlsx.xls").get((value, error) {
            if (error != null) {
              toastBlur(text: "$error");
            }
            if (value is List<int>) {
              excelData = ExcelHelper.readExcel(data: value);
              updateState();
            }
          });
        }, child: "readExcel(xls)".text()),
        GradientButton.normal(() {
          loadAssetBytes("test/test-xlsx.xlsx").get((value, error) {
            if (error != null) {
              toastBlur(text: "$error");
            }
            if (value is List<int>) {
              excelData = ExcelHelper.readExcel(data: value);
              updateState();
            }
          });
        }, child: "readExcel(xlsx)".text()),
        GradientButton.normal(() async {
          if (excelData != null) {
            final filePath = await cacheFilePath(uuidFileName(".xlsx"));
            await ExcelHelper.writeExcel(filePath, excelData!);
            l.d(filePath);
            filePath.shareFile().ignore();
          }
        }, child: "writeExcel".text()),
      ].flowLayout(childGap: kH, padding: const EdgeInsets.all(kH))!,
      (excelData?.toJsonString().toString() ?? "...").text(),
    ];
  }
}
