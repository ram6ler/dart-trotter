part of trotter;

/// Splits a string into its characters.
List characters(String x) => x.split("");

/// Creates a string from split characters.
String string(List x) => x.join("");