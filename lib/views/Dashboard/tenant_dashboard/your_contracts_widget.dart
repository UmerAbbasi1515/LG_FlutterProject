
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/tenant_dashboard/tenant_dashboard_get_data_controller.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/error_text_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/status_widget.dart';
import 'package:sizer/sizer.dart';

class YourContracts extends StatefulWidget {
  final Function(int)? manageContracts;
  const YourContracts({super.key, this.manageContracts});

  @override
  State<YourContracts> createState() => _YourContractsState();
}

class _YourContractsState extends State<YourContracts> {
  final TenantDashboardGetDataController getContractsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 2.0.h,
        right: 2.0.h,
        top: 1.0.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.0.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0.h,
              spreadRadius: 0.6.h,
              offset: Offset(0.0.h, 0.7.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
              child: Row(
                children: [
                  Obx(() {
                    return Text(
                      10 == 0
                          ? AppMetaLabels().yourContracts
                          : "${AppMetaLabels().yourContracts}  (${getContractsController.contractsLength.value})",
                      style: AppTextStyle.semiBoldBlack13,
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: const AppDivider(),
            ),
            Obx(() {
              return getContractsController.loadingContractsData.value == true
                  ? const LoadingIndicatorBlue()
                  : getContractsController.contractsError.value != '' ||
                          getContractsController.contractsLength.value == 0
                      ? AppErrorWidget(
                          errorText: getContractsController
                                      .contractsLength.value ==
                                  0
                              ? AppMetaLabels().noDatafound
                              : getContractsController.contractsError.value,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getContractsController.listLength.value,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                // SessionController().setContractID(
                                //     getContractsController.getContracts.value
                                //         .contracts![index].contractId);
                                // SessionController().setContractNo(
                                //     getContractsController.getContracts.value
                                //         .contracts![index].contractno);
                                // await Get.to(() => ContractsDetailsTabs(
                                //       prevContractNo: getContractsController
                                //           .getContracts
                                //           .value
                                //           .contracts![index]
                                //           .previousContactNo,
                                //     ));
                                // getContractsController.getDashboardData();
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.5.w, vertical: 1.5.h),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          // height: 12.0.h,
                                          width: 78.0.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 50.0.w,
                                                    child: Text(
                                                      SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? "Test ENG"
                                                          : "Test URD",
                                                      style: AppTextStyle
                                                          .semiBoldBlack12,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "123444",
                                                    style: AppTextStyle
                                                        .semiBoldBlack12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 30.0.w,
                                                    child: Text(
                                                      AppMetaLabels().unitNo,
                                                      style: AppTextStyle
                                                          .semiBoldBlack12,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: 40.0.w,
                                                    child: Text(
                                                      "U Ref 11222",
                                                      style: AppTextStyle
                                                          .semiBoldBlack12,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "12/12/12223",
                                                    style: AppTextStyle
                                                        .normalGrey10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.w),
                                                    child: Icon(
                                                        Icons.arrow_forward,
                                                        size: 10.sp,
                                                        color: AppColors
                                                            .greyColor),
                                                  ),
                                                  Text(
                                                    "1/12/2122",
                                                    style: AppTextStyle
                                                        .normalGrey10,
                                                  ),
                                                  const Spacer(),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints(
                                                            maxWidth: 27.w),
                                                    child: FittedBox(
                                                      child: StatusWidget(
                                                        text: SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? "Approved ENG"
                                                            : "Approved URD",
                                                        valueToCompare:
                                                            "Approved"
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.5.h, left: 2.0.h),
                                          child: SizedBox(
                                            width: 0.15.w,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColors.grey1,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.0.h, right: 1.0.h),
                                    child: const AppDivider(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
            }),
            getContractsController.listLength.value == 0
                ? SizedBox(
                    height: 9.0.h,
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        widget.manageContracts!(1);
                      },
                      child: Text(
                        AppMetaLabels().viewAllContracts,
                        style: AppTextStyle.semiBoldBlue9,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
