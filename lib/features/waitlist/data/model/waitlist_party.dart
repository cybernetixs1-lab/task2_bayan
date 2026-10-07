class WaitlistParty {
  final int ticketNumber;
  final String name;
  final int partySize;

  const WaitlistParty({
    required this.ticketNumber,
    required this.name,
    required this.partySize,
  });

  Map<String, dynamic> toMap() {
    return {
      'ticket_number': ticketNumber,
      'name': name,
      'party_size': partySize,
    };
  }

  factory WaitlistParty.fromMap(Map<String, dynamic> map) {
    return WaitlistParty(
      ticketNumber: map['ticket_number'] as int,
      name: map['name'] as String,
      partySize: map['party_size'] as int,
    );
  }
}