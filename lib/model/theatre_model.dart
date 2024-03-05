import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TheatreModel {
  final String id;
  final String name;
  final LatLng coordinates;
  final List<String> facilities;
  final String fullAddress;
  final List<String> timings;
  final List<String> availableScreens;
  TheatreModel({
    required this.id,
    required this.name,
    this.coordinates = const LatLng(26.753547, 83.3730171),
    this.facilities = const [
      "Cancel",
      "Parking",
      "Hotel",
      "Park",
    ],
    this.fullAddress =
        "City Mall, 2 nd floor Park Road, Civil Lines, Golghar, Gorakhpur, Uttar Pradesh 273001",
    this.timings = const [
      "10:00 AM",
      "1:30 PM",
      "6:30 PM",
      "9:30 PM",
      "12:30 AM",
    ],
    this.availableScreens = const [
      "3D",
      "2D",
    ],
  });

  TheatreModel copyWith({
    String? id,
    String? name,
    LatLng? coordinates,
    List<String>? facilities,
    String? fullAddress,
    List<String>? timings,
    List<String>? availableScreens,
  }) {
    return TheatreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
      facilities: facilities ?? this.facilities,
      fullAddress: fullAddress ?? this.fullAddress,
      timings: timings ?? this.timings,
      availableScreens: availableScreens ?? this.availableScreens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coordinates': coordinates,
      'facilities': facilities,
      'fullAddress': fullAddress,
      'timings': timings,
      'availableScreens': availableScreens,
    };
  }

  factory TheatreModel.fromMap(Map<String, dynamic> map) {
    return TheatreModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      coordinates: map['coordinates'],
      facilities: List<String>.from(map['facilities']),
      fullAddress: map['fullAddress'] ?? '',
      timings: List<String>.from(map['timings']),
      availableScreens: List<String>.from(map['availableScreens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TheatreModel.fromJson(String source) =>
      TheatreModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TheatreModel(id: $id, name: $name, coordinates: $coordinates, facilities: $facilities, fullAddress: $fullAddress, timings: $timings, availableScreens: $availableScreens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TheatreModel &&
        other.id == id &&
        other.name == name &&
        other.coordinates == coordinates &&
        listEquals(other.facilities, facilities) &&
        other.fullAddress == fullAddress &&
        listEquals(other.timings, timings) &&
        listEquals(other.availableScreens, availableScreens);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coordinates.hashCode ^
        facilities.hashCode ^
        fullAddress.hashCode ^
        timings.hashCode ^
        availableScreens.hashCode;
  }
}
