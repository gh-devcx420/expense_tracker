import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({
    required this.userExpenses,
    required this.index,
    super.key,
  });

  final Expense userExpenses;
  final int index;

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  bool isExpanded = false;

  void toggleCardDetails() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleCardDetails,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ${widget.index}. ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    widget.userExpenses.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  Icon(
                    categoryIcons[widget.userExpenses.expenseCategory],
                  ),
                ],
              ),
              if (isExpanded) ...[
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.userExpenses.getFormattedDate(
                            widget.userExpenses.expenseDate,
                          ),
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        const Spacer(),
                        Text(
                          '₹ ${widget.userExpenses.amount}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
