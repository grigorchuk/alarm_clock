// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Alert {
    internal enum Alarm {
      /// Alarm
      internal static let title = L10n.tr("Localizable", "alert.alarm.title")
    }
    internal enum Cancel {
      /// Cancel
      internal static let button = L10n.tr("Localizable", "alert.cancel.button")
    }
    internal enum Ok {
      /// OK
      internal static let button = L10n.tr("Localizable", "alert.ok.button")
    }
    internal enum Stop {
      /// Stop
      internal static let button = L10n.tr("Localizable", "alert.stop.button")
    }
  }

  internal enum ApplicationState {
    /// Alarm
    internal static let alarm = L10n.tr("Localizable", "application_state.alarm")
    /// Idle
    internal static let idle = L10n.tr("Localizable", "application_state.idle")
    /// Paused
    internal static let paused = L10n.tr("Localizable", "application_state.paused")
    /// Playing
    internal static let playing = L10n.tr("Localizable", "application_state.playing")
    /// Recording
    internal static let recording = L10n.tr("Localizable", "application_state.recording")
  }

  internal enum Button {
    internal enum Pause {
      /// Pause
      internal static let title = L10n.tr("Localizable", "button.pause.title")
    }
    internal enum Resume {
      /// Resume
      internal static let title = L10n.tr("Localizable", "button.resume.title")
    }
    internal enum Start {
      /// Start
      internal static let title = L10n.tr("Localizable", "button.start.title")
    }
  }

  internal enum SleepTimer {
    /// 15 min
    internal static let fifteen = L10n.tr("Localizable", "sleep_timer.fifteen")
    /// 5 min
    internal static let five = L10n.tr("Localizable", "sleep_timer.five")
    /// Off
    internal static let off = L10n.tr("Localizable", "sleep_timer.off")
    /// 1 min
    internal static let one = L10n.tr("Localizable", "sleep_timer.one")
    /// 10 min
    internal static let ten = L10n.tr("Localizable", "sleep_timer.ten")
    /// Sleep timer
    internal static let title = L10n.tr("Localizable", "sleep_timer.title")
    /// 20 min
    internal static let twenty = L10n.tr("Localizable", "sleep_timer.twenty")
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
