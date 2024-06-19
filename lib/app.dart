import 'package:affiliate_platform/config/flavor_banner.dart';
import 'package:affiliate_platform/controllers/sidemenu_controller.dart';
import 'package:affiliate_platform/logic/auth/auth_bloc.dart';
import 'package:affiliate_platform/logic/employee/checkin/checkin_bloc.dart';
import 'package:affiliate_platform/logic/employee/checkout/checkout_bloc.dart';
import 'package:affiliate_platform/logic/employee/leave/leave_bloc.dart';
import 'package:affiliate_platform/logic/employee/project/project_bloc.dart';
import 'package:affiliate_platform/logic/manage_contact/manage_contact_bloc.dart';
import 'package:affiliate_platform/logic/profile/profile_bloc.dart';
import 'package:affiliate_platform/logic/settings/settings_bloc.dart';
import 'package:affiliate_platform/splash.dart';
import 'package:affiliate_platform/utils/l10n/l10n.dart';
import 'package:affiliate_platform/view/employee/checkin/checkin_page.dart';
import 'package:affiliate_platform/view/employee/leave/leave_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final blocOficialLoaderNotifier = ValueNotifier<bool>(false);

// ignore: strict_raw_type
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: ScreenUtilInit(
        // designSize: ScreenUtil.defaultSize,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => SideMenuController()),
              Provider(
                create: (context) => AuthBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => ManageContactBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => ProjectBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => CheckInBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => CheckOutBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => ProfileBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => LeaveBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
              Provider(
                create: (context) => SettingsBloc(),
                dispose: (context, bloc) => bloc.dispose(),
              ),
            ],
            child: MediaQuery.withClampedTextScaling(
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
                home: const SplashPage(),
                // home: const CheckInPage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
