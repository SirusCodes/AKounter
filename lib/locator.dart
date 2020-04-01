import 'package:akounter/data.dart';
import 'package:get_it/get_it.dart';
import './provider/add_entry_provider.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerFactory(() => Data());
  locator.registerLazySingleton(() => AddEntryProvider());
}
