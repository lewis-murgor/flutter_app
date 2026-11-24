import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final store = GetStorage();
  var username = ''.obs;
  void saveUsername(String username) {
    this.username.value = username;
    store.write('username', username);
  }
  String readUsername() {
    return store.read('username')?? '';
  }
}