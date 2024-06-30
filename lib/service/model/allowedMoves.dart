import 'dart:ffi';

class AllowedMoves {
  final bool _north;
  final bool _south;
  final bool _east;
  final bool _west;

  AllowedMoves({
    required bool north,
    required bool south,
    required bool east,
    required bool west,
  })  : _north = north,
        _south = south,
        _east = east,
        _west = west;

  bool get north => _north;
  bool get south => _south;
  bool get east => _east;
  bool get west => _west;
}