import '../model/model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'indexer_api.g.dart';

@RestApi(baseUrl: "")
abstract class IndexerApi {
  factory IndexerApi(Dio dio, {String baseUrl}) = _IndexerApi;

  @POST("/v2/nft/query")
  Future<List<AssetToken>> getNftTokens(@Body() Map<String, List<String>> ids);

  @POST("/nft/query")
  Future<List<AssetToken>> getNFTTokens(
    @Query("offset") int offset,
  );

  @GET("/v2/nft")
  Future<List<AssetToken>> getNftTokensByOwner(
    @Query("owner") String owner,
    @Query("offset") int offset,
    @Query("size") int size,
    @Query("lastUpdatedAt") int lastUpdatedAt,
  );

  @POST("/nft/index")
  Future requestIndex(@Body() Map<String, String> payload);

  @GET("/identity/{accountNumber}")
  Future<BlockchainIdentity> getIdentity(
    @Path("accountNumber") String accountNumber,
  );
}

class BlockchainIdentity {
  String accountNumber;
  String blockchain;
  String name;

  BlockchainIdentity(this.accountNumber, this.blockchain, this.name);

  BlockchainIdentity.fromJson(Map<String, dynamic> json)
      : accountNumber = json['accountNumber'],
        blockchain = json['blockchain'],
        name = json['name'];
}
