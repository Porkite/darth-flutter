class Coordinates {
  late String x;
  late String y;

  Coordinates(this.x, this.y);

  factory Coordinates.from(Coordinates other) {
    return Coordinates(other.x, other.y);
  }
}
