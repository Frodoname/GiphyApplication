// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Text {
  /// Details:
  internal static let details = Text.tr("Localizable", "details", fallback: "Details:")
  /// Tap here
  internal static let link = Text.tr("Localizable", "link", fallback: "Tap here")
  /// Localizable.strings
  ///   GiphyApp
  /// 
  ///   Created by Fed on 27.03.2023.
  internal static let mainTitle = Text.tr("Localizable", "mainTitle", fallback: "Trends")
  /// nick name is missing
  internal static let noNickName = Text.tr("Localizable", "noNickName", fallback: "nick name is missing")
  /// Reload Data
  internal static let reload = Text.tr("Localizable", "reload", fallback: "Reload Data")
  /// Save
  internal static let save = Text.tr("Localizable", "save", fallback: "Save")
  /// Search a gif
  internal static let search = Text.tr("Localizable", "search", fallback: "Search a gif")
  /// Source: 
  internal static let source = Text.tr("Localizable", "source", fallback: "Source: ")
  /// Uploaded by: 
  internal static let uploadedBy = Text.tr("Localizable", "uploadedBy", fallback: "Uploaded by: ")
  /// Uploaded on: 
  internal static let uploadTime = Text.tr("Localizable", "uploadTime", fallback: "Uploaded on: ")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Text {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
