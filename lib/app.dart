import 'package:affiliate_platform/config/flavor_banner.dart';
import 'package:affiliate_platform/utils/l10n/l10n.dart';
import 'package:affiliate_platform/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: strict_raw_type
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MediaQuery.withClampedTextScaling(
            minScaleFactor: 0.85, // set min scale value here
            maxScaleFactor: .95,
            child: MaterialApp(
              title: 'Affiliate Platform',
              theme: ThemeData(
                // canvas color transparent for modal bottom sheet
                canvasColor: Colors.transparent,
          
                // visualDensity: VisualDensity.adaptivePlatformDensity,
          
                // scaffoldBackgroundColor: Colors.blue[700],
                // scaffoldBackgroundColor: AppColors.mainColor,
                // primarySwatch: Colors.blue,
              ),
              navigatorObservers: [routeObserver],
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              // home: const SplashPage(),
              // home: CheckOut(),
              home: LoginPage(),
            ),
          );
        },
      ),
    );
  }
}
