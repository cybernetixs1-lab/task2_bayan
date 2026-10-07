
import '../../../../core/database/waitlist_database.dart';
import '../model/waitlist_party.dart';



class WaitlistRepository {
  final AppDatabase _database;

  WaitlistRepository({
    AppDatabase? database,
  }) : _database = database ?? AppDatabase.instance;

  Future<List<WaitlistParty>> getParties() async {
    final db = await _database.database;

    final result = await db.query(
      'waitlist',
      orderBy: 'ticket_number ASC',
    );

    return result
        .map((map) => WaitlistParty.fromMap(map))
        .toList();
  }

  Future<WaitlistParty> addParty({
    required String name,
    required int partySize,
  }) async {
    final db = await _database.database;

    return await db.transaction((txn) async {
      final settings = await txn.query(
        'settings',
        where: 'id = ?',
        whereArgs: [1],
        limit: 1,
      );

      final nextTicketNumber =
          settings.first['next_ticket_number'] as int;

      final party = WaitlistParty(
        ticketNumber: nextTicketNumber,
        name: name,
        partySize: partySize,
      );

      await txn.insert(
        'waitlist',
        party.toMap(),
      );

      await txn.update(
        'settings',
        {
          'next_ticket_number': nextTicketNumber + 1,
        },
        where: 'id = ?',
        whereArgs: [1],
      );

      return party;
    });
  }

  Future<void> removeParty(int ticketNumber) async {
    final db = await _database.database;

    await db.delete(
      'waitlist',
      where: 'ticket_number = ?',
      whereArgs: [ticketNumber],
    );
  }
}