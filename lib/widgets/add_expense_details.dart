import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:expense_tracker_app/widgets/text_field.dart';
import 'package:flutter/material.dart';

class AddExpenseDetails extends StatefulWidget {
  const AddExpenseDetails({required this.saveExpense, super.key});

  final Function(Expense) saveExpense;

  @override
  State<AddExpenseDetails> createState() => _AddExpenseDetailsState();
}

class _AddExpenseDetailsState extends State<AddExpenseDetails> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category? _selectedCategory;

  DateTime? _selectedDate;

  void _openDatePicker() async {
    DateTime now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(
        now.year - 1,
        now.month,
        now.day,
      ),
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  void _submitForm() {
    final expenseAmount = double.tryParse(_amountController.text);
    bool isAmountInvalid = expenseAmount == null || expenseAmount <= 0;

    if (_titleController.text.trim() == '' ||
        isAmountInvalid == true ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Please check your inputs',
            ),
            content: const Text(
              'Enter correct details for Expense Title, Amount, Date, Category and try again.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
      return;
    }

    widget.saveExpense(
      Expense(
        title: _titleController.text,
        amount: expenseAmount!,
        expenseCategory: _selectedCategory!,
        expenseDate: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final inputFieldFillColour = isDarkMode
        ? Theme.of(context).colorScheme.secondaryContainer
        : Theme.of(context).colorScheme.surface;
    final enableBorderColour = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              'Enter Expense Details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ExpenseTrackerTextField(
            label: 'Expense Title',
            controller: _titleController,
            borderColour: enableBorderColour,
            inputFieldFillColour: inputFieldFillColour,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: ExpenseTrackerTextField(
                  label: 'Amount',
                  controller: _amountController,
                  prefixText: '₹ ',
                  borderColour: enableBorderColour,
                  inputFieldFillColour: inputFieldFillColour,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 52,
                  child: InkWell(
                    onTap: _openDatePicker,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: inputFieldFillColour,
                        border: Border.all(
                          color: enableBorderColour,
                        ),
                        // this)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _selectedDate == null
                                  ? 'Select Date'
                                  : formatter.format(_selectedDate!),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const Spacer(),
                            Icon(
                              Icons.calendar_month_rounded,
                              color: isDarkMode
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: inputFieldFillColour,
                  border: Border.all(
                    color: enableBorderColour,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: inputFieldFillColour,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    underline: const SizedBox(),
                    value: _selectedCategory,
                    hint: Text(
                      'Select Category',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    }).toList(),
                    onChanged: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  'Save',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
