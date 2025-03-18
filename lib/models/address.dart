
class Address {
  final String address;
  final String city;
  final String state;
  final String zipCode;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address: map['address'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zipCode'],
    );
  }
}