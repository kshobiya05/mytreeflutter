import 'package:connectivity/connectivity.dart';
import '../../api/util/FetchStrategy.dart';

  Future<FetchStrategy> getFetchStrategy() async {
    final ConnectivityResult connectivityResult =
    await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return FetchStrategy.Remote;
    } else {
      return FetchStrategy.Local;
    }
  }



