import 'dart:convert';

class AccountModel {
  String id;
  String name;
  String lastName;
  String accountType;
  double balance;
  AccountModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.accountType,
    required this.balance,
  });

  AccountModel copyWith({
    String? id,
    String? name,
    String? lastName,
    String? accountType,
    double? balance,
  }) {
    return AccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      accountType: accountType ?? this.accountType,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'accountType': accountType,
      'balance': balance,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String,
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      accountType: map['accountType'] as String,
      balance: map['balance'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // PSM
  @override
  String toString() {
    return 'AccountModel(id: $id, name: $name, lastName: $lastName, accountType: $accountType, balance: $balance)';
  }

  // PSM
  @override
  bool operator ==(covariant AccountModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.accountType == accountType &&
        other.balance == balance;
  }

  // PSM
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lastName.hashCode ^
        accountType.hashCode ^
        balance.hashCode;
  }
}
