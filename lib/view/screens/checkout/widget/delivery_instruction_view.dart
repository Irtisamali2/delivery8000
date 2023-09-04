import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class DeliveryInstructionView extends StatefulWidget {
  const DeliveryInstructionView({Key? key}) : super(key: key);

  @override
  State<DeliveryInstructionView> createState() => _DeliveryInstructionViewState();
}

class _DeliveryInstructionViewState extends State<DeliveryInstructionView> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.05), blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
      child: GetBuilder<OrderController>(
        builder: (orderController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            ExpansionTile(
              key: widget.key,
              title: Text('add_more_delivery_instruction'.tr, style: robotoMedium),
              trailing: Icon(_isExpanded ? Icons.remove : Icons.add, size: 18),
              tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              onExpansionChanged: (value) {
                setState(() {
                  _isExpanded = value;
                });
                orderController.expandedUpdate(value);
              },

              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppConstants.deliveryInstructionList.length,
                  itemBuilder: (context, index) {
                    bool isSelected = orderController.selectedInstruction == index;
                    return InkWell(
                      onTap: () {
                        orderController.setInstruction(index);
                        if (_isExpanded) {
                          setState(() {
                            _isExpanded = false;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.grey[200],
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                        // ... rest of your widget code ...
                      ),
                    );
                  },
                ),
              ],
            ),

            // ... rest of your widget code ...

          ]);
        },
      ),
    );
  }
}
