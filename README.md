# Flutter Clean Architecture

Một Flutter app mẫu được xây dựng theo nguyên tắc Clean Architecture của Robert C. Martin (Uncle Bob).

## Kiến trúc

### 🏗️ Cấu trúc thư mục

```
lib/
├── core/
│   ├── error/
│   │   └── failures.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── injection/
│       └── injection_container.dart
├── features/
│   └── user/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── user_local_data_source.dart
│       │   │   └── user_remote_data_source.dart
│       │   ├── models/
│       │   │   └── user_model.dart
│       │   └── repositories/
│       │       └── user_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user.dart
│       │   ├── repositories/
│       │   │   └── user_repository.dart
│       │   └── usecases/
│       │       ├── get_user_info.dart
│       │       └── update_user_info.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── user_bloc.dart
│           │   ├── user_event.dart
│           │   └── user_state.dart
│           ├── pages/
│           │   └── user_profile_page.dart
│           └── widgets/
│               └── user_profile_form.dart
└── main.dart
```

### 🎯 Các Layer

#### 1. **Domain Layer** (Lớp nghiệp vụ)
- **Entities**: Đối tượng nghiệp vụ cốt lõi
- **Use Cases**: Các trường hợp sử dụng cụ thể
- **Repository Interfaces**: Giao diện truy cập dữ liệu

#### 2. **Data Layer** (Lớp dữ liệu)
- **Models**: Mô hình dữ liệu với JSON serialization
- **Data Sources**: Nguồn dữ liệu (Remote API, Local Cache)
- **Repository Implementations**: Triển khai giao diện repository

#### 3. **Presentation Layer** (Lớp giao diện)
- **BLoC**: Quản lý state với Business Logic Component
- **Pages**: Các màn hình của ứng dụng
- **Widgets**: Các component UI tái sử dụng

## 🔧 Công nghệ sử dụng

- **State Management**: `flutter_bloc` - Quản lý trạng thái
- **Dependency Injection**: `get_it` - Tiêm phụ thuộc
- **Network**: `dio` - HTTP client
- **Local Storage**: `shared_preferences` - Lưu trữ local
- **Functional Programming**: `dartz` - Either, Option patterns
- **Code Generation**: `json_serializable`, `freezed` - Tạo code tự động

## 🚀 Cách chạy

1. **Cài đặt dependencies:**
```bash
flutter pub get
```

2. **Tạo generated code:**
```bash
flutter packages pub run build_runner build
```

3. **Chạy ứng dụng:**
```bash
flutter run
```

## 🎨 Tính năng

- ✅ Hiển thị thông tin user profile
- ✅ Cập nhật thông tin cá nhân
- ✅ Xử lý lỗi và loading states
- ✅ Cache dữ liệu local
- ✅ Retry mechanism khi có lỗi

## 📋 Nguyên tắc Clean Architecture

### 1. **Dependency Rule**
- Các layer bên ngoài chỉ phụ thuộc vào layer bên trong
- Domain layer không phụ thuộc vào bất kỳ layer nào khác

### 2. **Separation of Concerns**
- Mỗi layer có trách nhiệm riêng biệt
- Business logic tách biệt khỏi UI và infrastructure

### 3. **Testability**
- Dễ dàng unit test từng layer
- Mock dependencies thông qua interfaces

### 4. **Maintainability**
- Code dễ bảo trì và mở rộng
- Thay đổi một layer không ảnh hưởng layer khác

## 🧪 Testing

Cấu trúc này hỗ trợ testing tốt:

```bash
# Unit tests cho domain layer
flutter test test/features/user/domain/

# Integration tests cho data layer
flutter test test/features/user/data/

# Widget tests cho presentation layer
flutter test test/features/user/presentation/
```

## 📚 Tài liệu tham khảo

- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)

---

**Lưu ý**: Đây là một ví dụ minh họa. Trong thực tế, bạn cần cấu hình API endpoints, xử lý authentication, và implement các tính năng bảo mật khác.
