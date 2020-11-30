import 'package:comida/states/bloc/page_bloc.dart';
import 'package:comida/states/provider/provider.dart';
import 'package:comida/shared/shared.dart';
import 'package:comida/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

/// Calling run app method when app launched.
/// Set force app orientation into potrait up.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => {
    runApp(MyApp()),
  });
}

/// Declaring root class of this project.
/// Register blocs and and provider so that it can handle state globally.
/// Set theme and manifest of this app using material design.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageBloc()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ValidationProvider()),
        ],
        child: GetMaterialApp(
          title: "Comida - Fast Food Market",
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}