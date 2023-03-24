// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nft_collection_lite/model/asset_token.dart';
import 'package:nft_collection_lite/service/asset_token_service.dart';
import 'package:nft_collection_lite/utils/sorted_list.dart';

abstract class NftCollectionState {}

abstract class NftCollectionEvent {}

class NftCollectionInitEvent extends NftCollectionEvent {
  final List<String> addresses;
  final List<String>? tokenIDs;

  NftCollectionInitEvent({required this.addresses, this.tokenIDs});
}

class GetNFTByAddressesFromIndexer extends NftCollectionEvent {
  final List<String> addresses;
  final PageKey pageKey;
  GetNFTByAddressesFromIndexer({
    required this.addresses,
    required this.pageKey,
  });
}

class GetNFTByTokenIDsFromIndexer extends NftCollectionEvent {
  final List<String> tokenIDs;
  final List<String> addresses;
  final PageKey pageKey;
  GetNFTByTokenIDsFromIndexer({
    required this.addresses,
    required this.tokenIDs,
    required this.pageKey,
  });
}

class NftCollectionInitial extends NftCollectionState {
  NftCollectionInitial();
}

class NftCollectionLoaded extends NftCollectionState {
  final AuList<CompactedAssetToken> assetTokens;
  final PageKey? nextKey;
  final LoadingState loadingState;
  NftCollectionLoaded({
    required this.assetTokens,
    this.nextKey,
    this.loadingState = LoadingState.loading,
  });

  NftCollectionLoaded copyWith({
    AuList<CompactedAssetToken>? assetTokens,
    PageKey? nextKey,
    LoadingState? loadingState,
  }) {
    return NftCollectionLoaded(
      assetTokens: assetTokens ?? this.assetTokens,
      nextKey: nextKey ?? this.nextKey,
      loadingState: loadingState ?? this.loadingState,
    );
  }
}

enum LoadingState {
  loading,
  reloading,
  completed,
}
