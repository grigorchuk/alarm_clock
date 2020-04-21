// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Alarm {
    /// Alarm
    internal static let title = L10n.tr("Localizable", "alarm.title")
  }

  internal enum ApplicationState {
    /// Idle
    internal static let idle = L10n.tr("Localizable", "application_state.idle")
  }

  internal enum Button {
    internal enum Start {
      /// Start
      internal static let title = L10n.tr("Localizable", "button.start.title")
    }
  }

  internal enum Choose {
    /// Choose
    internal static let button = L10n.tr("Localizable", "choose.button")
  }

  internal enum SleepTimer {
    /// Sleep timer
    internal static let title = L10n.tr("Localizable", "sleep_timer.title")
  }

  internal enum Toolbar {
    internal enum Alarm {
      /// Alarm
      internal static let title = L10n.tr("Localizable", "toolbar.alarm.title")
    }
    internal enum Cancel {
      /// Cancel
      internal static let button = L10n.tr("Localizable", "toolbar.cancel.button")
    }
    internal enum Done {
      /// Done
      internal static let button = L10n.tr("Localizable", "toolbar.done.button")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
