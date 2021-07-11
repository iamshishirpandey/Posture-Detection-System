import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.size,
    this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Paracetamol",
      price: 234,
      size: 12,
      description: dummyText,
      image:
          "https://images.theconversation.com/files/142554/original/image-20161020-8855-1seo2vn.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Amifostine",
      price: 234,
      size: 8,
      description: dummyText,
      image:
          "https://images.theconversation.com/files/142554/original/image-20161020-8855-1seo2vn.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "Sartel H",
      price: 234,
      size: 10,
      description: dummyText,
      image:
          "https://images.theconversation.com/files/142554/original/image-20161020-8855-1seo2vn.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "Morphin",
      price: 234,
      size: 11,
      description: dummyText,
      image:
          "https://images.theconversation.com/files/142554/original/image-20161020-8855-1seo2vn.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
      color: Color(0xFFE6B398)),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
