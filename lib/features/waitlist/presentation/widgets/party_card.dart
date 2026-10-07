import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/waitlist_party.dart';

class PartyCard extends StatelessWidget {
  final WaitlistParty party;
  final int partiesAhead;
  final VoidCallback onRemove;

  const PartyCard({
    super.key,
    required this.party,
    required this.partiesAhead,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(party.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  
                )),
              
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Party Size: ${party.partySize}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 4),
                Text(
                  '$partiesAhead ${partiesAhead == 1 ? 'party' : 'parties'} ahead',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            trailing: Text(
              '#${party.ticketNumber}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
              ),
              onPressed: onRemove,
              child: const Text('Remove'),
            ),
          ),
        ],
      ),
    );
  }
}