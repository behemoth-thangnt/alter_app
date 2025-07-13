class ProfileApiConstants {
  // GraphQL Operations for Profile Management
  static const String selfInfoQuery = '''
    query SelfInfo {
      selfInfo {
        id
        name
        imageUrl
        phoneNumber
        gender
        birthDate
        createdAt
        updatedAt
      }
    }
  ''';

  static const String updateSelfInfoMutation = '''
    mutation UpdateSelfInfo(\$input: UpdateSelfInfoInput!) {
      updateSelfInfo(input: \$input) {
        id
        name
        imageUrl
        phoneNumber
        gender
        birthDate
        createdAt
        updatedAt
      }
    }
  ''';

  static const String uploadProfileImageMutation = '''
    mutation UploadProfileImage(\$file: Upload!) {
      uploadProfileImage(file: \$file) {
        id
        imageUrl
        updatedAt
      }
    }
  ''';

  static const String changePasswordMutation = '''
    mutation ChangePassword(\$currentPassword: String!, \$newPassword: String!) {
      changePassword(currentPassword: \$currentPassword, newPassword: \$newPassword) {
        success
        message
      }
    }
  ''';

  static const String updateNotificationSettingsMutation = '''
    mutation UpdateNotificationSettings(\$input: NotificationSettingsInput!) {
      updateNotificationSettings(input: \$input) {
        id
        emailNotifications
        pushNotifications
        smsNotifications
        updatedAt
      }
    }
  ''';
}
