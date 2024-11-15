import 'package:expense_tracker_app/expense_tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ExpenseTrackerManager(),
  );
}

class ExpenseTrackerManager extends StatefulWidget {
  const ExpenseTrackerManager({super.key});

  @override
  State<ExpenseTrackerManager> createState() => _ExpenseTrackerManagerState();
}

class _ExpenseTrackerManagerState extends State<ExpenseTrackerManager> {
  Color kSeedColour = const Color(0xff00ffbb);
  late ThemeData lightTheme;
  late ThemeData darkTheme;

  @override
  void initState() {
    super.initState();
    initializeThemes();
  }

  void initializeThemes() {
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: kSeedColour,
      brightness: Brightness.light,
    ).copyWith(
      primaryContainer: kSeedColour,
    );

    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: kSeedColour,
      brightness: Brightness.dark,
    ).copyWith(
      primaryContainer: kSeedColour,
    );

    lightTheme = ThemeData(useMaterial3: true).copyWith(
      brightness: Brightness.light,
      primaryColor: kSeedColour,
      colorScheme: lightColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: lightColorScheme.secondaryContainer,
          size: 25,
        ),
        titleTextStyle: TextStyle(
          color: lightColorScheme.secondaryContainer,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightColorScheme.primary,
          foregroundColor: Colors.white),
      iconTheme: IconThemeData(
        color: lightColorScheme.primary,
        size: 20,
      ),
      cardTheme: CardTheme(
        color: lightColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightColorScheme.primary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: lightColorScheme.primary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: lightColorScheme.primary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: lightColorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: lightColorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      scaffoldBackgroundColor: lightColorScheme.surfaceContainer,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: lightColorScheme.secondaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: lightColorScheme.secondaryContainer,
        titleTextStyle: TextStyle(
          color: lightColorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: lightColorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      // dropdownMenuTheme: DropdownMenuThemeData(
      //   menuStyle: MenuStyle(
      //     backgroundColor:
      //         MaterialStateProperty.all(lightColorScheme.secondaryContainer),
      //     elevation: MaterialStateProperty.all(8.0), // Dropdown elevation
      //     padding:
      //         MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10)),
      //     shape: MaterialStateProperty.all(
      //       RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //     ),
      //   ),
      // ),
    );

    darkTheme = ThemeData(useMaterial3: true).copyWith(
      brightness: Brightness.dark,
      primaryColor: kSeedColour,
      colorScheme: darkColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.secondaryContainer,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: darkColorScheme.secondary,
          size: 25,
        ),
        titleTextStyle: TextStyle(
          color: darkColorScheme.secondary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.surfaceContainer,
      ),
      iconTheme: IconThemeData(
        color: darkColorScheme.secondary,
        size: 22,
      ),
      cardTheme: CardTheme(
        color: darkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkColorScheme.secondary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: darkColorScheme.secondary,
          backgroundColor: darkColorScheme.secondaryContainer,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: darkColorScheme.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: darkColorScheme.secondary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: TextStyle(
          color: darkColorScheme.secondary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      scaffoldBackgroundColor: darkColorScheme.surfaceContainer,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkColorScheme.surfaceContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: darkColorScheme.secondaryContainer,
        titleTextStyle: TextStyle(
          color: darkColorScheme.secondary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: darkColorScheme.secondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  void changeThemeColour(Color seed) {
    setState(() {
      kSeedColour = seed;
      initializeThemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: ExpenseTrackerHome(
        changeSeed: changeThemeColour,
      ),
    );
  }
}
