abstract class AppStates {}

class InitialState extends AppStates {}

class CreateDataBaseSuccessState extends AppStates {}

class GetDataFromDataBaseState extends AppStates {}

class AppUpdateDataState extends AppStates {}

class AppUpdateRDataState extends AppStates {}

class AppUpdateDataLoadingState extends AppStates {}

class InsertToTransfersSuccessState extends AppStates {}

class InsertToTransfersErrorState extends AppStates {}
