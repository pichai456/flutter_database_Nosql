import 'package:flutter/foundation.dart';
import 'package:flutter_database/database/transection_db.dart';
import 'package:flutter_database/model/transection_model.dart';

class TransactionProvider with ChangeNotifier {
  //- ------------- ตัวอย่างข้อมูล -------------- //
  List<TransectionModel> transection = [];

  //- ---------------- ดึงข้อมูล ---------------- //
  List<TransectionModel> getTransections() {
    return transection;
  }

//- ------------ ดึงข้อมูลมาแสดงตอนเริ่ม App ------------ //
  void initData() async {
    // ignore: await_only_futures
    var db = await TransectionDb(dbname: "transection.db");
    transection = await db.loadAllData();
    notifyListeners();
  }

  void addTransection(TransectionModel statement) async {
    // ignore: await_only_futures
    var db = await TransectionDb(dbname: "transection.db");
    //- -------------- บันทึกข้อมูล --------------- //
    await db.inseartData(statement);

    //- ---------------- ดึงข้อมูลมาแสดง ---------------- //
    transection = await db.loadAllData();

    //- ----------- แจ้งเตือน Consumer ------------ //
    notifyListeners();
  }
}
