import 'package:flutter/material.dart';

import '../../data/model/waitlist_party.dart';

class AddPartyDialog extends StatefulWidget {
  const AddPartyDialog({super.key});

  @override
  State<AddPartyDialog> createState() => _AddPartyDialogState();
}

class _AddPartyDialogState extends State<AddPartyDialog> {
  final _nameController = TextEditingController();
  final _partySizeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _partySizeController.dispose();
    super.dispose();
  }

  void _addParty() {
    final name = _nameController.text.trim();
    final partySize = int.tryParse(
      _partySizeController.text.trim(),
    );

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name cannot be empty'),
        ),
      );
      return;
    }

    if (partySize == null || partySize <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Party size must be greater than 0'),
        ),
      );
      return;
    }

    Navigator.of(context).pop(
      WaitlistParty(
        ticketNumber: 0,
        name: name,
        partySize: partySize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Party'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter name',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _partySizeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Party Size',
              hintText: 'Enter party size',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addParty,
          child: const Text('Add'),
        ),
      ],
    );
  }
}