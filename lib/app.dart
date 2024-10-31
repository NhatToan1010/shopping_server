import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shopping_server/binding/general_bindings.dart';
import 'package:shopping_server/routes/app_routes.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/theme/theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: LocalTheme.lightTheme,
      darkTheme: LocalTheme.darkTheme,
      getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: AppPallete.secondary,
        body: Center(
          child: CircularProgressIndicator(
            color: AppPallete.softGrey,
          ),
        ),
      ),
    );
  }
}
