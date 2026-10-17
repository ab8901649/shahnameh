import 'package:flutter/material.dart';
import 'package:shahnameh/data_shahnameh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        scaffoldBackgroundColor: PersianColors.parchment,

        appBarTheme: AppBarTheme(
          backgroundColor: PersianColors.manuscriptBrown,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Vazir',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: PersianColors.manuscriptBrown,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontFamily: 'Vazir',
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontFamily: 'Vazir',
            color: PersianColors.inkBrown,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            height: 1.8,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Vazir',
            color: PersianColors.inkBrown,
            fontSize: 15,
            height: 1.8,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Vazir',
            fontSize: 13,
            color: PersianColors.fadedInk,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class PersianColors {
  static const Color manuscriptBrown = Color(0xFF5D3A1A); // قهوه‌ای شاه‌عباسی
  static const Color gold = Color(0xFFC9A227); // طلایی تذهیب
  static const Color terracotta = Color(0xFFB85C38); // نارنجی خاکی
  static const Color parchment = Color(0xFFF5EFE0); // کاغذ کهنه
  static const Color inkBrown = Color(0xFF2B1B0E); // جوهر (متن اصلی)
  static const Color fadedInk = Color(0xFF6B4C2A); // متن ثانویه
}

DataShahnameh TextShahnameh = DataShahnameh();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void Reaction(bool A) {
    setState(() {
      if (TextShahnameh.Finish() == true) {
        TextShahnameh.Reset();
      } else {
        if (A == true) {
          TextShahnameh.Next();
        } else {
          TextShahnameh.Back();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('شعر فارسی')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // پخش کردن محتوا و دکمه‌ها در کل ارتفاع صفحه
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ۱. بخش بالایی (شعر، معنی و مشخصات)
            Container(
              height:
                  MediaQuery.of(context).size.height * 0.6, // ۶۰٪ ارتفاع صفحه
              child: Column(
                children: [
                  Text(
                    TextShahnameh.getPoetryShahnameh(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    TextShahnameh.getMeaningShahnameh(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TextShahnameh.getPoetShahnameh(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        TextShahnameh.getBookShahnameh(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ۲. دکمه‌ها در پایین صفحه
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Reaction(true),
                  child: const Text('بعدی'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Reaction(false),
                  child: const Text('قبلی'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
