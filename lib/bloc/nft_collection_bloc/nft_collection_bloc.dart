import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft_collection_lite/model/asset_token.dart';
import 'package:nft_collection_lite/service/asset_token_service.dart';
import 'package:nft_collection_lite/utils/injectors.dart';
import 'package:nft_collection_lite/utils/sorted_list.dart';
import 'nft_collection_state.dart';

class NftCollectionBloc extends Bloc<NftCollectionEvent, NftCollectionState> {
  final _assetTokenService = injector.get<AssetTokenService>();

  final bool isSorted;

  NftCollectionBloc({required this.isSorted}) : super(NftCollectionInitial()) {
    on<GetNFTByAddressesFromIndexer>((event, emit) async {
      try {
        final offset = event.pageKey.offset ?? 0;
        final addresses = event.addresses;

        NftCollectionLoaded? currentState;

        AuList<CompactedAssetToken> tokens = isSorted
            ? SortedList<CompactedAssetToken>()
            : NormalList<CompactedAssetToken>();

        if (state is NftCollectionLoaded) {
          currentState = state as NftCollectionLoaded;
          tokens = currentState.assetTokens;
        }

        if (offset == 0) {
          currentState?.assetTokens.clear();
          if (currentState != null) {
            emit(currentState.copyWith(
              loadingState: LoadingState.reloading,
            ));
          } else {
            emit(NftCollectionLoaded(
              assetTokens: tokens,
              loadingState: LoadingState.loading,
            ));
          }
        }

        if (addresses.isEmpty) {
          emit(NftCollectionLoaded(
            assetTokens: tokens,
            loadingState: LoadingState.completed,
          ));
          return;
        }

        final assetTokens = await _assetTokenService.getAssetToken(
          owners: addresses,
          offset: offset,
        );

        final compactedTokens = assetTokens
            .map((e) => CompactedAssetToken.fromAssetToken(e))
            .toList();

        tokens.addAll(compactedTokens);
        tokens.unique((element) => element.id + element.owner);

        PageKey? nextKey;

        if (assetTokens.isNotEmpty) {
          nextKey = PageKey(offset: offset + assetTokens.length);
        }

        emit(
          NftCollectionLoaded(
            assetTokens: tokens,
            nextKey: nextKey,
            loadingState: LoadingState.completed,
          ),
        );
      } catch (e) {}
    });

    on<GetNFTByTokenIDsFromIndexer>((event, emit) async {
      try {
        final tokenIDs = event.tokenIDs;
        final addresses = event.addresses;

        NftCollectionLoaded? currentState;

        AuList<CompactedAssetToken> tokens = isSorted
            ? SortedList<CompactedAssetToken>()
            : NormalList<CompactedAssetToken>();

        if (state is NftCollectionLoaded) {
          currentState = state as NftCollectionLoaded;
          tokens = currentState.assetTokens;
        }

        currentState?.assetTokens.clear();
        if (currentState != null) {
          emit(currentState.copyWith(
            loadingState: LoadingState.reloading,
          ));
        } else {
          emit(NftCollectionLoaded(
            assetTokens: tokens,
            loadingState: LoadingState.loading,
          ));
        }
        if (addresses.isEmpty) {
          emit(NftCollectionLoaded(
            assetTokens: tokens,
            loadingState: LoadingState.completed,
          ));
          return;
        }
        final assetTokens = await _assetTokenService.getAssetTokensByIDs(
          ids: tokenIDs,
        );

        final compactedTokens = assetTokens
            .map((e) => CompactedAssetToken.fromAssetToken(e))
            .toList();

        tokens.addAll(compactedTokens);
        tokens.unique((element) => element.id + element.owner);

        emit(
          NftCollectionLoaded(
            assetTokens: tokens,
            loadingState: LoadingState.completed,
          ),
        );
      } catch (e) {}
    });
  }
}
