import 'package:nft_collection_lite/graphql/model/get_list_tokens.dart';
import 'package:nft_collection_lite/service/indexer_service.dart';

import '/model/model.dart';
import '/utils/injectors.dart';

class AssetTokenService {
  final _config = injector.get<Config>();
  final _indexerService = injector.get<IndexerService>();
  AssetTokenService();

  Future<List<AssetToken>> getAssetToken({
    required List<String> owners,
    required int offset,
    DateTime? lastUpdatedAt,
  }) async {
    final size = _config.maxSize;

    final request = QueryListTokensRequest(
      owners: owners,
      offset: offset,
      size: size,
      lastUpdatedAt: lastUpdatedAt,
    );
    return _indexerService.getNftTokens(request);
  }

  Future<List<AssetToken>> getAssetTokensByIDs({
    required List<String> ids,
  }) async {
    final size = _config.maxSize;

    final request = QueryListTokensRequest(
      ids: ids,
      size: size,
    );
    return _indexerService.getNftTokens(request);
  }
}

class PageKey {
  int? offset;
  bool isLoaded;
  PageKey({
    this.offset,
    this.isLoaded = false,
  });

  @override
  bool operator ==(covariant PageKey other) {
    if (identical(this, other)) return true;

    return other.offset == offset && other.isLoaded == isLoaded;
  }

  @override
  int get hashCode => offset.hashCode ^ isLoaded.hashCode;

  @override
  String toString() => 'PageKey(offset: $offset,  isLoaded: $isLoaded)';
}
