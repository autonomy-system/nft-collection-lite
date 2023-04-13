import 'package:nft_collection_lite/graphql/clients/indexer_client.dart';
import 'package:nft_collection_lite/graphql/model/models.dart';
import 'package:nft_collection_lite/graphql/queries/queries.dart';
import 'package:nft_collection_lite/nft_collection_lite.dart';

class IndexerService {
  late final IndexerClient _client;
  IndexerService(String baseUrl) {
    this._client = IndexerClient('$baseUrl');
  }

  Future<List<AssetToken>> getNftTokens(QueryListTokensRequest request) async {
    final vars = request.toJson();
    final result = await _client.query(
      doc: getTokens,
      vars: vars,
    );
    if (result == null) {
      return [];
    }
    final data = QueryListTokensResponse.fromJson(result);
    return data.tokens;
  }

  Future<BlockchainIdentity> getIdentity(QueryIdentityRequest request) async {
    final vars = request.toJson();
    final result = await _client.query(
      doc: identity,
      vars: vars,
    );
    if (result == null) {
      return BlockchainIdentity('', '', '');
    }
    final data = QueryIdentityResponse.fromJson(result);
    return data.identity;
  }
}
