import 'dart:async';

import 'package:expense_tracker_app/widgets/add_expense_details.dart';
import 'package:expense_tracker_app/widgets/expense_card.dart';
import 'package:expense_tracker_app/widgets/expense_chart.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'models/expense_model.dart';

List<Expense> userExpenses = [
  Expense(
    title: 'Movies',
    amount: 500,
    expenseCategory: Category.leisure,
    expenseDate: DateTime.now(),
  ),
  Expense(
    title: 'McDonald\'s',
    amount: 800,
    expenseCategory: Category.food,
    expenseDate: DateTime.now(),
  ),
  Expense(
    title: 'Office Supplies',
    amount: 300,
    expenseCategory: Category.work,
    expenseDate: DateTime.now(),
  ),
  Expense(
    title: 'Trip to Office',
    amount: 700,
    expenseCategory: Category.travel,
    expenseDate: DateTime.now(),
  ),
];

List<Color> appColours = [
  const Color(0xff9400D3),
  const Color(0xff4B0082),
  const Color(0xff0000FF),
  const Color(0xff00FF00),
  const Color(0xffFFFF00),
  const Color(0xffFF7F00),
  const Color(0xffFF0000),
];

class ExpenseTrackerHome extends StatefulWidget {
  const ExpenseTrackerHome({required this.changeSeed, super.key});

  final void Function(Color) changeSeed;

  @override
  State<ExpenseTrackerHome> createState() => _ExpenseTrackerHomeState();
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  final ScrollController _expenseListScrollController = ScrollController();
  bool isFabVisible = true;
  bool isExpanded = true;
  Timer? _scrollTimer;

  void _openExpenseModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddExpenseDetails(
          saveExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(
      () {
        userExpenses.add(expense);
      },
    );
  }

  void _deleteExpense(Expense expense) {
    ScaffoldMessenger.of(context).clearSnackBars();
    int expenseIndex = userExpenses.indexOf(expense);

    setState(() {
      userExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Item Deleted'),
        duration: const Duration(
          seconds: 2,
        ),
        action: SnackBarAction(
          label: 'Undo Delete',
          onPressed: () {
            setState(() {
              userExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _featureComingSoon() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feature Coming Soon :)'),
        duration: Duration(
          seconds: 1,
        ),
      ),
    );
  }

  void _hideFabOnScroll() {
    if (_expenseListScrollController.position.isScrollingNotifier.value) {
      if (isFabVisible) {
        setState(() {
          isFabVisible = false;
        });
      }

      if (_scrollTimer != null) {
        _scrollTimer!.cancel();
      }

      _scrollTimer = Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          isFabVisible = true;
        });
      });
    }
  }

  void _openThemeSettings() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              child: Padding(
                padding: kCustomDialoguePadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose App Theme',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...appColours.map((colour) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              widget.changeSeed(colour);
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.circle_rounded,
                              size: 24,
                              color: colour.withOpacity(0.8),
                            ),
                          );
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _expandExpenseSettings() {}

  @override
  void initState() {
    super.initState();
    _expenseListScrollController.addListener(_hideFabOnScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _expenseListScrollController.removeListener(_hideFabOnScroll);
    _expenseListScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openThemeSettings,
            icon: const Icon(
              Icons.color_lens,
            ),
          ),
        ],
      ),
      floatingActionButton: isFabVisible
          ? FloatingActionButton(
              onPressed: _openExpenseModalSheet,
              child: const Icon(
                Icons.add_rounded,
                size: 26,
              ),
            )
          : null,
      body: userExpenses.isEmpty
          ? Center(
              child: Text(
                'Add Expenses',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: kSectionHeadingPadding,
                    child: Row(
                      children: [
                        Text(
                          'Chart Data',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: _featureComingSoon,
                          child: const Icon(
                            Icons.bar_chart_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ExpenseChart(
                    chartBackgroundColour: isDark
                        ? Theme.of(context).cardTheme.color ??
                            Colors.transparent
                        : Theme.of(context).cardTheme.color ??
                            Colors.transparent,
                    expenses: userExpenses,
                  ),
                  Padding(
                    padding: kSectionHeadingPadding,
                    child: Row(
                      children: [
                        Text(
                          'Your Expenses',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: _expandExpenseSettings,
                          child: const Icon(
                            Icons.settings,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _expenseListScrollController,
                      itemCount: userExpenses.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(userExpenses[index].id),
                          background: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.red.withOpacity(0.5)
                                    : Colors.red.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Deleting Item',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            _deleteExpense(
                              userExpenses[index],
                            );
                          },
                          child: ExpenseCard(
                            userExpenses: userExpenses[index],
                            index: index + 1,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
