import 'package:banking_app/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  late Database dataBase;
  void createDataBase() {
    openDatabase('notes.db', version: 1, onCreate: (dataBase, version) {
      print('database created');
      dataBase
          .execute(
        'CREATE TABLE customers (id INTEGER PRIMARY KEY ,name TEXT,email TEXT ,balance DOUBLE) ',
      )
          .then((value) {
        print("table customers created");
        dataBase.rawInsert(
            'INSERT INTO customers (name,email,balance) VALUES("Mohamed Fayez","mohfayez@gmail.com",200000),("Abdo Fayez","Abdo@gmail.com",40000),("Ahmed Fayez","Ahmed@gmail.com",50000),("Omar Ahmed","Omar@gmail.com",60000),("Ramy khaled","Ramy@gmail.com",70000),("Mohamed Salah","Mohamed@gmail.com",80000),("Ahmed Mahmoud","Mahmoud@gmail.com",90000),("Mohamed Mahmoud","Mohamedm@gmail.com",100000),("Yousef Tarek","Yousef@gmail.com",110000),("Tarek Mohamed","Tarek@gmail.com",120000)');
      }).catchError((error) {
        print(error);
      });

      dataBase
          .execute(
        ' CREATE TABLE transfers (id INTEGER PRIMARY KEY ,sName TEXT,rName TEXT, amount Double )',
      )
          .then((value) {
        print("table transfers created");
      }).catchError((error) {
        print(error);
      });
    }, onOpen: (dataBase) {
      print("dataBase opened");
      getDataFromDataBase(dataBase);
    }).then((value) {
      dataBase = value;
      emit(CreateDataBaseSuccessState());
    });
  }

  List<Map> customers = [];
  List<Map> transfers = [];
  void getDataFromDataBase(dataBase) {
    dataBase.rawQuery('SELECT * FROM customers').then((value) {
      customers = [];
      value.forEach((element) {
        customers.add(element);
      });
    });
    dataBase.rawQuery('SELECT * FROM transfers').then((value) {
      transfers = [];
      value.forEach((element) {
        transfers.add(element);
      });
    });
    emit(GetDataFromDataBaseState());
  }

  int? n;
  void getIndex(int i) {
    n = i;
  }

  bool isTransfer = false;
  double? newBalance;
  double? nAmount;
  int? sId;
  void transfer(double amount) {
    nAmount = amount;
    newBalance = customers[n!]['balance'] - amount;
    sId = customers[n!]['id'];
  }

  double? newB;
  int? rId;
  void add(i) {
    emit(AppUpdateDataLoadingState());
    newB = customers[i]['balance'] + nAmount;
    rId = customers[i]['id'];
    insertIntoTransfers(i);
    updateSData();
    updateRData();
    isTransfer = false;
  }

  void updateSData() {
    dataBase.rawUpdate(
      'UPDATE customers SET balance=? WHERE id=$sId',
      [newBalance],
    ).then((value) {
      getDataFromDataBase(dataBase);
      emit(AppUpdateDataState());
    });
  }

  void updateRData() {
    dataBase.rawUpdate(
      'UPDATE customers SET balance=? WHERE id=$rId',
      [newB],
    ).then((value) {
      getDataFromDataBase(dataBase);
      emit(AppUpdateRDataState());
    });
  }

  void insertIntoTransfers(int i) {
    dataBase.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO transfers (sName,rName,amount) VALUES("${customers[n!]['name']}","${customers[i]['name']}","$nAmount")')
          .then((value) {
        print("inserted successfully");
        emit(InsertToTransfersSuccessState());
      }).catchError((error) {
        print(error);
        emit(InsertToTransfersErrorState());
      });
    });
  }
}
