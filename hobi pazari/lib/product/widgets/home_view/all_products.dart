import 'package:flutter/material.dart';
import 'package:vtproje/Database/database_service.dart';
import 'package:vtproje/Screens/constants/color_constants.dart';
import 'package:vtproje/Screens/item/model/item_model.dart';
import 'package:vtproje/Screens/item/view/item_information_view.dart';
import 'package:vtproje/Screens/user/model/user_model.dart';
import 'package:vtproje/product/widgets/login/custom_text_widget.dart';

class AllProducts extends StatefulWidget {
  final List<ItemModel> itemModels;
  final bool myProductsPage;
  final DataBaseService dataBaseService;

  const AllProducts({
    Key? key,
    required this.itemModels,
    required this.dataBaseService,
    required this.myProductsPage,
  }) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: MediaQuery.of(context).size.longestSide * 2,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: ScrollController(keepScrollOffset: false),
          itemCount: widget.itemModels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemInformationView(
                    dataBaseService: widget.dataBaseService,
                    itemModel: widget.itemModels[index],
                    userModel: DataBaseService.userModel,
                  ),
                ),
              ),
              child: Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        widget.itemModels[index].imagePath,
                        fit: BoxFit.fitWidth,
                        height: 105,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: CustomTextWidget(
                        textString: widget.itemModels[index].name,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CustomTextWidget(
                        textString:
                            "Seller: ${widget.itemModels[index].sellerUsername}",
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        widget.myProductsPage == true
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 5, top: 3),
                                child: InkWell(
                                  child: const Icon(
                                    Icons.delete,
                                    size: 16,
                                  ),
                                  onTap: () async {
                                    setState(() {});
                                    await widget.dataBaseService.deleteItem(
                                        widget.itemModels[index].id);
                                  },
                                ),
                              )
                            : const SizedBox.shrink(),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: CustomTextWidget(
                            textString: "${widget.itemModels[index].price} TL",
                            fontSize: 14,
                            textColor: ColorConstants.orangeColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}