import 'package:banking_app/modules/home.dart';
import 'package:banking_app/shared/cubit/cubit.dart';
import 'package:banking_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                titleTextStyle: const TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
                centerTitle: true,
                backgroundColor: HexColor("#202530"),
                iconTheme: const IconThemeData(color: Colors.orange)),
            scaffoldBackgroundColor: HexColor("#171c26"),
          ),
          home: const Home(),
        ),
      ),
    );
  }
}
