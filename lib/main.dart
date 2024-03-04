import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifier_provider/features/contact_notifierprovider/theme/themechanger.dart';
import 'package:notifier_provider/features/contact_notifierprovider/view/pages/contact_homepage.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider) ? ThemeData.dark() : ThemeData(),
      home: ContactMainpage(),
    );
  }
}
