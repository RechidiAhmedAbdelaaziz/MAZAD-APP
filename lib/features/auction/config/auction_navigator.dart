import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';

class AuctionNavigator extends AppNavigatorBase {
  AuctionNavigator.auctions() : super(name: AppRoutes.auctions);

  AuctionNavigator.createAuction()
    : super(name: AppRoutes.auctionCreate);

  AuctionNavigator.updateAuction(AuctionModel auction)
    : super(
        name: AppRoutes.auctionUpdate,
        pathParams: {'id': auction.id!},
      );
}
