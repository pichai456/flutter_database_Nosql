import 'package:flutter_database/model/transection_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransectionDb {
  //- -------- บริการเกี่ยวกับ ฐานข้อมูล -------- //
  String? dbname;

  TransectionDb({this.dbname});

  Future<Database> openDB() async {
    //- ------------ หาตำแหน่งที่เก็บ ------------- //
    var appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbname);

    //- ---------------- สร้าง DB ----------------- //
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // ------------------- บันทึกข้อมูล DB-------------------- //
  inseartData<int>(TransectionModel statement) async {
    //- ----------- ฐานข้อมูล => store ------------ //
    var db = await this.openDB();
    var store = intMapStoreFactory.store("expense");

    //- ------------------ json ------------------- //
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });
    db.close();
    return keyID;
  }

  //- --------------------- ดึงข้อมูล DB --------------------- //
  Future<List<TransectionModel>> loadAllData() async {
    //- ----------- ฐานข้อมูล => store ------------ //
    var db = await this.openDB();
    var store = intMapStoreFactory.store("expense");
    var snapshots = await store.find(db,
        finder: Finder(sortOrders: [
          SortOrder(Field.key, false)
        ])); //เรียงข้อมูลจากใหม่ => เก่า ใช้ finder SortOrder= false
    List<TransectionModel> transectionList = [];
    //- ----------------- ดึงข้อมูลทีละแถว ------------------ //
    for (var record in snapshots) {
      transectionList.add(TransectionModel(
        title: record['title'] as String,
        amount: record['amount'] as double,
        date: DateTime.parse("${record['date']}"),
      ));
    }
    return transectionList;
  }
}
