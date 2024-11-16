import 'package:equatable/equatable.dart';

/// * The Relapse identifier is an important concept and can have its own type.
typedef RelapseID = String;

/// Class representing a Relapse.
class Relapse extends Equatable {
  const Relapse({
    required this.id,
    required this.date,
    required this.mood,
    required this.urge,
    required this.triggers,
    this.note,
  });

  factory Relapse.fromMap(Map<String, dynamic> map) {
    return Relapse(
      id: map['id'] as String,
      date: map['date'] as DateTime,
      mood: map['title'] as String,
      urge: map['description'] as String,
      triggers: map['price'] as String,
      note: map['availableQuantity'] as String,
    );
  }

  /// Unique Relapse id
  final RelapseID id;
  final DateTime date;
  final String mood;
  final String urge;
  final String triggers;
  final String? note;

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'mood': mood,
        'urge': urge,
        'triggers': triggers,
        'note': note,
      };

  Relapse copyWith({
    RelapseID? id,
    DateTime? date,
    String? mood,
    String? urge,
    String? triggers,
    String? note,
  }) {
    return Relapse(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      urge: urge ?? this.urge,
      triggers: triggers ?? this.triggers,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [id, date, mood, urge, triggers, note];

  @override
  bool? get stringify => true;
}