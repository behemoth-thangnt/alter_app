# Environment Configuration

This document explains how to configure environment variables for the Billiard Ecosystem Flutter app.

## Single .env File Approach

The app uses a single `.env` file for configuration. This approach is simple and matches how most deployment platforms work.

## Environment Variables

The `.env` file contains the following variables:

```bash
# API Configuration
API_BASE_URL=http://127.0.0.1:3006
API_PUBLIC_ENDPOINT=/graphql/public
API_USER_ENDPOINT=/graphql/user

# Debug Settings
DEBUG_MODE=true
LOG_LEVEL=debug
```

## Development Setup

1. **Copy the example file**:
   ```bash
   cp .env.example .env
   ```

2. **Update API URLs** in `.env` if needed:
   - For local development: `API_BASE_URL=http://127.0.0.1:3006`
   - For different local IP: `API_BASE_URL=http://192.168.1.100:3006`

3. **Run the app**:
   ```bash
   flutter run
   ```

## Production Deployment

For production, your deployment platform will typically:

1. **Set environment variables** through their dashboard/CLI:
   ```bash
   API_BASE_URL=https://api.billiard-ecosystem.com
   API_PUBLIC_ENDPOINT=/graphql/public
   API_USER_ENDPOINT=/graphql/user
   DEBUG_MODE=false
   LOG_LEVEL=error
   ```

2. **Or use a production .env file** that gets created during deployment

## Environment Configuration Class

The `EnvironmentConfig` class provides easy access to environment variables:

```dart
import 'package:billiard_ecosystem/core/config/environment_config.dart';

// Access environment variables
String apiUrl = EnvironmentConfig.apiBaseUrl;
bool isDebug = EnvironmentConfig.debugMode;

// Check environment
if (EnvironmentConfig.isDevelopment) {
  // Development-specific code
}

if (EnvironmentConfig.isProduction) {
  // Production-specific code
}

// Get debug info
Map<String, dynamic> info = EnvironmentConfig.debugInfo;
```

## API Configuration

The API constants are automatically configured based on the environment:

```dart
import 'package:billiard_ecosystem/core/constants/api_constants.dart';

// These values come from environment configuration
String publicApi = ApiConstants.publicGraphQLEndpoint;
String userApi = ApiConstants.userGraphQLEndpoint;
bool enableLogging = ApiConstants.enableStatusLogging;
```

## Environment Detection

The app automatically detects the environment based on:

- **Development**: `DEBUG_MODE=true` and API URL contains `127.0.0.1`
- **Production**: `DEBUG_MODE=false` and API URL doesn't contain `127.0.0.1`

## Security Notes

- **Never commit `.env` files** to version control (they're in `.gitignore`)
- **Commit `.env.example`** as a template for other developers
- **Production secrets** should be managed through your deployment platform
- **Local development** uses the `.env` file you create

## Common Configurations

### Local Development
```bash
API_BASE_URL=http://127.0.0.1:3006
DEBUG_MODE=true
LOG_LEVEL=debug
```

### Production
```bash
API_BASE_URL=https://api.billiard-ecosystem.com
DEBUG_MODE=false
LOG_LEVEL=error
```

### Testing with Different API
```bash
API_BASE_URL=http://192.168.1.100:3006
DEBUG_MODE=true
LOG_LEVEL=info
```

## Troubleshooting

### Environment not loading
- Ensure `.env` file exists in project root
- Check that `flutter_dotenv` is properly installed
- Verify `EnvironmentConfig.initialize()` is called in `main()`

### API endpoints not working
- Verify API URLs in `.env` file
- Check network connectivity
- Ensure API servers are running

### Build errors
- Run `flutter clean` && `flutter pub get`
- Verify `.env` file is in `pubspec.yaml` assets
- Check that all environment variables have fallback values in code
