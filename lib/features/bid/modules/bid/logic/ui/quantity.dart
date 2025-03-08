part of 'bid_form.dart';

class _Quantity extends StatelessWidget {
  final int max;

  const _Quantity({required this.max});

  @override
  Widget build(BuildContext context) {
    final quantityController =
        context.read<BidCubit>().state.bidDto.quantityController;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'Quantity'.tr(context)}:',
          style: TextStyle(
            fontSize: 20.sp,
            color: KColors.darkGrey,
            fontWeight: FontWeight.w400,
          ),
        ),
        heightSpace(2),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                if (quantityController.value! < max) {
                  quantityController.setValue(
                    quantityController.value! + 1,
                  );
                }
              },
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: KColors.dark,
                ),
              ),
            ),
            widthSpace(8),
            ValueListenableBuilder(
              valueListenable: quantityController,
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: KColors.dark,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            widthSpace(8),
            ElevatedButton(
              onPressed:
                  () => quantityController.setValue(
                    quantityController.value! > 1
                        ? quantityController.value! - 1
                        : 1,
                  ),
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: KColors.dark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
