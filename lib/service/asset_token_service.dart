import '/gateway/indexer_api.dart';
import '/model/model.dart';
import '/utils/injectors.dart';

class AssetTokenService {
  final _indexerApi = injector.get<IndexerApi>();
  final _config = injector.get<Config>();
  AssetTokenService();

  Future<List<AssetToken>> getAssetToken({
    required List<String> owners,
    required int offset,
    required int lastUpdatedAt,
  }) async {
    final owner = owners.join(',');
    final size = _config.maxSize;
    return _indexerApi.getNftTokensByOwner(owner, offset, size, lastUpdatedAt);
  }

  Future<List<AssetToken>> getAssetTokensByIDs({
    required List<String> ids,
  }) async {
    return _indexerApi.getNftTokens({"ids": ids});
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
