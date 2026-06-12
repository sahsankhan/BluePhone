from typing import Optional, Tuple, Union
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword
import subprocess

@library
class iOSTestLibrary:
    """
    A MobAppTestLibrary for managing iOS device interactions and utilities.

    This library provides Robot Framework keywords to interact with iOS devices,
    including unlocking, locking, managing Wi-Fi, capturing device logs, and
    other system-level actions.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the iOSTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.iostestlibrary = mob

    @keyword
    def turn_off_flight_mode_for_ios(self) -> str:
        """
        Turns off Flight Mode (Airplane Mode) on an iOS device using system preferences.

        Input Parameters:
            - None

        Output:
            - str - "disabled" if flight mode was successfully turned off, otherwise "enabled".

        Error Handling:
            - Raises Exception if the process of turning off flight mode fails due to a UI issue, element not found, or Appium failure.

        Examples:
        | ${status}= | Flight Mode Off iOS |
        | Log        | Flight mode status is ${status} |
        """
        try:
            return self.iostestlibrary.flight_mode_off_ios()
        except Exception as e:
            raise Exception(f"Failed to disable flight mode: {str(e)}") from e

    @keyword
    def turn_on_flight_mode_for_ios(self) -> str:
        """
        Turns on Flight Mode (Airplane Mode) on an iOS device using system preferences.

        Input Parameters:
            - None

        Output:
            - str - "enabled" if airplane mode was successfully turned on, otherwise "disabled".

        Error Handling:
            - Raises Exception if enabling flight mode fails due to element lookup failure, system delays, or UI issues.

        Examples:
        | ${status}= | Flight Mode On iOS |
        | Log        | Flight mode status is ${status} |
        """
        try:
            return self.iostestlibrary.airplane_mode_on_ios()
        except Exception as e:
            raise Exception(f"Failed to enable airplane mode: {str(e)}") from e

    @keyword
    def turn_on_bluetooth_for_ios(self) -> str:
        """
        Enables Bluetooth on an iOS device via system preferences.

        Input Parameters:
            - None

        Output:
            - str - "enabled" if Bluetooth is turned on or already enabled, otherwise "disabled".

        Error Handling:
            - Raises Exception if there is a failure in interacting with the mobile driver or finding the Bluetooth option.

        Examples:
        | ${status}= | Toggle Bluetooth On iOS |
        | Log | Bluetooth status is ${status} |
        """
        try:
            return self.iostestlibrary.toggle_bluetooth_on_iOS()
        except Exception as e:
            raise Exception(f"Failed to enable Bluetooth: {str(e)}") from e

    @keyword
    def turn_off_bluetooth_for_ios(self) -> str:
        """
        Disables Bluetooth on an iOS device via system preferences.

        Input Parameters:
            - None

        Output:
            - str - "disabled" if Bluetooth is turned off or already disabled, otherwise "enabled".

        Error Handling:
            - Raises Exception if there is a failure in interacting with the mobile driver or finding the Bluetooth option.

        Examples:
        | ${status}= | Toggle Bluetooth Off iOS |
        | Log | Bluetooth status is ${status} |
        """
        try:
            return self.iostestlibrary.toggle_bluetooth_off_iOS()
        except Exception as e:
            raise Exception(f"Failed to disable Bluetooth: {str(e)}") from e

    @keyword
    def unpair_bluetooth_device_iOS(self, controller_name: str) -> None:
        """
        Unpairs (forgets) a specified Bluetooth device from the iOS device's Bluetooth settings.

        Input Parameters:
            - controller_name: str - The exact name of the Bluetooth device to unpair. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if there is a failure interacting with the mobile driver or finding the Bluetooth device.

        Examples:
        | Unpair Bluetooth Device iOS | IOS Watch |
        | Unpair Bluetooth Device iOS | My Bluetooth Headset |
        """
        try:
            return self.iostestlibrary.unpair_bluetooth_device_iOS(controller_name)
        except Exception as e:
            raise Exception(f"Failed to unpair Bluetooth device '{controller_name}': {str(e)}") from e

    @keyword
    def handle_alerts_except_bluetooth(self, pin: str) -> None:
        """
        Handles all iOS system alerts except Bluetooth pairing requests, which it handles by entering the provided PIN.

        Input Parameters:
            - pin: str - The PIN to enter when a Bluetooth Pairing Request alert is encountered. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception for any unexpected errors while handling alerts.

        Examples:
        | Handle Alerts Except Bluetooth | 123456 |
        """
        try:
            return self.iostestlibrary.handle_alerts_except_bluetooth(pin)
        except Exception as e:
            raise Exception(f"Failed to handle alerts except Bluetooth pairing: {str(e)}") from e

    @keyword
    def handle_bluetooth_pairing_request_iOS(self, pin: Optional[str] = None) -> None:
        """
        Handles the Bluetooth pairing request alert on an iOS device by entering the provided PIN and confirming the pairing.

        Input Parameters:
            - pin: str - The PIN code to enter for pairing. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if the PIN entry field or Pair button is not found or if there is a driver-related error.

        Examples:
        | Handle Bluetooth Pairing Request iOS | 123456 |
        | Handle Bluetooth Pairing Request iOS | None |
        """
        try:
            return self.iostestlibrary.handle_bluetooth_pairing_request_iOS(pin)
        except Exception as e:
            raise Exception(f"Failed to handle Bluetooth pairing request: {str(e)}") from e

    @keyword
    def toggle_bluetooth_iOS(self) -> bool:
        """
        Toggles the Bluetooth state on an iOS device by opening the Control Center and clicking the Bluetooth toggle switch.

        Input Parameters:
            - None

        Output:
            - bool - True if the toggle action was performed successfully, False otherwise.

        Error Handling:
            - Raises Exception if an error occurs while opening the Control Center or toggling Bluetooth.

        Examples:
        | ${result}= | Toggle Bluetooth iOS |
        | Run Keyword If | '${result}' == 'False' | Log | Failed to toggle Bluetooth |
        """
        try:
            return self.iostestlibrary.toggle_bluetooth_iOS()
        except Exception as e:
            raise Exception(f"Failed to toggle Bluetooth via Control Center: {str(e)}") from e

    @keyword
    def tap_unpair(self, locator: str) -> bool:
        """
        Taps on the 'Unpair' button identified by the given locator in the iOS Bluetooth settings.

        Input Parameters:
            - locator: str - The locator string to find the 'Unpair' button using IOS_CLASS_CHAIN. Required.

        Output:
            - bool - True if the unpair button was found and clicked, False otherwise.

        Error Handling:
            - Raises Exception for any unexpected errors during locating or clicking the button.

        Examples:
        | ${success}= | Tap Unpair | **/XCUIElementTypeButton[`name == 'Unpair'`] |
        | Run Keyword If | '${success}' == 'False' | Log | Failed to tap unpair button |
        """
        try:
            return self.iostestlibrary.tap_unpair(locator)
        except Exception as e:
            raise Exception(f"Failed to tap unpair button: {str(e)}") from e

    @keyword
    def unlock_ios_device(self, passcode: Optional[str] = None) -> None:
        """
        Unlocks an iOS device by waking the screen, swiping up, and entering the device passcode if required.

        Input Parameters:
            - passcode: str - The device passcode as a string of digits (e.g., "1234"). Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if any passcode digit button is not found or for other errors during unlocking.

        Examples:
        | Unlock iOS Device | 1234 |
        | Unlock iOS Device |
        """
        try:
            return self.iostestlibrary.unlock_ios_device(passcode)
        except Exception as e:
            raise Exception(f"Failed to unlock iOS device: {str(e)}") from e

    @keyword
    def get_ios_battery_life(self) -> Union[int, str]:
        """
        Retrieves the current battery level percentage of the connected iOS device.

        Input Parameters:
            - None

        Output:
            - Union[int, str] - Battery percentage as an integer (e.g., 85), or a string message if battery info is unavailable.

        Error Handling:
            - Raises Exception if an error occurs while retrieving battery information.

        Examples:
        | ${battery_level}= | Get iOS Battery Life |
        | Log | Current battery level is ${battery_level}% |
        """
        try:
            return self.iostestlibrary.get_ios_battery_life()
        except Exception as e:
            raise Exception(f"Failed to retrieve iOS battery life: {str(e)}") from e

    @keyword
    def start_ios_log(self, log_file_path: str) -> subprocess.Popen:
        """
        Starts capturing iOS device system logs and writes them to the specified file path.

        Input Parameters:
            - log_file_path: str - Full path where the iOS system logs should be saved. Required.

        Output:
            - subprocess.Popen - The process handle for the running idevicesyslog command.

        Error Handling:
            - Raises Exception if the `idevicesyslog` executable is not found or for other errors during log capturing.

        Examples:
        | ${process}= | Start iOS Log | /tmp/ios_logs.txt |
        | # Do some operations |
        | Stop iOS Log | ${process} |
        """
        try:
            return self.iostestlibrary.start_ios_log(log_file_path)
        except Exception as e:
            raise Exception(f"Failed to start iOS log capture: {str(e)}") from e

    @keyword
    def stop_ios_log(self, syslog_process: subprocess.Popen) -> None:
        """
        Stops the running iOS system log capture process.

        Input Parameters:
            - syslog_process: subprocess.Popen - The process handle returned by Start iOS Log. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if an error occurs when stopping the log process.

        Examples:
        | ${process}= | Start iOS Log | /tmp/ios_logs.txt |
        | Stop iOS Log | ${process} |
        """
        try:
            return self.iostestlibrary.stop_ios_log(syslog_process)
        except Exception as e:
            raise Exception(f"Failed to stop iOS log capture: {str(e)}") from e

    @keyword
    def lock_device(self, duration: Optional[int] = None) -> None:
        """
        Locks the iOS device for a specified duration or indefinitely if no duration is given.

        Input Parameters:
            - duration: int - Number of seconds to lock the device. Optional, defaults to None (indefinite lock).

        Output:
            - None

        Error Handling:
            - Raises Exception if the device cannot be locked or if the Appium driver is not initialized.

        Examples:
        | Lock Device | 10 |   # Locks device for 10 seconds |
        | Lock Device |      # Locks device indefinitely |
        """
        try:
            return self.iostestlibrary.lock_device(duration)
        except Exception as e:
            raise Exception(f"Failed to lock the device: {str(e)}") from e

    @keyword
    def start_remote_ios_log(
        self,
        server_url: str,
        username: str,
        log_file_path: str,
        key_file: Optional[str] = None,
        password: Optional[str] = None,
        local_log_path: Optional[str] = None
    ) -> bool:
        """
        Starts capturing iOS device logs on a remote machine via SSH and initiates log writing to a specified remote path.

        Input Parameters:
            - server_url: str - The URL of the remote server (e.g., Appium server URL) from which hostname is parsed. Required.
            - username: str - Username for SSH connection on the remote machine. Required.
            - log_file_path: str - Full file path on the remote machine to save the iOS logs. Required.
            - key_file: str - Path to the SSH private key file. Optional, defaults to None.
            - password: str - Password for SSH authentication. Optional, defaults to None.
            - local_log_path: str - Local path to save logs after transfer. Optional, defaults to None.

        Output:
            - bool - True if the log capture was successfully started on the remote machine.

        Error Handling:
            - Raises Exception for SSH connection-related errors or other unexpected errors during the remote log capture start.

        Examples:
        | Start Remote iOS Log | http://192.168.1.10:4723 | user | /Users/user/ios_logs.txt | key_file=/path/to/key |
        """
        try:
            return self.iostestlibrary.start_remote_ios_log(
                server_url, username, log_file_path, key_file=key_file, password=password, local_log_path=local_log_path
            )
        except Exception as e:
            raise Exception(f"Failed to start remote iOS log capture: {str(e)}") from e

    @keyword
    def stop_remote_ios_log(
        self,
        server_url: str,
        username: str,
        remote_log_path: str,
        key_file: Optional[str] = None,
        password: Optional[str] = None,
        local_log_path: Optional[str] = None
    ) -> None:
        """
        Stops the iOS log capture process on a remote machine via SSH and optionally transfers logs to the local machine.

        Input Parameters:
            - server_url: str - The URL of the remote server (e.g., Appium server URL) from which hostname is parsed. Required.
            - username: str - Username for SSH connection on the remote machine. Required.
            - remote_log_path: str - Path of the log file on the remote machine. Required.
            - key_file: str - Path to the SSH private key file. Optional, defaults to None.
            - password: str - Password for SSH authentication. Optional, defaults to None.
            - local_log_path: str - Local path to save the transferred log file. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception for SSH connection-related errors or errors stopping the log or transferring the file.

        Examples:
        | Stop Remote iOS Log | http://192.168.1.10:4723 | user | /Users/user/ios_logs.txt | local_log_path=C:/ios_logs.txt | key_file=/path/to/key |
        """
        try:
            return self.iostestlibrary.stop_remote_ios_log(
                server_url, username, remote_log_path, key_file=key_file, password=password, local_log_path=local_log_path
            )
        except Exception as e:
            raise Exception(f"Failed to stop and transfer remote iOS log capture: {str(e)}") from e

    @keyword
    def start_ios_console_log(self, log_archive_path: str, udid: Optional[str] = None) -> Tuple[str, str, str]:
        """
        Starts iOS console log collection by recording the start time and preparing
        the environment for log collection.

        Input Parameters:
            - log_archive_path: str - Path to save the .logarchive (relative or absolute). Required.
            - udid: str - iOS device name or UDID. Optional, defaults to None.

        Output:
            - Tuple[str, str, str] - (udid, start_time, absolute_log_archive_path).

        Error Handling:
            - Raises Exception if there is an error during preparation for log collection.

        Examples:
        | ${start_info}= | Start iOS Console Log | logs/console.logarchive | emulator-5554 |
        """
        try:
            return self.iostestlibrary.start_ios_console_log(log_archive_path, udid=udid)
        except Exception as e:
            raise Exception(f"Failed to start iOS console log collection: {str(e)}") from e

    @keyword
    def stop_ios_console_log(
        self,
        start_info: Tuple[str, str, str],
        log_archive_path: str,
        output_txt_path: str,
        delete_logarchive: bool = True
    ) -> None:
        """
        Stops iOS console log collection, collects logs using `log collect`, parses them into human-readable format,
        and optionally deletes the raw log archive.

        Input Parameters:
            - start_info: Tuple[str, str, str] - Tuple (udid, start_time, log_archive_path) returned from start_ios_console_log. Required.
            - log_archive_path: str - Path to the .logarchive (relative or absolute). Required.
            - output_txt_path: str - Path to save the parsed, human-readable log output. Required.
            - delete_logarchive: bool - Whether to delete the raw logarchive after parsing. Optional, defaults to True.

        Output:
            - None

        Error Handling:
            - Raises Exception if the log collection subprocess fails or for other errors during log parsing or file operations.

        Examples:
        | ${start_info}= | Start iOS Console Log | logs/console.logarchive | emulator-5554 |
        | Stop iOS Console Log | ${start_info} | logs/console.logarchive | logs/output.txt |
        """
        try:
            return self.iostestlibrary.stop_ios_console_log(start_info, log_archive_path, output_txt_path, delete_logarchive=delete_logarchive)
        except Exception as e:
            raise Exception(f"Failed to stop iOS console log collection: {str(e)}") from e

    @keyword
    def disable_Wifi_on_ios(self) -> str:
        """
        Disables Wi-Fi on the iOS device via the Settings app.

        Input Parameters:
            - None

        Output:
            - str - "disabled" if Wi-Fi was successfully turned off, "enabled" otherwise.

        Error Handling:
            - Raises Exception if there is an error interacting with the Wi-Fi toggle.

        Examples:
        | ${status}= | Disable Wifi On iOS |
        | Log | Wi-Fi status is ${status} |
        """
        try:
            return self.iostestlibrary.disable_Wifi_on_ios()
        except Exception as e:
            raise Exception(f"Failed to disable Wi-Fi on iOS device: {str(e)}") from e

    @keyword
    def enable_Wifi_on_ios(self) -> str:
        """
        Enables Wi-Fi on the iOS device via the Settings app.

        Input Parameters:
            - None

        Output:
            - str - "enabled" if Wi-Fi was successfully turned on, "disabled" otherwise.

        Error Handling:
            - Raises Exception if there is an error interacting with the Wi-Fi toggle.

        Examples:
        | ${status}= | Enable Wifi On iOS |
        | Log | Wi-Fi status is ${status} |
        """
        try:
            return self.iostestlibrary.enable_Wifi_on_ios()
        except Exception as e:
            raise Exception(f"Failed to enable Wi-Fi on iOS device: {str(e)}") from e