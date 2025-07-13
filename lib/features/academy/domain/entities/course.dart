import 'package:equatable/equatable.dart';
import '../../../../shared/domain/entities/teacher.dart';

class Course extends Equatable {
  final int id;
  final int teacherId;
  final String title;
  final String slug;
  final String? description;
  final int? salePrice;
  final int? price;
  final int? bonusPoint;
  final String status;
  final String? instructionalLevel;
  final int? bonusPointPercent;
  final int sectionCount;
  final int sectionItemCount;
  final int joinedUserCount;
  final String? banner;
  final bool isPublic;
  final double? averageRating;
  final Teacher? teacher;
  final bool joined;
  final double processPercent;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Course({
    required this.id,
    required this.teacherId,
    required this.title,
    required this.slug,
    this.description,
    this.salePrice,
    this.price,
    this.bonusPoint,
    required this.status,
    this.instructionalLevel,
    this.bonusPointPercent,
    required this.sectionCount,
    required this.sectionItemCount,
    required this.joinedUserCount,
    this.banner,
    required this.isPublic,
    this.averageRating,
    this.teacher,
    required this.joined,
    required this.processPercent,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        teacherId,
        title,
        slug,
        description,
        salePrice,
        price,
        bonusPoint,
        status,
        instructionalLevel,
        bonusPointPercent,
        sectionCount,
        sectionItemCount,
        joinedUserCount,
        banner,
        isPublic,
        averageRating,
        teacher,
        joined,
        processPercent,
        createdAt,
        updatedAt,
      ];

  bool get isFree => salePrice == null || salePrice == 0;
  bool get hasDiscount =>
      price != null && salePrice != null && salePrice! < price!;

  String get displayPrice {
    if (isFree) return 'Miễn phí';
    if (salePrice != null) {
      return '${_formatPrice(salePrice!)} VNĐ';
    }
    if (price != null) {
      return '${_formatPrice(price!)} VNĐ';
    }
    return 'Liên hệ';
  }

  String? get originalPrice {
    if (hasDiscount && price != null) {
      return '${_formatPrice(price!)} VNĐ';
    }
    return null;
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
