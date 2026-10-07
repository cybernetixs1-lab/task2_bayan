import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controller/waitlist_controller.dart';

import '../../data/model/waitlist_party.dart';
import '../../data/repositories/wait_list_repo.dart';
import '../widgets/add_party_dialog.dart';
import '../widgets/party_card.dart';

class WaitlistScreen extends StatefulWidget {
  const WaitlistScreen({super.key});

  @override
  State<WaitlistScreen> createState() => _WaitlistScreenState();
}

class _WaitlistScreenState extends State<WaitlistScreen> {
  late final WaitlistController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WaitlistController(
      repository: WaitlistRepository(),
    );

    _controller.loadParties();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showAddPartyDialog() async {
  final result = await showDialog<WaitlistParty>(
    context: context,
    builder: (context) {
      return const AddPartyDialog();
    },
  );

  if (result == null) {
    return;
  }

  await _controller.addParty(
    name: result.name,
    partySize: result.partySize,
  );
}
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: const Text(
              'Restaurant Waitlist',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Waiting: ${_controller.parties.length} parties',
                  style: TextStyle(
                    color: AppColors.blackColor.withValues(
                      alpha: 0.8,
                    ),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: _controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _controller.parties.isEmpty
                          ? const Center(
                              child: Text(
                                'No parties waiting',
                              ),
                            )
                          : ListView.builder(
                              itemCount: _controller.parties.length,
                              itemBuilder: (context, index) {
                                final party =
                                    _controller.parties[index];

                                return PartyCard(
                                  party: party,
                                  partiesAhead: index,
                                  onRemove: () {
                                    _controller.removeParty(
                                      party.ticketNumber,
                                    );
                                  },
                                );
                              },
                            ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                    onPressed: _showAddPartyDialog,
                    backgroundColor: AppColors.primaryColor,
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    ),
                    label: const Text(
                      'Add Party',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}