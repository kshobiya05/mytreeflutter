class DependencyInjection {

  static final DependencyInjection _singleton = DependencyInjection._internal();

  factory DependencyInjection() {
    return _singleton;
  }

  DependencyInjection._internal();

  final Map<String, dynamic> _dependenciesMap = {};
  void register<T>(String key, T implementation) {
    _dependenciesMap[key] = implementation;
  }

  T get<T>(String key) {
    final implementation = _dependenciesMap[key];
    if (implementation == null) {
      throw Exception("Dependency not found for key '$key'");
    }
    if (implementation is! T) {
      throw Exception("Invalid dependency type for key '$key'");
    }
    return implementation as T;
  }
}
