import 'package:uuid/uuid.dart';

class Global {
  late String appUqniqueID;

  void init(){
    appUqniqueID = '${Uuid().v8()}-${Uuid().v4()}';
  }

  String getAppID(){
    return appUqniqueID;
  }

}
