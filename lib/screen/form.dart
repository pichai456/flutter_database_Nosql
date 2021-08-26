import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/model/transection_model.dart';
import 'package:flutter_database/provider/transections_pv.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  // const FormScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบฟอร์มบันทึกข้อมูล'),
        actions: [
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              formName(),
              formMony(),
              formSubmit(context),
            ],
          ),
        ),
      ),
    );
  }

  Container formName() {
    return Container(
      child: TextFormField(
        controller: _title,
        validator: RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
        decoration: InputDecoration(labelText: 'ชื่อรายการ'),
      ),
    );
  }

  Container formMony() {
    return Container(
      child: TextFormField(
        controller: _amount,
        validator: (String? str) {
          RequiredValidator(errorText: 'กรุณากรอกข้อมูล');
          if (double.parse(str!) <= 0) {
            return "กรุณาใส่จำนวนเงินมากกว่า 0";
          }
        },
        decoration: InputDecoration(labelText: 'จำนวนเงิน'),
      ),
    );
  }

  SizedBox formSubmit(context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        child: ElevatedButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              var title = _title.text;
              var amount = _amount.text;
              //- -------------- เตรียมข้อมูล --------------- //
              TransectionModel _statements = TransectionModel(
                title: title,
                amount: double.parse(amount),
                date: DateTime.now(),
              );
              //- -------------- เรียก Povider -------------- //
              final provider = Provider.of<TransactionProvider>(context, listen: false);
              provider.addTransection(_statements);
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          icon: Icon(Icons.add_box_sharp),
          label: Text('บันทึกข้อมูล'),
        ),
      ),
    );
  }
}
