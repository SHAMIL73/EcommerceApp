import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DarkModeGetx extends GetxController {

  final RxBool _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  void toggleTheme() {
    _isDarkMode.toggle();
  }
}