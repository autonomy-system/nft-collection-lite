import 'package:nft_collection_lite/nft_collection_lite.dart';

class QueryIdentityResponse {
  BlockchainIdentity identity;
  QueryIdentityResponse({
    required this.identity,
  });

  factory QueryIdentityResponse.fromJson(Map<String, dynamic> map) {
    return QueryIdentityResponse(
      identity: map['identity'] != null
          ? BlockchainIdentity.fromJson(map['identity'])
          : BlockchainIdentity('', '', ''),
    );
  }
}

class QueryIdentityRequest {
  final String account;

  QueryIdentityRequest({
    required this.account,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'account': account,
    };
  }
}
