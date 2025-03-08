part of 'home_screen.dart';

class _Drawer extends StatelessWidget {
  const _Drawer();

  void _showPage(BuildContext context, VoidCallback routing) {
    routing();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: KColors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 70.h,
        ),
        child: Column(
          spacing: 15.h,
          children: [
            ...[
              _DrawerItem(
                prefix: Icon(Icons.home, color: KColors.white),
                title: 'Home'.tr(context),
                onTap:
                    () => _showPage(
                      context,
                      () => context.off(HomeNavigator()),
                    ),
              ),
              _DrawerItem(
                prefix: Icon(Icons.person, color: KColors.white),
                title: 'Profile'.tr(context),
                onTap:
                    () => _showPage(
                      context,
                      () => context.off(UserNavigator.profile()),
                    ),
              ),
              _DrawerItem(
                prefix: Icon(
                  Icons.attach_money_rounded,
                  color: KColors.white,
                ),
                title: 'MyOffers'.tr(context),
                onTap:
                    () => _showPage(
                      context,
                      () => context.off(BidNavigator.myBids()),
                    ),
              ),
              _DrawerItem(
                prefix: Icon(Icons.language, color: KColors.white),
                title: 'Language'.tr(context),
                suffix: LocalizationButton(),
              ),
            ].map(_buildDrawerItem),

            const Spacer(),

            ...[
              _DrawerItem(
                prefix: Icon(Icons.logout, color: KColors.white),
                title: 'Logout'.tr(context),
                onTap: locator<AuthCubit>().logout,
              ),
            ].map(_buildDrawerItem),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(_DrawerItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: InkWell(
        onTap: item.onTap,
        child: Row(
          children: [
            item.prefix,

            widthSpace(16),

            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  color: KColors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (item.suffix != null) item.suffix!,
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  final Widget prefix;
  final String title;
  final Widget? suffix;

  final VoidCallback? onTap;

  const _DrawerItem({
    required this.prefix,
    required this.title,
    this.suffix,
    this.onTap,
  });
}
