import 'package:flutter/foundation.dart';

import '../data/model/waitlist_party.dart';
import '../data/repositories/wait_list_repo.dart';


class WaitlistController extends ChangeNotifier {
  final WaitlistRepository _repository;

  WaitlistController({
    WaitlistRepository? repository,
  }) : _repository = repository ?? WaitlistRepository();

  List<WaitlistParty> _parties = [];

  List<WaitlistParty> get parties => List.unmodifiable(_parties);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadParties() async {
    _isLoading = true;
    notifyListeners();

    _parties = await _repository.getParties();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addParty({
    required String name,
    required int partySize,
  }) async {
    await _repository.addParty(
      name: name,
      partySize: partySize,
    );

    await loadParties();
  }

  Future<void> removeParty(int ticketNumber) async {
    await _repository.removeParty(ticketNumber);

    await loadParties();
  }

  int partiesAhead(int index) {
    return index;
  }

  
}