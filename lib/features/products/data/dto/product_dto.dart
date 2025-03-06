import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';
import 'package:mazad_app/core/shared/dto/imagedto/image.dto.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';

abstract class ProductDto extends FormDTO {
  final TextEditingController nameController;
  final ListEditingcontroller<ImageDTO> imagesController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController stockController;
  final ListEditingcontroller<int> suggestedPricesController;
  final EditingController<AuctionModel> auctionController;
  final TextEditingController categoryController;

  ProductDto({
    required this.nameController,
    required this.imagesController,
    required this.descriptionController,
    required this.priceController,
    required this.stockController,
    required this.suggestedPricesController,
    required this.auctionController,
    required this.categoryController,
  });

  @override
  void dispose() {
    nameController.dispose();
    imagesController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    suggestedPricesController.dispose();
  }
}

class CreateProductDto extends ProductDto {
  CreateProductDto()
    : super(
        nameController: TextEditingController(),
        imagesController: ListEditingcontroller<ImageDTO>(),
        descriptionController: TextEditingController(),
        priceController: TextEditingController(),
        stockController: TextEditingController(),
        suggestedPricesController: ListEditingcontroller<int>(),
        auctionController: EditingController<AuctionModel>(),
        categoryController: TextEditingController(),
      );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'name': nameController.text,
      'images': await imagesController.value.imageUrls,
      'description': descriptionController.text,
      'price': int.parse(priceController.text),
      'stock': int.parse(stockController.text),
      'suggestedPrices': suggestedPricesController.value,
      'auction': auctionController.value?.id,
      'category': categoryController.text,
    };
  }
}

class UpdateProductDto extends ProductDto {
  final ProductModel _product;

  String get id => _product.id!;

  UpdateProductDto(this._product)
    : super(
        nameController: TextEditingController(text: _product.name),
        imagesController: ListEditingcontroller<ImageDTO>(
          _product.images
              ?.map((e) => RemoteImageDTO(url: e))
              .toList(),
        ),
        descriptionController: TextEditingController(
          text: _product.description,
        ),
        priceController: TextEditingController(
          text: _product.price.toString(),
        ),
        stockController: TextEditingController(
          text: _product.stock.toString(),
        ),
        suggestedPricesController: ListEditingcontroller<int>(
          _product.suggestedPrices,
        ),
        auctionController: EditingController<AuctionModel>(
          _product.auction,
        ),
        categoryController: TextEditingController(
          text: _product.category,
        ),
      );

  @override
  Future<Map<String, dynamic>> toMap() async {
    final imageUrls = await imagesController.value.imageUrls;
    return {
      if (nameController.text != _product.name)
        'name': nameController.text,

      if (imageUrls != _product.images) 'images': imageUrls,

      if (descriptionController.text != _product.description)
        'description': descriptionController.text,

      if (double.parse(priceController.text) != _product.price)
        'price': int.parse(priceController.text),

      if (int.parse(stockController.text) != _product.stock)
        'stock': int.parse(stockController.text),

      if (suggestedPricesController.value != _product.suggestedPrices)
        'suggestedPrices': suggestedPricesController.value,

      if (auctionController.value?.id != _product.auction?.id)
        'auction': auctionController.value?.id,

      if (categoryController.text != _product.category)
        'category': categoryController.text,
    };
  }
}
