from typing import Optional, Union, Any
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from selenium.webdriver.remote.webelement import WebElement
from selenium.common.exceptions import TimeoutException
from robot.api.deco import library, keyword
from subprocess import Popen
from pathlib import Path
from paramiko import SSHClient

@library
class AndroidTestLibrary:
    """A MobAppTestLibrary library for managing Android utilities and system settings.

    This library provides keywords to interact with Android features such as
    toggling Bluetooth, Wi-Fi, or flight mode.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the AndroidTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.androidtestlibrary = mob

    @keyword
    def start_adb_log(self, udid: str, log_file_path: str, log_level: str) -> Popen:
        """
        Starts capturing ADB logs for the specified device, filtering only error logs,
        and writes them to the specified log file.

        Input Parameters:
            - udid: str - The UDID of the device from which to capture logs. Required.
            - log_file_path: str - The full file path where the ADB logs will be saved. Required.
            - log_level: str - Type of logs to capture. Defaults to "all". 

        Output:
            - Popen - The process handle of the ADB logcat process.

        Error Handling:
            - Raises Exception for any other unexpected errors during log capture startup.

        Examples:
        | Start Adb Log | 1234567890abcdef | /path/to/logs/device_errors.log |
        """
        try:
            return self.androidtestlibrary.start_adb_log(udid, log_file_path, log_level)
        except Exception as e:
            raise Exception(f"Failed to start ADB log capture: {str(e)}") from e

    @keyword
    def stop_adb_log(self, adb_process: Popen) -> None:
        """
        Stops the ADB logcat process.

        Input Parameters:
            - adb_process: Popen - The process handle for the ADB logcat process. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if stopping the ADB log capture process fails.

        Examples:
        | Stop Adb Log | ${adb_process} |
        """
        try:
            return self.androidtestlibrary.stop_adb_log(adb_process)
        except Exception as e:
            raise Exception(f"Failed to stop ADB log capture: {str(e)}") from e

    @keyword
    def toggle_bluetooth_for_android(self, device_name: str, turn_on: bool = False) -> str:
        """
        Toggles the Bluetooth setting ON or OFF on the specified Android device.

        This keyword attempts to navigate to the Bluetooth settings screen and
        click the toggle switch to either enable or disable Bluetooth. It supports
        device-specific UI logic for Pixel, Samsung, and Xiaomi/Redmi devices.

        Input Parameters:
            - device_name: str - The name of the Android device (e.g., "Pixel 7", "Samsung Galaxy S21", "Redmi Note 10"). Required.
            - turn_on: bool - Set to True to enable Bluetooth, or False to disable it. Defaults to False.

        Output:
            - str - "enabled" if Bluetooth is turned on after the action, "disabled" if it's turned off.

        Error Handling:
            - Raises Exception for any other unexpected error during the toggle operation.

        Examples:
        | Toggle Bluetooth | Pixel 7            | turn_on=True  |
        | Toggle Bluetooth | Samsung Galaxy S21 | turn_on=False |
        | Toggle Bluetooth | Redmi Note 10      | turn_on=True  |
        """
        try:
            return self.androidtestlibrary.toggle_bluetooth(device_name, turn_on=turn_on)
        except Exception as e:
            raise Exception(f"Failed to toggle Bluetooth: {str(e)}") from e

    @keyword
    def turn_on_flight_mode_for_android(self, device_name: str) -> str:
        """
        Enables (turns ON) Flight Mode for the specified Android device by interacting
        with the system's notification shade toggle.

        This keyword is designed to handle different Android OEMs (e.g., Pixel, Samsung, Xiaomi)
        by trying multiple selectors based on the device type. It opens the notification shade,
        locates the Flight Mode (Airplane Mode) toggle, and clicks it to enable flight mode.

        Input Parameters:
            - device_name: str - The name of the Android device (e.g., "Pixel 7", "Samsung Galaxy S21", "Redmi Note 10"). Required.

        Output:
            - str - "enabled" if flight mode was successfully turned on, "disabled" otherwise.

        Error Handling:
            - Raises Exception if the flight mode toggle cannot be found or if a StaleElementReferenceException occurs during click attempts.

        Examples:
        | Flight Mode On | Pixel 7 |
        | Flight Mode On | Samsung Galaxy S21 |
        | Flight Mode On | Redmi Note 10 |
        """
        try:
            return self.androidtestlibrary.flight_mode_on(device_name)
        except Exception as e:
            raise Exception(f"Failed to enable Flight Mode: {str(e)}") from e

    @keyword
    def turn_off_flight_mode_for_android(self, device_name: str) -> str:
        """
        Disables (turns OFF) Flight Mode for the specified Android device by interacting
        with the system's notification shade toggle.

        This keyword supports multiple Android OEMs (e.g., Pixel, Samsung, Xiaomi),
        attempting several element locators depending on the device type. It opens
        the notification panel, finds the toggle, and clicks it to disable flight mode.

        Input Parameters:
            - device_name: str - The name of the Android device (e.g., "Pixel 7", "Samsung Galaxy S21", "Redmi Note 10"). Required.

        Output:
            - str - "disabled" if flight mode was successfully turned off, "enabled" otherwise.

        Error Handling:
            - Raises Exception if the flight mode toggle cannot be located or if a StaleElementReferenceException occurs while clicking.

        Examples:
        | Flight Mode Off | Pixel 7 |
        | Flight Mode Off | Samsung Galaxy S21 |
        | Flight Mode Off | Redmi Note 10 |
        """
        try:
            return self.androidtestlibrary.flight_mode_off(device_name)
        except Exception as e:
            raise Exception(f"Failed to disable Flight Mode: {str(e)}") from e

    @keyword
    def unlock_android_device(self, passcode: Optional[str] = None) -> None:
        """
        Unlocks an Android device using the provided passcode, if locked.

        This keyword checks if the screen is on and the device is locked, and if so,
        attempts to unlock it. If a passcode is provided, it enters the digits and confirms
        with the OK button.

        Input Parameters:
            - passcode: str - The numeric passcode to unlock the device. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if the unlock process fails, e.g., due to UI changes or missing elements.

        Examples:
        | Unlock Android Device |
        | Unlock Android Device | 1234 |
        """
        try:
            return self.androidtestlibrary.unlock_android_device(passcode)
        except Exception as e:
            raise Exception(f"Failed to unlock Android device: {str(e)}") from e


    @keyword
    def open_android_activity(self, package: str, activity: str, device_id: Optional[str] = None) -> bool:
        """
        Launch an Android activity on the specified device.

        Input Parameters:
            - package: str - The package name of the Android application (e.g., 'com.example.app'). Required.
            - activity: str - The activity name to launch (e.g., '.MainActivity'). Required.
            - device_id: str - The UDID or device address (e.g., '192.168.0.130:5555'). Optional, defaults to None.

        Output:
            - bool - True if the activity was launched successfully, False if it was brought to the front or failed.

        Error Handling:
            - Raises Exception if launching the activity fails.

        Examples:
        | Open Android Activity | com.example.app | .MainActivity | 192.168.0.130:5555 |
        """
        try:
            return self.androidtestlibrary.open_android_activity(package, activity, device_id)
        except Exception as e:
            raise Exception(f"Failed to launch activity {package}/{activity}: {str(e)}") from e

    @keyword
    def open_notifications(self) -> None:
        """
        Opens and expands an Android device's notification drawer.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if opening the notification drawer fails due to driver issues or device state.

        Examples:
        | Open Notifications |
        """
        try:
            return self.androidtestlibrary.open_notifications()
        except Exception as e:
            raise Exception(f"Failed to open notifications: {str(e)}") from e

    @keyword
    def clear_notifications(self, timeout: int = 10) -> None:
        """
        Clears all notifications from the Android device's notification drawer.
        Closes the notification drawer if there are no notifications.

        Input Parameters:
            - timeout: int - Maximum time to wait for the "Clear" button to appear (in seconds). Defaults to 10.

        Output:
            - None

        Error Handling:
            - Raises Exception for any other unexpected errors during notification clearing.

        Examples:
        | Clear Notifications |
        | Clear Notifications | timeout=15 |
        """
        try:
            return self.androidtestlibrary.clear_notifications(timeout)
        except Exception as e:
            raise Exception(f"Failed to clear notifications: {str(e)}") from e

    @keyword
    def open_notifications_and_wait_for_text(self, notification_text: str, timeout: int = 10) -> Union[WebElement, bool]:
        """
        Opens the Android device's notification drawer and waits for a notification with specific text.

        Input Parameters:
            - notification_text: str - The text of the notification to wait for. Required.
            - timeout: int - Maximum time to wait for the notification (in seconds). Defaults to 10.

        Output:
            - Union[WebElement, bool] - The notification element if the text is found and clicked, otherwise False.

        Error Handling:
            - Raises Exception if opening the notification drawer or interacting with elements fails.

        Examples:
        | Open Notifications And Wait For Text | New Message |
        | Open Notifications And Wait For Text | Alert | timeout=15 |
        """
        try:
            return self.androidtestlibrary.open_notifications_and_wait_for_text(notification_text, timeout)
        except Exception as e:
            raise Exception(f"Failed to open notifications and wait for text '{notification_text}': {str(e)}") from e

    @keyword
    def get_network_connection_status(self) -> int:
        """
        Returns an integer bitmask specifying the network connection type.

        Input Parameters:
            - None

        Output:
            - int - Bitmask representing the network connection status (0=None, 1=Airplane Mode, 2=Wifi only, 4=Data only, 6=All network on).

        Error Handling:
            - Raises Exception if retrieving the network connection status fails.

        Examples:
        | ${status}= | Get Network Connection Status |
        """
        try:
            return self.androidtestlibrary.get_network_connection_status()
        except Exception as e:
            raise Exception(f"Failed to get network connection status: {str(e)}") from e

    @keyword
    def set_network_connection_status(self, connection_status: int) -> bool:
        """
        Sets the network connection status.

        Possible values:
            | =Value= | =Alias=          | =Data= | =Wifi= | =Airplane Mode= |
            |  0      | (None)           | 0      |   0    | 0               |
            |  1      | (Airplane Mode)  | 0      |   0    | 1               |
            |  2      | (Wifi only)      | 0      |   1    | 0               |
            |  4      | (Data only)      | 1      |   0    | 0               |
            |  6      | (All network on) | 1      |   1    | 0               |

        Input Parameters:
            - connection_status: int - Integer bitmask to set the network connection status. Required.

        Output:
            - bool - True if the network connection status was set successfully.

        Error Handling:
            - Raises Exception if setting the network connection status fails.

        Examples:
        | Set Network Connection Status | 1 |  # Enable Airplane Mode |
        | Set Network Connection Status | 6 |  # Enable All network on |
        """
        try:
            return self.androidtestlibrary.set_network_connection_status(connection_status)
        except Exception as e:
            raise Exception(f"Failed to set network connection status to {connection_status}: {str(e)}") from e

    @keyword
    def pull_file(self, path: str, decode: bool = False) -> str:
        """
        Retrieves the file at `path` and returns its content.

        Input Parameters:
            - path: str - The path to the file on the device. Required.
            - decode: bool - True/False to decode the data (base64) before returning it. Defaults to False.

        Output:
            - str - The file content as a string, decoded from base64 if decode is True.

        Error Handling:
            - Raises Exception if retrieving the file fails due to driver issues, file not found, or decoding errors.

        Examples:
        | ${content}= | Pull File | /sdcard/test.txt |
        | ${content}= | Pull File | /sdcard/test.txt | decode=True |
        """
        try:
            return self.androidtestlibrary.pull_file(path, decode=decode)
        except Exception as e:
            raise Exception(f"Failed to pull file from path '{path}': {str(e)}") from e

    @keyword
    def pull_folder(self, path: str, decode: bool = False) -> bytes:
        """
        Retrieves a folder at `path`. Returns the folder's contents zipped.

        Input Parameters:
            - path: str - The path to the folder on the device. Required.
            - decode: bool - True/False to decode the data (base64) before returning it. Defaults to False.

        Output:
            - bytes - The zipped folder content, decoded from base64 if decode is True.

        Error Handling:
            - Raises Exception if retrieving the folder fails due to driver issues, folder not found, or decoding errors.

        Examples:
        | ${zip}= | Pull Folder | /sdcard/folder |
        | ${zip}= | Pull Folder | /sdcard/folder | decode=True |
        """
        try:
            return self.androidtestlibrary.pull_folder(path, decode=decode)
        except Exception as e:
            raise Exception(f"Failed to pull folder from path '{path}': {str(e)}") from e

    @keyword
    def push_file(self, path: str, data: Any, encode: bool = False) -> None:
        """
        Puts the data in the file specified as `path`.

        Input Parameters:
            - path: str - The path on the device where the file will be written. Required.
            - data: Any - The data to be written to the file. Required.
            - encode: bool - True/False to encode the data as base64 before writing it to the file. Defaults to False.

        Output:
            - None

        Error Handling:
            - Raises Exception if pushing the file fails due to driver issues, permission errors, or encoding errors.

        Examples:
        | Push File | /sdcard/test.txt | Hello World |
        | Push File | /sdcard/test.txt | SomeData | encode=True |
        """
        try:
            return self.androidtestlibrary.push_file(path, data, encode=encode)
        except Exception as e:
            raise Exception(f"Failed to push file to path '{path}': {str(e)}") from e

    @keyword
    def delete_file(self, path: str, timeout: int = 5000, include_stderr: bool = True) -> None:
        """
        Deletes the file specified as `path`.

        Input Parameters:
            - path: str - The path to the file on the device. Required.
            - timeout: int - The timeout for the delete command in milliseconds. Defaults to 5000.
            - include_stderr: bool - Whether an exception will be thrown if the command's return code is not zero. Defaults to True.

        Output:
            - None

        Error Handling:
            - Raises Exception if the file deletion fails due to driver issues, file not found, or command execution errors.

        Examples:
        | Delete File | /sdcard/test.txt |
        | Delete File | /sdcard/test.txt | timeout=10000 | include_stderr=False |
        """
        try:
            return self.androidtestlibrary.delete_file(path, timeout=timeout, include_stderr=include_stderr)
        except Exception as e:
            raise Exception(f"Failed to delete file at path '{path}': {str(e)}") from e

    @keyword
    def get_activity(self) -> str:
        """
        Retrieves the current activity on the device.

        Input Parameters:
            - None

        Output:
            - str - The current activity name.

        Error Handling:
            - Raises Exception if retrieving the current activity fails due to driver issues.

        Examples:
        | ${activity}= | Get Activity |
        | Log | Current activity is ${activity} |
        """
        try:
            return self.androidtestlibrary.get_activity()
        except Exception as e:
            raise Exception(f"Failed to get current activity: {str(e)}") from e

    @keyword
    def start_activity(self, appPackage: str, appActivity: str, **opts: Any) -> None:
        """
        Opens an arbitrary activity during a test. If the activity belongs to
        another application, that application is started and the activity is opened.

        Input Parameters:
            - appPackage: str - The package containing the activity to start. Required.
            - appActivity: str - The activity to start. Required.
            - **opts: Any - Optional parameters including appWaitPackage, appWaitActivity, intentAction, intentCategory, intentFlags, optionalIntentArguments, dontStopAppOnReset.

        Output:
            - None

        Error Handling:
            - Raises Exception if starting the activity fails due to driver issues or invalid parameters.

        Examples:
        | Start Activity | com.example.app | .MainActivity |
        | Start Activity | com.example.app | .MainActivity | appWaitPackage=com.example.app | appWaitActivity=.MainActivity |
        """
        try:
            return self.androidtestlibrary.start_activity(appPackage, appActivity, **opts)
        except Exception as e:
            raise Exception(f"Failed to start activity {appPackage}/{appActivity}: {str(e)}") from e

    @keyword
    def wait_activity(self, activity: str, timeout: int, interval: int = 1) -> None:
        """
        Waits for an activity to present, blocking until the target activity appears or a timeout occurs.

        Input Parameters:
            - activity: str - The target activity to wait for (e.g., ".MainActivity"). Required.
            - timeout: int - The maximum wait time in seconds. Required.
            - interval: int - The sleep interval between retries in seconds. Defaults to 1.

        Output:
            - None

        Error Handling:
            - Raises TimeoutException if the target activity does not appear within the specified timeout.
            - Raises Exception if waiting for the activity fails due to driver issues.

        Examples:
        | Wait Activity | .MainActivity | 10 |
        | Wait Activity | MainActivity | 5 | interval=2 |
        """
        try:
            return self.androidtestlibrary.wait_activity(activity, timeout, interval=interval)
        except TimeoutException as e:
            current_activity = self.androidtestlibrary.get_activity()
            raise TimeoutException(f"Activity {activity} never presented, current activity: {current_activity}") from e
        except Exception as e:
            raise Exception(f"Failed to wait for activity {activity}: {str(e)}") from e

    @keyword
    def install_app(self, app_path: str, app_package: str) -> bool:
        """
        Installs an app via Appium and verifies its installation.

        Input Parameters:
            - app_path: str - The path to the app file on the local system. Required.
            - app_package: str - The package name of the app to verify installation. Required.

        Output:
            - bool - True if the app is installed successfully, False otherwise.

        Error Handling:
            - Raises Exception if the installation or verification fails due to driver issues or file errors.

        Examples:
        | ${result}= | Install App | /path/to/app.apk | com.example.app |
        | Run Keyword If | '${result}' == 'False' | Fail | App installation failed |
        """
        try:
            return self.androidtestlibrary.install_app(app_path, app_package)
        except Exception as e:
            raise Exception(f"Failed to install app from path '{app_path}': {str(e)}") from e

    @keyword
    def set_location(self, latitude: float, longitude: float, altitude: float = 10) -> None:
        """
        Sets the location on the Android device.

        Input Parameters:
            - latitude: float - The latitude coordinate. Required.
            - longitude: float - The longitude coordinate. Required.
            - altitude: float - The altitude in meters. Defaults to 10.

        Output:
            - None

        Error Handling:
            - Raises Exception if setting the location fails due to driver issues or invalid coordinates.

        Examples:
        | Set Location | 12.34 | 56.78 |
        | Set Location | 12.34 | 56.78 | altitude=20 |
        """
        try:
            return self.androidtestlibrary.set_location(latitude, longitude, altitude)
        except Exception as e:
            raise Exception(f"Failed to set location ({latitude}, {longitude}, {altitude}): {str(e)}") from e

    @keyword
    def unpair_bluetooth_device(self, paired_device_name:str, device_name:str) -> bool:
        """
        Unpairs a Bluetooth device with the specified controller name from the Android device.
 
        Supports both Samsung and Pixel devices with dynamic locators and device-specific unpairing flows.

        Input Parameters:
            - paired_device_name (str): The name of the Bluetooth device to unpair (e.g., "Apple Buds") Required.
            - device_name (str): The device model (e.g., "pixel", "samsung", "galaxy") to determine the unpairing flow Required.

        Output:
            - bool - False if the device is not found or unpairing fails, True if successful.

        Error Handling:
            - Raises Exception if unpairing fails due to driver issues, element not found, or other unexpected errors.

        Examples:
        | ${result}= | Unpair Bluetooth Device | Noise | Samsung S21
        | Run Keyword If | '${result}' == 'False' | Log | Device not found or unpairing failed |
        """
        try:
            return self.androidtestlibrary.unpair_bluetooth_device(paired_device_name, device_name)
        except Exception as e:
            raise Exception(f"Failed to unpair Bluetooth device '{paired_device_name, device_name}': {str(e)}") from e

    @keyword
    def handle_bluetooth_pairing_request(self, pin: Optional[str] = None) -> None:
        """
        Handles a Bluetooth pairing request by entering a PIN and confirming the pairing.

        Input Parameters:
            - pin: str - The PIN code to enter for pairing. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if handling the pairing request fails due to driver issues, element not found, or other errors.

        Examples:
        | Handle Bluetooth Pairing Request | 1234 |
        | Handle Bluetooth Pairing Request |
        """
        try:
            return self.androidtestlibrary.handle_bluetooth_pairing_request(pin)
        except Exception as e:
            raise Exception(f"Failed to handle Bluetooth pairing request: {str(e)}") from e

    @keyword
    def cancel_bluetooth_pairing_request(self) -> None:
        """
        Cancels a Bluetooth pairing request by clicking the cancel button on the pairing popup.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if canceling the pairing request fails due to driver issues, element not found, or other errors.

        Examples:
        | Cancel Bluetooth Pairing Request |
        """
        try:
            return self.androidtestlibrary.cancel_bluetooth_pairing_request()
        except Exception as e:
            raise Exception(f"Failed to cancel Bluetooth pairing request: {str(e)}") from e

    @keyword
    def get_battery_percentage(self, device_udid: str) -> Optional[int]:
        """
        Retrieves the battery percentage of the connected Android device specified by UDID.

        Input Parameters:
            - device_udid: str - The unique device identifier (UDID) of the Android device. Required.

        Output:
            - Optional[int] - The battery percentage (0-100) if successful, None if the command fails or data is unavailable.

        Error Handling:
            - Raises Exception if retrieving the battery percentage encounters an unexpected error.

        Examples:
        | ${battery}= | Get Battery Percentage | 1234567890abcdef |
        | Log | Battery percentage is ${battery}% |
        """
        try:
            return self.androidtestlibrary.get_battery_percentage(device_udid)
        except Exception as e:
            raise Exception(f"Failed to get battery percentage for device '{device_udid}': {str(e)}") from e

    @keyword
    def get_current_directory(self) -> Path:
        """
        Returns the directory path of the current script file.

        Input Parameters:
            - None

        Output:
            - Path - The path object representing the directory containing the script.

        Error Handling:
            - Raises Exception if retrieving the current directory fails due to an unexpected error.

        Examples:
        | ${dir}= | Get Current Directory |
        | Log | Current directory is ${dir} |
        """
        try:
            return self.androidtestlibrary.get_current_directory()
        except Exception as e:
            raise Exception(f"Failed to get current directory: {str(e)}") from e

    @keyword
    def update_meta_data(self, device_key: str, device_details_path: str, meta_data_path: str) -> dict:
        """
        Updates metadata with device-specific details from a JSON file.

        Input Parameters:
            - device_key: str - The key to identify the device in the device details JSON. Required.
            - device_details_path: str - The path to the JSON file containing device details. Required.
            - meta_data_path: str - The path to the JSON file where metadata will be updated. Required.

        Output:
            - dict - The updated metadata dictionary.

        Error Handling:
            - Raises Exception if reading/writing JSON files fails, or if the device key is not found in device details.

        Examples:
        | ${metadata}= | Update Meta Data | device1 | /path/to/device_details.json | /path/to/metadata.json |
        | Log | Updated metadata: ${metadata} |
        """
        try:
            return self.androidtestlibrary.update_meta_data(device_key, device_details_path, meta_data_path)
        except Exception as e:
            raise Exception(f"Failed to update metadata for device '{device_key}': {str(e)}") from e

    @keyword
    def stop_battery_charging(self, udid: str) -> None:
        """
        Executes an ADB command to stop battery charging for a specific device.

        Input Parameters:
            - udid: str - The unique device identifier (UDID) of the Android device. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the ADB command fails to stop battery charging.

        Examples:
        | Stop Battery Charging | 1234567890abcdef |
        """
        try:
            return self.androidtestlibrary.stop_battery_charging(udid)
        except Exception as e:
            raise Exception(f"Failed to stop battery charging for device '{udid}': {str(e)}") from e

    @keyword
    def reset_battery_status(self, udid: str) -> None:
        """
        Resets the battery status to its default state for a specific device using an ADB command.

        Input Parameters:
            - udid: str - The unique device identifier (UDID) of the Android device. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the ADB command fails to reset the battery status.

        Examples:
        | Reset Battery Status | 1234567890abcdef |
        """
        try:
            return self.androidtestlibrary.reset_battery_status(udid)
        except Exception as e:
            raise Exception(f"Failed to reset battery status for device '{udid}': {str(e)}") from e

    @keyword
    def get_wifi_status(self) -> Optional[str]:
        """
        Retrieves the Wi-Fi status of the connected Android device.

        Input Parameters:
            - None

        Output:
            - Optional[str] - "enabled" if Wi-Fi is enabled, "disabled" if Wi-Fi is disabled, None if status cannot be determined.

        Error Handling:
            - Raises Exception if retrieving the Wi-Fi status fails due to an unexpected error.

        Examples:
        | ${status}= | Get Wifi Status |
        | Run Keyword If | '${status}' == 'None' | Log | Failed to determine Wi-Fi status |
        | Log | Wi-Fi status is ${status} |
        """
        try:
            return self.androidtestlibrary.get_wifi_status()
        except Exception as e:
            raise Exception(f"Failed to get Wi-Fi status: {str(e)}") from e

    @keyword
    def turn_on_screen(self) -> None:
        """
        Turns on the screen of the connected Android device using an ADB command.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if the screen turn-on operation fails due to an ADB command error.

        Examples:
        | Turn On Screen |
        """
        try:
            return self.androidtestlibrary.turn_on_screen()
        except Exception as e:
            raise Exception(f"Failed to turn on screen: {str(e)}") from e

    @keyword
    def start_remote_adb_log(self, appium_url: str, username: str, udid: str, remote_log_file_path: str, local_report_dir: str, key_file: Optional[str] = None, password: Optional[str] = None) -> SSHClient:
        """
        Starts remote ADB log capture for a specified device on a remote host via SSH.

        Input Parameters:
            - appium_url: str - The Appium server URL (e.g., 'http://remote_host:4723') to parse the hostname. Required.
            - username: str - The SSH username for the remote host. Required.
            - udid: str - The unique device identifier (UDID) of the Android device. Required.
            - remote_log_file_path: str - The path on the remote host where logs will be saved. Required.
            - local_report_dir: str - The local directory to store the transferred log file. Required.
            - key_file: str - Path to the SSH key file for authentication. Optional, defaults to None.
            - password: str - SSH password if key_file is not used. Optional, defaults to None.

        Output:
            - SSHClient - The SSH client instance used for the connection.

        Error Handling:
            - Raises Exception for other unexpected errors during log capture startup.

        Examples:
        | ${ssh}= | Start Remote Adb Log | http://remote_host:4723 | user | 1234567890abcdef | /remote/logs/logcat.txt | /local/reports |
        | Log | Log capture started with SSH: ${ssh} |
        """
        try:
            return self.androidtestlibrary.start_remote_adb_log(appium_url, username, udid, remote_log_file_path, local_report_dir, key_file, password)
        except Exception as e:
            raise Exception(f"Failed to start remote ADB log for device '{udid}': {str(e)}") from e

    @keyword
    def stop_remote_adb_log(self, appium_url: str, username: str, udid: str, remote_log_file_path: str, local_report_dir: str, key_file: Optional[str] = None, password: Optional[str] = None) -> None:
        """
        Stops remote ADB log capture and transfers the log file to the local directory.

        Input Parameters:
            - appium_url: str - The Appium server URL (e.g., 'http://remote_host:4723') to parse the hostname. Required.
            - username: str - The SSH username for the remote host. Required.
            - udid: str - The unique device identifier (UDID) of the Android device. Required.
            - remote_log_file_path: str - The path on the remote host where logs are saved. Required.
            - local_report_dir: str - The local directory to store the transferred log file. Required.
            - key_file: str - Path to the SSH key file for authentication. Optional, defaults to None.
            - password: str - SSH password if key_file is not used. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors during log capture stop or file transfer.

        Examples:
        | Stop Remote Adb Log | http://remote_host:4723 | user | 1234567890abcdef | /remote/logs/logcat.txt | /local/reports |
        """
        try:
            return self.androidtestlibrary.stop_remote_adb_log(appium_url, username, udid, remote_log_file_path, local_report_dir, key_file, password)
        except Exception as e:
            raise Exception(f"Failed to stop remote ADB log for device '{udid}': {str(e)}") from e

    @keyword
    def handle_android_popup(self, text: str, input_text: Optional[str] = None) -> None:
        """
        Handles any Android popup based on the provided text, with optional input.

        Input Parameters:
            - text: str - The text of the element to interact with (e.g., button text like "OK" or "Cancel"). Required.
            - input_text: str - Optional text to input into a field (e.g., PIN or other input). Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if handling the popup fails due to driver issues, element not found, or other errors.

        Examples:
        | Handle Android Popup | OK |
        | Handle Android Popup | Confirm | input_text=1234 |
        """
        try:
            return self.androidtestlibrary.handle_android_popup(text, input_text)
        except Exception as e:
            raise Exception(f"Failed to handle Android popup with text '{text}': {str(e)}") from e

    @keyword
    def get_current_epoch_time(self) -> int:
        """
        Retrieves the current time as an epoch timestamp.

        Input Parameters:
            - None

        Output:
            - int - The current epoch time in seconds since January 1, 1970 (UTC).

        Error Handling:
            - Raises Exception if retrieving the epoch time fails due to an unexpected error.

        Examples:
        | ${epoch}= | Get Current Epoch Time |
        | Log | Current epoch time is ${epoch} |
        """
        try:
            return self.androidtestlibrary.get_current_epoch_time()
        except Exception as e:
            raise Exception(f"Failed to get current epoch time: {str(e)}") from e

    @keyword
    def set_sound_mode(self, mode: str) -> None:
        """
        Sets the sound mode on the Android device.

        Input Parameters:
            - mode: str - The sound mode to set ("silent", "vibrate", "normal"). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if setting the sound mode fails due to driver issues.

        Examples:
        | Set Sound Mode | silent |
        | Set Sound Mode | vibrate |
        | Set Sound Mode | normal |
        """
        try:
            return self.androidtestlibrary.set_sound_mode(mode)
        except Exception as e:
            raise Exception(f"Failed to set sound mode to '{mode}': {str(e)}") from e

    @keyword
    def verify_opened_pdf_name(self, expected_pdf_name: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the opened PDF file name matches the expected name.

        Input Parameters:
            - expected_pdf_name: str - The expected name of the PDF file. Required.
            - loglevel: str - The log level for logging the result ('INFO', 'DEBUG', etc.). Defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception if retrieving the PDF path or logging fails due to an unexpected error.

        Examples:
        | Verify Opened Pdf Name | document.pdf |
        | Verify Opened Pdf Name | report.pdf | loglevel=DEBUG |
        """
        try:
            self.androidtestlibrary.verify_opened_pdf_name(expected_pdf_name, loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify opened PDF name '{expected_pdf_name}': {str(e)}") from e

    @keyword
    def press_device_back_button(self, udid: str) -> None:
        """
        Presses the device's back button using an ADB shell command for a specific device.

        Input Parameters:
            - udid: str - The UDID of the target Android device. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if pressing the back button encounters an unexpected error.

        Examples:
        | Press Device Back Button | 1234567890abcdef |
        """
        try:
            self.androidtestlibrary.press_device_back_button(udid)
        except Exception as e:
            raise Exception(f"Failed to press back button on device '{udid}': {str(e)}") from e
        
    @keyword
    def adb_connect_device(self, device_address: str) -> None:
        """
        Connects to an Android device over Wi-Fi using ADB.

        Input Parameters:
            - device_address: str - The device address in <IP>:<PORT> format. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the ADB connection fails or an unexpected error occurs.

        Examples:
        | Adb Connect Device | 192.168.0.130:5555 |
        """
        try:
            self.androidtestlibrary.adb_connect_device(device_address)
        except Exception as e:
            raise Exception(f"Failed to connect to device '{device_address}' via ADB: {str(e)}") from e
