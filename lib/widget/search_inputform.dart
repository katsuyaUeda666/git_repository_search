import 'package:flutter/material.dart';

class SearchInputForm extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String hintText;

  const SearchInputForm({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = 'Search...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(30.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
      ),
    );
  }
}
