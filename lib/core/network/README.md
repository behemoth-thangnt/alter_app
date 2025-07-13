# GraphQL Client Service

Dịch vụ GraphQL Client tối ưu hóa cho ứng dụng Flutter với kiến trúc Clean Architecture.

## Tính năng chính

- **Dual Client Architecture**: Hỗ trợ cả public và authenticated GraphQL endpoints
- **Automatic Token Management**: Tự động quản lý access token cho authenticated requests
- **Simple Status Logging**: Chỉ log trạng thái thành công/thất bại và lỗi
- **Error Handling**: Xử lý lỗi GraphQL và network một cách toàn diện

## Cấu hình Logging

### Logging Flags trong `ApiConstants`

```dart
static const bool enableStatusLogging = true;  // Log trạng thái operation
static const bool enableErrorLogging = true;   // Log chi tiết lỗi
static const bool enableDetailedLogging = false; // Chỉ dùng khi debug
```

### Logging Output

**Thành công:**
```
✅ [2024-01-15T10:30:00.000Z] Mutation signIn - Success
```

**Thất bại:**
```
❌ [2024-01-15T10:30:00.000Z] Mutation signIn - Failed
   GraphQL Error: Invalid credentials
```

**Network Error:**
```
💥 [2024-01-15T10:30:00.000Z] Query selfInfo - Error: SocketException
🌐 Network Error
```

## Tại sao chọn cách tiếp cận này?

### ✅ Ưu điểm
- **Performance**: Không log dữ liệu lớn, giảm overhead
- **Security**: Không có nguy cơ leak sensitive data
- **Simplicity**: Dễ đọc và maintain
- **Server-side logging**: API errors đã được log ở server

### ❌ Tránh
- Log toàn bộ request/response data
- Log sensitive information
- Verbose logging trong production

## Cấu hình cho Production

```dart
// Recommended production settings
static const bool enableStatusLogging = false;  // Tắt trong production
static const bool enableErrorLogging = true;    // Giữ để track errors
static const bool enableDetailedLogging = false; // Luôn false
```

## Debug Mode

Khi cần debug chi tiết:

```dart
static const bool enableDetailedLogging = true; // Chỉ khi cần thiết
```

**Lưu ý**: Chỉ enable detailed logging khi debug vấn đề cụ thể, sau đó tắt ngay.

## Icon Reference

- ✅ Success
- ❌ GraphQL Error
- 💥 Exception/Network Error
- 🌐 Network Issue
- ⏱️ Timeout

## Best Practices

1. **Luôn tắt logging trong production**
2. **Chỉ log errors để tracking**
3. **Không log sensitive data**
4. **Dựa vào server-side logging cho API analysis**
5. **Sử dụng detailed logging chỉ khi cần debug**
