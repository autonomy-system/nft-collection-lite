import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nft_collection_lite/bloc/nft_collection_bloc/nft_collection_bloc.dart';
import 'package:nft_collection_lite/gateway/indexer_api.dart';
import 'package:nft_collection_lite/service/asset_token_service.dart';
import 'package:nft_collection_lite/service/indexer_service.dart';

final injector = GetIt.instance;

class NftCollectionLite {
  static final instance = NftCollectionLite._();
  NftCollectionLite._() : super();
  static void setup(Config config) {
    injector.registerLazySingleton<Config>(() => config);
    injectorGateWay(config.dio, baseUrl: config.baseUrl);
    injectorService();
    injectorBloc();
  }

  static void injectorGateWay(Dio dio, {required String baseUrl}) {
    injector.registerLazySingleton<IndexerApi>(
        () => IndexerApi(dio, baseUrl: baseUrl));
    injector
        .registerLazySingleton<IndexerService>(() => IndexerService(baseUrl));
  }

  static void injectorBloc() {
    injector.registerFactoryParam<NftCollectionBloc, bool?, dynamic>(
        (p1, p2) => NftCollectionBloc(isSorted: p1 ?? true));
  }

  static void injectorService() {
    injector
        .registerLazySingleton<AssetTokenService>(() => AssetTokenService());
  }
}

class Config {
  final Dio dio;
  final String baseUrl;
  final int maxSize;

  Config({required this.dio, required this.baseUrl, this.maxSize = 50});
}
