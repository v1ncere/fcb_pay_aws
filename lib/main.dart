import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_repository/hive_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'configure_amplify.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  await Hive.initFlutter();
  Hive.registerAdapter(QRModelAdapter());
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory((await getTemporaryDirectory()).path));
  Bloc.observer = const AppBlocObserver();
  runApp(const App());
  configLoading();
}