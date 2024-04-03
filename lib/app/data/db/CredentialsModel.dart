import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'CredentialsModel.g.dart';

/// vaultId : "0000"
/// credType : "Login"
/// name : "Untitled"
/// email : "pratikbharad99@gmail.com"
/// password : "aksjdchlaehrubfvjbsfbie23484355486"
/// websites : ["https://www.google.com","https://www.google.com","https://www.google.com"]
/// notes : "lorim ipsum"
/// nameOnCard : "Pratik Bharad"
/// cardNumber : "9870 9870 9870 9870"
/// expiryDate : "12/29"
/// cvvCode : "123"
/// cardPin : "123456"

@Entity()
@JsonSerializable()
class CredentialsModel {
  @Id()
  int id = 0;
  @JsonKey(name: "vaultId")
  String? vaultId;
  @JsonKey(name: "credType")
  String? credType;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "websites")
  List<String>? websites;
  @JsonKey(name: "notes")
  String? notes;
  @JsonKey(name: "nameOnCard")
  String? nameOnCard;
  @JsonKey(name: "cardNumber")
  String? cardNumber;
  @JsonKey(name: "expiryDate")
  String? expiryDate;
  @JsonKey(name: "cvvCode")
  String? cvvCode;
  @JsonKey(name: "cardPin")
  String? cardPin;

  CredentialsModel({
    this.vaultId,
    this.credType,
    this.name,
    this.email,
    this.password,
    this.websites,
    this.notes,
    this.nameOnCard,
    this.cardNumber,
    this.expiryDate,
    this.cvvCode,
    this.cardPin,
  });

  CredentialsModel copyWith({
    String? vaultId,
    String? credType,
    String? name,
    String? email,
    String? password,
    List<String>? websites,
    String? notes,
    String? nameOnCard,
    String? cardNumber,
    String? expiryDate,
    String? cvvCode,
    String? cardPin,
  }) =>
      CredentialsModel(
        vaultId: vaultId ?? this.vaultId,
        credType: credType ?? this.credType,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        websites: websites ?? this.websites,
        notes: notes ?? this.notes,
        nameOnCard: nameOnCard ?? this.nameOnCard,
        cardNumber: cardNumber ?? this.cardNumber,
        expiryDate: expiryDate ?? this.expiryDate,
        cvvCode: cvvCode ?? this.cvvCode,
        cardPin: cardPin ?? this.cardPin,
      );

  factory CredentialsModel.fromJson(Map<String, dynamic> json) => _$CredentialsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialsModelToJson(this);
}
