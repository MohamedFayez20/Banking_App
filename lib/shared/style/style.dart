import 'package:banking_app/modules/customers.dart';
import 'package:banking_app/modules/user_data.dart';
import 'package:banking_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget customer(Map model, context, index) => InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (AppCubit.get(context).isTransfer) {
          if (AppCubit.get(context).customers[AppCubit.get(context).n!]['id'] !=
              model['id']) {
            AppCubit.get(context).add(index);
          }
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserData()));
          AppCubit.get(context).getIndex(index);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 7,
                color: Colors.black12,
                offset: Offset(0, 7),
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: AppCubit.get(context).isTransfer
                ? AppCubit.get(context).customers[AppCubit.get(context).n!]
                            ['id'] !=
                        model['id']
                    ? HexColor("#202530")
                    : HexColor("#171c26")
                : HexColor("#202530")),
        child: Row(
          children: [
            Text(
              model['name'],
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5),
            ),
            const Spacer(),
            Text(
              model['balance'].toString(),
              style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5),
            ),
          ],
        ),
      ),
    );

Widget field(IconData i, controller) => TextFormField(
      controller: controller,
      readOnly: true,
      enabled: false,
      style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: Icon(
          i,
          color: Colors.orange,
        ),
        filled: true,
        fillColor: HexColor("#202530"),
      ),
    );
Widget button(String t) => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HexColor("#0E121B"),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            spreadRadius: 7,
            offset: Offset(0, 7),
          )
        ],
      ),
      child: Text(
        t,
        style: const TextStyle(
            fontSize: 22,
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5),
      ),
    );
var amountController = TextEditingController();
showAlertDialog(BuildContext context, cubit) {
  var formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Amount to transfer',
          style: TextStyle(color: Colors.greenAccent),
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: amountController,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty || double.parse(value) > cubit) {
                return 'Please type valid amount to transfer';
              }
            },
            decoration: const InputDecoration(
              hintText: 'Type amount...',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.orange),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              'Transfer to',
              style: TextStyle(color: Colors.orange),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                AppCubit.get(context).isTransfer = true;
                AppCubit.get(context)
                    .transfer(double.parse(amountController.text));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Customers()));
                amountController.clear();
              }
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
        backgroundColor: HexColor("#202530"),
      );
    },
  );
}

Widget transferItem(model) => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: HexColor("#202530"),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            spreadRadius: 7,
            offset: Offset(0, 7),
          )
        ],
      ),
      child: Column(
        children: [
          teTransfer('From : ', model['sName']),
          teTransfer('To : ', model['rName']),
          teTransfer('Amount : ', model['amount'].toString()),
        ],
      ),
    );

Widget teTransfer(String t1, String t2) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          t1,
          style: const TextStyle(
              color: Colors.orange,
              fontSize: 18,
              height: 2,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          t2,
          style: const TextStyle(
              color: Colors.greenAccent, fontSize: 18, height: 2),
        ),
      ],
    );
