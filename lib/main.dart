import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:scan_gpt/app/env/env.dart';
import 'package:scan_gpt/app/l10n/l10n.dart';
import 'package:scan_gpt/app/theme/light/light_theme.dart';
import 'package:scan_gpt/core/extensions/context_extensions.dart';
import 'package:scan_gpt/core/utils/observer/bloc_observer.dart';
import 'package:scan_gpt/feature/splash/presentation/view/splash_view.dart';
import 'package:scan_gpt/injection.dart';
import 'package:wiredash/wiredash.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  Bloc.observer = AppBlocObserver();

  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: Env.fileName);

  runApp(const ScanGPT());
}

class ScanGPT extends StatelessWidget {
  const ScanGPT({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xff000000),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Wiredash(
      projectId: 'scangpt-cyfhe5l',
      secret: 'Co-mbweIQ0v9S-gPcU4jVN-JQ0JQQ95A',
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          // Disables font scaling and bold text
          data:
              context.mediaQuery.copyWith(textScaleFactor: 1, boldText: false),
          // Dismisses the keyboard globally
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: child,
          ),
        ),
        debugShowCheckedModeBanner: false,
        // Theme
        theme: getIt<LightTheme>().theme,
        // Localization
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SplashView(),
      ),
    );
  }
}
