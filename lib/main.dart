import 'package:finalyear/presentation/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:finalyear/presentation/screens/admin_main/adminHomepage/adminHomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? authToken = prefs.getString('token');
  runApp(MyApp(authToken: authToken)); // Pass authToken to MyApp
}

class MyApp extends StatelessWidget {
  final String? authToken; // Declare authToken as a field

  const MyApp({super.key, this.authToken}); // Update constructor
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        enabledDebugging: true,
        publicKey: "test_public_key_9b85f567ac5c4a9e8c05e301397154fe",
        builder: (context, navigatorKey) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              title: 'Safa Sahar',
              theme: ThemeData(
                scaffoldBackgroundColor: const Color.fromRGBO(216, 243, 220, 2),
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              // home: const HomePage(),
              // home: const Splash(),
              home: authToken != null
                  ? const AdminHomePage() // change garna parxa
                  : const Splash(),
            ),
          );
        });
  }
}


// import 'package:flutter/material.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';
// import 'khalti.dart';

// void main() => runApp(const KhaltiPaymentApp());

// class KhaltiPaymentApp extends StatelessWidget {
//   const KhaltiPaymentApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return KhaltiScope(
//         publicKey:
//             "test_public_key_152624d767564052baa9e9f87f68271d", // from khalti merchant acc.
//         builder: (context, navigatorKey) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             navigatorKey: navigatorKey,
//             supportedLocales: const [
//               Locale('en', 'US'),
//               Locale('ne', 'NP'),
//             ],
//             localizationsDelegates: const [
//               KhaltiLocalizations.delegate,
//             ],
//             theme: ThemeData(
//                 primaryColor: const Color(0xFF56328c),
//                 appBarTheme: const AppBarTheme(
//                   color: Color(0xFF56328c),
//                 )),
//             title: 'Khalti Payment',
//             home: const KhaltiPaymentPage(),
//           );
//         });
//   }
// }