import 'package:banking_app/modules/home.dart';
import 'package:banking_app/shared/cubit/cubit.dart';
import 'package:banking_app/shared/style/style.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/states.dart';

class Transfers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
        return true;
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              },
            ),
            title: const Text('Transfers'),
          ),
          body: BuildCondition(
            condition: AppCubit.get(context).transfers.isNotEmpty,
            builder: (context) => Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) =>
                          transferItem(AppCubit.get(context).transfers[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: AppCubit.get(context).transfers.length),
                ),
              ],
            ),
            fallback: (context) => const Center(
              child: Text('No Transfers'),
            ),
          ),
        ),
      ),
    );
  }
}
