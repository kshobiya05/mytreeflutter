enum Dependencies {
  remote,
  local,
  useCase,
  database,
  api,
  network,
  viewModel,
  mapviewModel,
  geocoder,
  context,
}

extension DependenciesExtension on Dependencies {
  String get value {
    switch (this) {
      case Dependencies.remote:
        return 'remote repository';
      case Dependencies.local:
        return 'local repository';
      case Dependencies.useCase:
        return 'gettreeusecase';
      case Dependencies.database:
        return 'room-database';
      case Dependencies.api:
        return 'TreeApi';
      case Dependencies.network:
        return 'network-status';
      case Dependencies.viewModel:
        return 'TreeListViewModel';
      case Dependencies.mapviewModel:
        return 'MapViewModel';
      case Dependencies.geocoder:
        return 'geocoder';
      case Dependencies.context:
        return 'context';
    }
  }
}
