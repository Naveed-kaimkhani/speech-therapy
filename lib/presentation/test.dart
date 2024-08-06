// // }

// import 'package:e_mandi/localization/bloc/localization_bloc.dart';
// import 'package:e_mandi/localization/bloc/localization_event.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:e_mandi/presentation/widgets/auth_button.dart';
// import 'package:e_mandi/style/images.dart';
// import 'package:e_mandi/style/styling.dart';
// import 'package:e_mandi/utils/routes/routes_name.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Localization support

// // import 'package:flutter_svg/svg.dart';
// // import 'package:flutter_localization/flutter_localization.dart';

// import '../../localization/bloc/localization_state.dart';

// class Onboarding extends StatelessWidget {
//   const Onboarding({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Map<Locale, String> localeNames = {
//       const Locale('en'): 'English 🇺🇸',
//       const Locale('ur'): 'Urdu 🇵🇰',
//     };

//     return BlocBuilder<LocalizationBloc, LocalizationState>(
//       builder: (context, state) {
//         final Locale currentLocale = state.locale;

//         // Determine which image to display based on the selected locale
//         final String logoImage = currentLocale == const Locale('en')
//             ? Images.logo_en
//             : Images.logo_png;

//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: Styling.backgroundColor,
//             appBar: AppBar(
//               centerTitle: true,
//               backgroundColor: Styling.primaryColor,
//               title: Text(
//                 AppLocalizations.of(context)!.title,
//                 style: const TextStyle(color: Colors.white),
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<Locale>(
//                       icon: Icon(
//                         Icons.language,
//                         color: Colors.white,
//                         size: 30.w,
//                       ), // Change the dropdown icon to a globe icon
//                       dropdownColor: Styling.backgroundColor,
//                       onChanged: (Locale? locale) {
//                         if (locale != null) {
//                           context
//                               .read<LocalizationBloc>()
//                               .add(SetLocale(locale));
//                         }
//                       },
//                       items: AppLocalizations.supportedLocales.map((locale) {
//                         return DropdownMenuItem(
//                           value: locale,
//                           child:
//                               Text(localeNames[locale] ?? locale.languageCode),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Image.asset(
//                     logoImage,
//                     height: 280.h,
//                     width: 280.w,
//                   ),
//                   SizedBox(
//                     height: 100.h,
//                   ),
//                   AuthButton(
//                     height: 46.h,
//                     widht: 250.w,
//                     fontsize: 20.sp,
//                     text: AppLocalizations.of(context)!.getStarted,
//                     func: () {
//                       Navigator.pushNamed(context, RoutesName.categoryScreen);
//                     },
//                     color: Styling.primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }