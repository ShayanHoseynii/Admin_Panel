import 'package:admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TPaginatedDataTable extends StatelessWidget {
  const TPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = TSizes.xl * 2,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  final bool sortAscending;
  final int? sortColumnIndex;
  final int rowsPerPage;
  final double tableHeight;
  final List<DataColumn> columns;
  final DataTableSource source;
  final Function(int)? onPageChanged;
  final double dataRowHeight;
  final double? minWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tableHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
            cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
        )),
        child: PaginatedDataTable2(
          source: source,
          columns: columns,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          showFirstLastButtons: true,
          showCheckboxColumn: true,
          sortAscending: sortAscending,
          sortColumnIndex: sortColumnIndex,
          dataRowHeight: dataRowHeight,
          renderEmptyRowsInTheEnd: false,
          onPageChanged: onPageChanged,
          onRowsPerPageChanged: (noOfRows) {
            if (noOfRows != null) {
              // handle rowsPerPage change
            }
          },
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateProperty.resolveWith(
            (states) => TColors.primaryBackground,
          ),
          headingRowDecoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.borderRadiusMd),
              topRight: Radius.circular(TSizes.borderRadiusMd),
            ),
          ),
          empty: TAnimationLoaderWidget(
            animation: TImages.packageAnimation,
            text: 'Nothing Found',
            height: 200,
            width: 200,
          ),
          sortArrowBuilder: (bool ascending, bool sorted) {
            if (sorted) {
              return Icon(
                ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                size: TSizes.iconSm,
              );
            } else {
              return const Icon(Iconsax.arrow_3, size: TSizes.iconSm);
            }
          },
        ),
      ),
    );
  }
}
