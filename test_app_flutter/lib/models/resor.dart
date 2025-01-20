import 'dart:convert';

class Resor {
  final String? hjaelpmedel;
  final int antalpassagerare;
  final String kopplaIhop;
  final String? startpunkt;
  final String? destination;
  final DateTime? avgangstid;
  final DateTime? sjaelvbokadeResor;

  Resor({
    required this.hjaelpmedel,
    required this.antalpassagerare,
    required this.kopplaIhop,
    required this.avgangstid,
    required this.startpunkt,
    required this.destination,
    required this.sjaelvbokadeResor,
  });

  // Factory constructor för att skapa från JSON

  factory Resor.fromJson(Map<String, dynamic> json) {
    DateTime? _tryParseDate(String? date) {
      if (date == null) return null;
      try {
        return DateTime.parse(date);
      } catch (e) {
        print('Date parsing error: $e');
        return null;
      }
    }

    return Resor(
      hjaelpmedel: json['hjaelpmedel'] as String? ?? '',
      antalpassagerare: json['antalpassagerare'] as int,
      kopplaIhop: json['KopplaIhop'] as String,
      startpunkt: json['startpunkt'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      avgangstid: _tryParseDate(json['Avgangstid'] as String?),
      sjaelvbokadeResor: _tryParseDate(json['sjaelvbokade_resor'] as String?),
    );
  }

  // Metod för att konvertera till JSON
  Map<String, dynamic> toJson() {
    return {
      'hjaelpmedel': hjaelpmedel,
      'antalpassagerare': antalpassagerare,
      'KopplaIhop': kopplaIhop,
      'startpunkt': startpunkt,
      'destination': destination,
      'Avgangstid': avgangstid?.toIso8601String(),
      'sjaelvbokade_resor': sjaelvbokadeResor?.toString(),
    };
  }

  // Extra metod för att konvertera från JSON-sträng
  static Resor fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return Resor.fromJson(jsonData);
  }

  // Extra metod för att konvertera till JSON-sträng
  String toJsonString() {
    return json.encode(toJson());
  }
}
