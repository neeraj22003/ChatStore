import 'package:chat_shop/src/core/injectors/cubit_bloc_di.dart';
import 'package:chat_shop/src/core/injectors/data_source_di.dart';
import 'package:chat_shop/src/core/injectors/repo_di.dart';
import 'package:chat_shop/src/core/injectors/syncer_di.dart';
import 'package:chat_shop/src/core/injectors/use_cases_di.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;
Future<void> initDependensies() async {
  await dataSourceDi();
  await repoDi();
  await useCasesdi();
  await cubitBlocDi();
  await syncerDi();
}
