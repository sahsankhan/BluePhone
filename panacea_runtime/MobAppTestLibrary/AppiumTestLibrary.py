from typing import Optional, Union
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword

@library
class AppiumTestLibrary:
    """A MobAppTestLibrary library for managing Appium service operations.

    This library provides keywords to start and stop an Appium server instance,
    leveraging the `MobAppTestLibrary` module for core functionality.
    It is designed to be used in automated testing workflows that require
    Appium server management.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the AppiumTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.appiumtestlibrary = mob

    @keyword
    def start_appium_service(self, appiumLogFolderPath: str = "", server_url: str = "http://127.0.0.1:4723") -> str:
        """Start the Appium service with the specified log folder path and server URL.

        Input Parameters:
            - appiumLogFolderPath: str - The directory path where Appium logs will be stored. Optional, defaults to an empty string.
            - server_url: str - The URL for the Appium server (e.g., 'http://127.0.0.1:4723'). Optional, defaults to 'http://127.0.0.1:4723'.

        Output:
            - str - The URL of the running Appium server (e.g., 'http://127.0.0.1:4723').

        Error Handling:
            - Raises Exception if the Appium service fails to start or if invalid parameters are provided.

        Examples:
        | Start Appium Service | log_path=ZmxAppiumTestLibrary | server_url=http://127.0.0.1:4553 |
        | Start Appium Service | log_path=C:/Logs/Appium |  # Uses default server_url |
        """
        try:
            return self.appiumtestlibrary.start_appium_service(appiumLogFolderPath, server_url)
        except Exception as e:
            raise Exception(f"Failed to start Appium service: {str(e)}") from e

    @keyword
    def stop_appium_service(self, appium_url) -> None:
        """
        Stop the currently running Appium service.
        This keyword stops the Appium server if it is active. If no service is running,
        it will log a message indicating no action was taken.

        Input Parameters:
            - appium_url(str, optional): Appium server URL

        Output:
            - None

        Error Handling:
            - Raises Exception if the Appium service fails to stop.

        Examples:
        | Stop Appium Service |
        """
        try:
            return self.appiumtestlibrary.stop_appium_service(appium_url)
        except Exception as e:
            raise Exception(f"Failed to stop Appium service: {str(e)}") from e

    @keyword
    def keep_appium_session_alive(self, duration_seconds: Union[int, str], interaction_interval: int = 10) -> None:
        """
        Keeps the Appium session alive by performing periodic interactions for a specified duration.

        This keyword is useful when you want to prevent Appium from timing out due to inactivity
        during long waits or debugging sessions. It interacts with the mobile app by querying
        the current activity in a loop.

        Input Parameters:
            - duration_seconds: Union[int, str] - The total duration (in seconds) to keep the session alive. Can be a number or a string convertible to float. Required.
            - interaction_interval: int - Time (in seconds) between interactions. Optional, defaults to 10.

        Output:
            - None

        Error Handling:
            - Raises Exception if an error occurs while interacting with the session.

        Examples:
        | Keep Appium Session Alive | 60              | 10  |
        | Keep Appium Session Alive | duration=120.0  | interaction_interval=15 |
        | Keep Appium Session Alive | '30'            |     |  # Defaults to 10s interval |
        """
        try:
            return self.appiumtestlibrary.keep_appium_session_alive(duration_seconds, interaction_interval)
        except Exception as e:
            raise Exception(f"Failed to keep Appium session alive: {str(e)}") from e

    @keyword
    def stop_remote_appium_service_iOS(self, appium_url: str, username: str, key_file: Optional[str] = None, password: Optional[str] = None, local_log_path: Optional[str] = None, remote_log_path: Optional[str] = None) -> None:
        """
        Stops the Appium service running on a remote macOS machine via SSH and transfers logs to the local system.

        This keyword wraps the internal stop_remote_appium_service_iOS method to manage the Appium service
        on a remote iOS environment, handling SSH connections and log transfers.

        Input Parameters:
            - appium_url: str - The URL of the Appium service (e.g., 'http://remote_host:4723'). Required.
            - username: str - Username for the remote SSH connection. Required.
            - key_file: str - Path to the SSH private key file. Optional, defaults to None.
            - password: str - SSH password. Optional, defaults to None.
            - local_log_path: str - Path to save the log file on the local machine. Optional, defaults to None.
            - remote_log_path: str - Path of the log file on the remote machine. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if the Appium service fails to stop or if SSH/log transfer operations fail.

        Examples:
        | Stop Remote Appium Service iOS | http://remote_host:4723 | user1 | key_file=/path/to/key.pem | local_log_path=C:/Logs/appium.log | remote_log_path=/var/log/appium.log |
        | Stop Remote Appium Service iOS | http://remote_host:4723 | user1 | password=pass123 |
        """
        try:
            return self.appiumtestlibrary.stop_remote_appium_service_iOS(appium_url, username, key_file, password, local_log_path, remote_log_path)
        except Exception as e:
            raise Exception(f"Failed to stop remote Appium service on iOS: {str(e)}") from e

    @keyword
    def start_remote_appium_service_iOS(self, appium_url: str, username: str, log_file_path: str, key_file: Optional[str] = None, password: Optional[str] = None, local_log_path: Optional[str] = None) -> str:
        """
        Starts the Appium service on a remote macOS machine via SSH and transfers logs to the local system after a delay.

        This keyword wraps the internal start_remote_appium_service_iOS method to initiate the Appium service
        on a remote iOS environment, handling SSH connections and log transfers.

        Input Parameters:
            - appium_url: str - The URL of the Appium service (e.g., 'http://remote_host:4723'). Required.
            - username: str - Username for the remote SSH connection. Required.
            - log_file_path: str - Path of the log file on the remote machine. Required.
            - key_file: str - Path to the SSH private key file. Optional, defaults to None.
            - password: str - SSH password. Optional, defaults to None.
            - local_log_path: str - Path to save the log file on the local machine. Optional, defaults to None.

        Output:
            - str - The URL of the started Appium server (e.g., 'http://remote_host:4723').

        Error Handling:
            - Raises Exception if the Appium service fails to start or if SSH/log transfer operations fail.

        Examples:
        | ${url}= | Start Remote Appium Service iOS | http://remote_host:4723 | user1 | /var/log/appium.log | key_file=/path/to/key.pem | local_log_path=C:/Logs/appium.log |
        | Start Remote Appium Service iOS | http://remote_host:4723 | user1 | /var/log/appium.log | password=pass123 |
        """
        try:
            return self.appiumtestlibrary.start_remote_appium_service_iOS(appium_url, username, log_file_path, key_file, password, local_log_path)
        except Exception as e:
            raise Exception(f"Failed to start remote Appium service on iOS: {str(e)}") from e

    @keyword
    def start_remote_appium_service_android(self, appium_url: str, username: str, log_file_path: str, key_file: Optional[str] = None, password: Optional[str] = None, local_log_path: Optional[str] = None) -> str:
        """
        Starts the Appium service on a remote Windows machine via SSH and transfers logs to the local system after a delay.

        This keyword wraps the internal start_remote_appium_service_android method to initiate the Appium service
        on a remote Android environment, handling SSH connections and log transfers.

        Input Parameters:
            - appium_url: str - The URL of the Appium service (e.g., 'http://remote_host:4723'). Required.
            - username: str - Username for the remote SSH connection. Required.
            - log_file_path: str - Path of the log file on the remote machine. Required.
            - key_file: str - Path to the SSH private key file. Optional, defaults to None.
            - password: str - SSH password. Optional, defaults to None.
            - local_log_path: str - Path to save the log file on the local machine. Optional, defaults to None.

        Output:
            - str - The URL of the started Appium server (e.g., 'http://remote_host:4723').

        Error Handling:
            - Raises Exception if the Appium service fails to start or if SSH/log transfer operations fail.

        Examples:
        | ${url}= | Start Remote Appium Service Android | http://remote_host:4723 | user1 | C:/Logs/appium.log | key_file=/path/to/key.pem | local_log_path=C:/LocalLogs/appium.log |
        | Start Remote Appium Service Android | http://remote_host:4723 | user1 | C:/Logs/appium.log | password=pass123 |
        """
        try:
            return self.appiumtestlibrary.start_remote_appium_service_android(appium_url, username, log_file_path, key_file, password, local_log_path)
        except Exception as e:
            raise Exception(f"Failed to start remote Appium service on Android: {str(e)}") from e

    @keyword
    def stop_remote_appium_service_android(self, appium_url: str, username: str, key_file: Optional[str] = None, password: Optional[str] = None, local_log_path: Optional[str] = None, remote_log_path: Optional[str] = None) -> None:
        """
        Stops the Appium service running on a remote Windows machine via SSH and transfers logs to the local system.

        This keyword wraps the internal stop_remote_appium_service_android method to manage the Appium service
        on a remote Android environment, handling SSH connections and log transfers.

        Input Parameters:
            - appium_url: str - The URL of the Appium service (e.g., 'http://remote_host:4723'). Required.
            - username: str - Username for the remote SSH connection. Required.
            - key_file: str - Path to the SSH private key file. Optional, defaults to None.
            - password: str - SSH password. Optional, defaults to None.
            - local_log_path: str - Path to save the log file on the local machine. Optional, defaults to None.
            - remote_log_path: str - Path of the log file on the remote machine. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if the Appium service fails to stop or if SSH/log transfer operations fail.

        Examples:
        | Stop Remote Appium Service Android | http://remote_host:4723 | user1 | key_file=/path/to/key.pem | local_log_path=C:/Logs/appium.log | remote_log_path=C:/RemoteLogs/appium.log |
        | Stop Remote Appium Service Android | http://remote_host:4723 | user1 | password=pass123 |
        """
        try:
            return self.appiumtestlibrary.stop_remote_appium_service_android(appium_url, username, key_file, password, local_log_path, remote_log_path)
        except Exception as e:
            raise Exception(f"Failed to stop remote Appium service on Android: {str(e)}") from e