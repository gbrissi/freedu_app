extension ListUnify on List<String> {
  String unify(String char, String unifyChar) =>
      sublist(0, length - 1).join(char) + unifyChar + this[length - 1];
}
