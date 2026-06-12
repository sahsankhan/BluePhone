from typing import Union, List, Dict, Optional
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword

@library
class WebDriverAgentLibrary:
    """
    The WebDriverAgentLibrary provides Robot Framework keywords for managing WebDriverAgent (WDA)
    instances on both local and remote devices, as well as synchronization-related actions.

    Use this library in iOS automation scenarios where tests need to interact with
    real devices via WebDriverAgent, including parallel execution and remote setups.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the WebDriverAgentLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.webdrivertestlibrary = mob

    @keyword
    def start_wda(
        self,
        project_path: str,
        device_names: Union[str, List[str]],
        udids: Union[str, List[str]],
        ports: Union[int, List[int]],
        log_file_path: str
    ) -> Dict[str, any]:
        """
        Wrapper to start WebDriverAgent (WDA) for multiple devices locally.

        This keyword starts WDA instances for the specified devices using provided project path,
        UDIDs, and ports. It returns a dictionary mapping device names to their process handles.

        Input Parameters:
            - project_path: str - Path to the WDA Xcode project. Required.
            - device_names: Union[str, List[str]] - Name(s) of the devices. Required.
            - udids: Union[str, List[str]] - UDID(s) of the devices. Required.
            - ports: Union[int, List[int]] - Port(s) for WDA servers. Required.
            - log_file_path: str - Path to save WDA log files. Required.

        Output:
            - Dict[str, any] - Mapping of device name to process instance.

        Error Handling:
            - Raises Exception if starting multiple WDA instances fails.

        Example:
        | ${wda_processes}= | Start Multiple WDA | /path/to/WDA.xcodeproj | iPhone 13 | abc123 | 8100 | /tmp/logs |
        """
        try:
            return self.webdrivertestlibrary.start_multiple_wda(
                project_path, device_names, udids, ports, log_file_path
            )
        except Exception as e:
            raise Exception(f"Failed to start multiple WDA instances: {e}") from e

    @keyword
    def stop_wda(self, wda_processes: Dict[str, any], device_name: str) -> None:
        """
        Wrapper to stop a running WebDriverAgent instance for a specific device locally.

        This keyword terminates the WDA subprocess for the specified device.

        Input Parameters:
            - wda_processes: Dict[str, any] - Dictionary of device names and their subprocess handles. Required.
            - device_name: str - Device name to stop the WDA process for. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if stopping WDA for the specified device fails.

        Example:
        | Stop WDA For Device | ${wda_processes} | iPhone 13 |
        """
        try:
            return self.webdrivertestlibrary.stop_wda_for_device(wda_processes, device_name)
        except Exception as e:
            raise Exception(f"Failed to stop WDA for device '{device_name}': {e}") from e

    @keyword
    def start_wda_on_remote_machine(
        self,
        project_path: str,
        device_names: List[str],
        udids: List[str],
        ports: List[int],
        appium_url: str,
        username: str,
        key_file: Optional[str] = None,
        password: Optional[str] = None
    ) -> Dict[str, any]:
        """
        Wrapper to start WebDriverAgent (WDA) for multiple devices on a remote machine.

        Uses SSH to connect to a remote machine and launch WDA processes for each device.

        Input Parameters:
            - project_path: str - Path to the WDA Xcode project on the remote machine. Required.
            - device_names: List[str] - List of device names. Required.
            - udids: List[str] - List of UDIDs. Required.
            - ports: List[int] - List of ports. Required.
            - appium_url: str - URL of the remote Appium server. Required.
            - username: str - SSH username. Required.
            - key_file: Optional[str] - SSH private key file path. Optional, defaults to None.
            - password: Optional[str] - SSH password. Optional, defaults to None.

        Output:
            - Dict[str, any] - Dictionary containing process information for each device.

        Error Handling:
            - Raises Exception if starting remote WDA instances fails.

        Example:
        | ${wda_processes}= | Start Multiple WDA Remote | /path/to/WDA.xcodeproj | [iPhone 13] | [abc123] | [8100] | http://remote:4723 | user | key.pem |
        """
        try:
            return self.webdrivertestlibrary.start_multiple_wda_remote(
                project_path, device_names, udids, ports,
                appium_url, username, key_file, password
            )
        except Exception as e:
            raise Exception(f"Failed to start remote WDA instances: {e}") from e

    @keyword
    def stop_wda_on_remote_machine(
        self,
        wda_processes: Dict[str, any],
        device_name: str,
        appium_url: str,
        username: str,
        key_file: Optional[str] = None,
        password: Optional[str] = None
    ) -> None:
        """
        Wrapper to stop a remote WebDriverAgent instance running on a specific device.

        This keyword connects via SSH and kills the WDA process running for the specified device and port.

        Input Parameters:
            - wda_processes: Dict[str, any] - Dictionary containing remote WDA process info. Required.
            - device_name: str - Name of the device. Required.
            - appium_url: str - URL of the remote Appium server. Required.
            - username: str - SSH username. Required.
            - key_file: Optional[str] - SSH key file. Optional, defaults to None.
            - password: Optional[str] - SSH password. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if stopping WDA remotely for the specified device fails.

        Example:
        | Stop WDA Remotely | ${wda_processes} | iPhone 13 | http://remote:4723 | user | key.pem |
        """
        try:
            return self.webdrivertestlibrary.stop_wda_remotely(
                wda_processes, device_name,
                appium_url, username,
                key_file, password
            )
        except Exception as e:
            raise Exception(f"Failed to stop WDA remotely for device '{device_name}': {e}") from e