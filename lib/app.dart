import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          title: 'SWAP IT',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
