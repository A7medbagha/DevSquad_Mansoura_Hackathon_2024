import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class ReadExcel {
  Future<List<Map<String, dynamic>>> readExcelFile() async {
    List<Map<String, dynamic>> data = [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      if (fileBytes != null) {
        var excel = Excel.decodeBytes(fileBytes);

        for (var table in excel.tables.keys) {
          if (excel.tables[table] != null) {
            for (var row in excel.tables[table]!.rows.skip(1)) {
              Map<String, dynamic> rowData = {
                "Name": row[0]?.value,
                "Address": row[1]?.value,
                "Capacity": row[2]?.value,
                "Rating": row[3]?.value,
                "Government": row[4]?.value,
                "SuitableFor": row[5]?.value,
                "CostPerHour": row[6]?.value,
                "Accessibility": row[7]?.value,
                "Services": row[8]?.value,
                "AudienceType": row[9]?.value,
              };
              data.add(rowData);
            }
          }
        }
      }
    }

    return data;
  }
}
