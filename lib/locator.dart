import 'package:akounter/data.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerFactory(() => Data());
}
