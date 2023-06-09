// ignore_for_file: public_member_api_docs, sort_constructors_first
//
//  SPDX-License-Identifier: BSD-2-Clause-Patent
//  Copyright © 2022 Bitmark. All rights reserved.
//  Use of this source code is governed by the BSD-2-Clause Plus Patent License
//  that can be found in the LICENSE file.
//

import 'package:nft_collection_lite/model/asset_token.dart';

class Token {
  String id;
  String? tokenId;
  String blockchain;
  bool? fungible;
  String? contractType;
  String? contractAddress;
  int edition;
  String? editionName;
  DateTime? mintedAt;
  int? balance;
  String owner;
  Map<String, int> owners;
  String? source;
  bool? swapped;
  bool? burned;

  DateTime lastActivityTime;
  DateTime lastRefreshedTime;
  bool? ipfsPinned;

  bool? scrollable;
  bool? pending;
  bool? isDebugged;
  String? initialSaleModel;
  String? originTokenInfoId;
  String? indexID;

  Token({
    required this.id,
    this.tokenId,
    required this.blockchain,
    required this.fungible,
    required this.contractType,
    required this.contractAddress,
    required this.edition,
    required this.editionName,
    required this.mintedAt,
    required this.balance,
    required this.owner,
    required this.owners,
    required this.source,
    this.swapped = false,
    this.burned,
    required this.lastActivityTime,
    required this.lastRefreshedTime,
    this.ipfsPinned,
    this.scrollable,
    this.pending,
    this.initialSaleModel,
    this.originTokenInfoId,
    this.indexID,
    this.isDebugged,
  });

  factory Token.fromAssetToken(AssetToken assetToken) => Token(
        blockchain: assetToken.blockchain,
        fungible: assetToken.fungible,
        contractType: assetToken.contractType,
        contractAddress: assetToken.contractAddress,
        edition: assetToken.edition,
        editionName: assetToken.editionName,
        id: assetToken.id,
        mintedAt: assetToken.mintedAt,
        source: assetToken.projectMetadata?.latest.source,
        owners: assetToken.owners,
        balance: assetToken.balance,
        lastActivityTime: assetToken.lastActivityTime,
        swapped: assetToken.swapped ?? false,
        owner: assetToken.owner,
        lastRefreshedTime: assetToken.lastRefreshedTime,
        burned: assetToken.burned,
        ipfsPinned: assetToken.ipfsPinned,
        pending: assetToken.pending ?? false,
        scrollable: assetToken.attributes?.scrollable,
        tokenId: assetToken.tokenId,
        isDebugged: assetToken.isDebugged ?? false,
        indexID: assetToken.projectMetadata?.indexID,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pending == other.pending;

  @override
  int get hashCode => id.hashCode;
}
