import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/model/transection_model.dart';
import 'package:flutter_database/provider/transections_pv.dart';
import 'package:flutter_database/screen/form.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            Home(),
            FormScreen(),
          ],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "รายการ",
            ),
            Tab(
              icon: Icon(Icons.add_box),
              text: "บันทึกรายการ",
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แอปบัญชี'),
        actions: [
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Consumer(
        builder: (context, TransactionProvider provider, Widget? child) {
          var _count = provider.transection.length;
          if (_count <= 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ไม่พบข้อมูล",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
              itemCount: _count,
              itemBuilder: (context, int index) {
                TransectionModel _data = provider.transection[index];
                return Card(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Text("${_data.amount}"),
                        ),
                      ),
                      title: Text("${_data.title}"),
                      subtitle: Text(DateFormat("dd/MM/yyyy").format(_data.date)),
                    ));
              });
        },
      ),
    );
  }
}
