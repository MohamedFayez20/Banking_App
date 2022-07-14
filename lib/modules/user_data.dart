import 'package:banking_app/modules/customers.dart';
import 'package:banking_app/shared/cubit/cubit.dart';
import 'package:banking_app/shared/cubit/states.dart';
import 'package:banking_app/shared/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var nameController =
        TextEditingController(text: cubit.customers[cubit.n!]['name']);
    var emailController =
        TextEditingController(text: cubit.customers[cubit.n!]['email']);
    var balanceController = TextEditingController(
        text: cubit.customers[cubit.n!]['balance'].toString());
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Customers()),
                  (route) => false);
            },
          ),
          title: const Text(
            'Customer Information',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              field(Icons.person_outline, nameController),
              const SizedBox(
                height: 20,
              ),
              field(Icons.email_outlined, emailController),
              const SizedBox(
                height: 20,
              ),
              field(Icons.monetization_on_outlined, balanceController),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: () {
                    showAlertDialog(
                        context, cubit.customers[cubit.n!]['balance']);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: button('Transfer')),
            ],
          ),
        ),
      ),
    );
  }
}
