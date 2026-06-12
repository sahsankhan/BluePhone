from typing import Union, Optional, List, Any, Dict
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword
from selenium.webdriver.remote.webelement import WebElement

@library
class ApplicationManagementTestLibrary:
    """A Robot Framework library for managing mobile applications via Appium.

    This library wraps core application management methods for better exception handling
    and improved integration with Robot Framework.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the ApplicationManagementTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.applicationmanagementtestlibrary = mob

    @keyword
    def open_application(self, remote_url: str, alias: Optional[str] = None, **kwargs: Any) -> str:
        """
        Opens a new application on the given Appium server with the provided desired capabilities.

        Android and iOS.

        Input Parameters:
            - remote_url: str - The Appium server URL (e.g., "http://localhost:4723/wd/hub"). Required.
            - alias: str - An alias for this application session. Optional, defaults to None.
            - **kwargs: Any - Additional desired capabilities for the Appium session (e.g., platformName, deviceName, app, appPackage, appActivity, strict_ssl). Optional.

        Output:
            - str - A reference (session alias or ID) to the opened application session.

        Error Handling:
            - Raises Exception if the application fails to start or if Appium capabilities are invalid.

        Examples:
        | Open Application | http://localhost:4723/wd/hub | alias=MyApp1 | platformName=iOS | platformVersion=17.0 | deviceName=iPhone 14 | app=your.app |
        | Open Application | http://localhost:4723/wd/hub | platformName=Android | deviceName=Pixel_7 | app=${CURDIR}/app.apk | appPackage=com.example | appActivity=MainActivity |
        | Open Application | http://localhost:4723/wd/hub | alias=MyApp | platformName=Android | deviceName=emulator | app=your.apk | strict_ssl=False |
        """
        try:
            return self.applicationmanagementtestlibrary.open_application(remote_url, alias=alias, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to open application: {str(e)}") from e

    @keyword
    def background_application(self, seconds: int = 5) -> None:
        """
        Sends the currently active application to the background for a specified duration.
        This is useful for simulating app suspension or for switching context during tests.

        Android and iOS.

        Input Parameters:
            - seconds: int - The number of seconds to keep the application in the background. Optional, defaults to 5.

        Output:
            - None

        Error Handling:
            - Raises Exception if the application fails to go into the background.
            
        Examples:
        | Background Application | seconds=3 |
        | Background Application |           |
        """
        try:
            return self.applicationmanagementtestlibrary.background_application(seconds=seconds)
        except Exception as e:
            raise Exception(f"Failed to background application: {str(e)}") from e

    @keyword
    def activate_application(self, app_id: str) -> None:
        """
        Brings the specified application to the foreground.
        
        Android and iOS.

        Input Parameters:
            - app_id: str - The package name (Android) or bundle ID (iOS) of the application. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the application fails to activate.

        Examples:
        | Activate Application | com.example.myapp |
        | Activate Application | com.apple.Preferences |
        """
        try:
            return self.applicationmanagementtestlibrary.activate_application(app_id)
        except Exception as e:
            raise Exception(f"Failed to activate application '{app_id}': {str(e)}") from e

    @keyword
    def terminate_application(self, app_id: str) -> bool:
        """
        Terminates the specified application running on the device.

        Android and iOS.

        Input Parameters:
            - app_id: str - The package name (Android) or bundle ID (iOS) of the application. Required.

        Output:
            - bool - True if the app was terminated successfully, False otherwise.

        Error Handling:
            - Raises Exception if the application fails to terminate.

        Examples:
        | Terminate Application | com.example.myapp |
        | Terminate Application | com.apple.Preferences |
        """
        try:
            return self.applicationmanagementtestlibrary.terminate_application(app_id)
        except Exception as e:
            raise Exception(f"Failed to terminate application '{app_id}': {str(e)}") from e

    @keyword
    def close_application(self) -> bool:
        """
        Closes the specified application session on the device.

        Android and iOS.

        Input Parameters:
            - None

        Output:
            - bool - True if the application session was closed successfully, False otherwise.

        Error Handling:
            - Raises Exception if the application session fails to close.

        Examples:
        | Close Application |
        """
        try:
            return self.applicationmanagementtestlibrary.close_application()
        except Exception as e:
            raise Exception(f"Failed to close application session: {str(e)}") from e

    @keyword
    def close_all_applications(self) -> bool:
        """
        Closes all open application sessions on the device.

        Android and iOS.

        Input Parameters:
        - None

        Output:
            - bool - True if all application sessions were closed successfully, False otherwise.

        Error Handling:
            - Raises Exception if the termination of all application sessions fails.

        Examples:
        | Close All Applications |
        | [Teardown] | Close All Applications |
        """
        try:
            return self.applicationmanagementtestlibrary.close_all_applications()
        except Exception as e:
            raise Exception(f"Failed to close all application sessions: {str(e)}") from e

    @keyword
    def get_appium_timeout(self) -> str:
        """
        Retrieves the timeout in seconds used by various keywords.

        Android and iOS.

        Input Parameters:
            - None

        Output:
            - str - The current timeout value in seconds (e.g., "5 seconds").

        Error Handling:
            - Raises Exception if the timeout value cannot be retrieved.

        Examples:
        | ${timeout}= | Get Appium Timeout |
        | Log | Current timeout is ${timeout} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_appium_timeout()
        except Exception as e:
            raise Exception(f"Failed to get Appium timeout: {str(e)}") from e

    @keyword
    def set_appium_timeout(self, seconds: Union[str, int]) -> str:
        """
        Sets the timeout in seconds used by various keywords.

        Android and iOS.

        Input Parameters:
            - seconds: Union[str, int] - The timeout duration (e.g., "15 seconds" or 15). Required.

        Output:
            - str - The previous timeout value (e.g., "5 seconds").

        Error Handling:
            - Raises Exception if the timeout value cannot be set.

        Examples:
        | ${orig_timeout}= | Set Appium Timeout | 15 seconds |
        | Open Page That Loads Slowly |
        | Set Appium Timeout | ${orig_timeout} |
        """
        try:
            return self.applicationmanagementtestlibrary.set_appium_timeout(seconds)
        except Exception as e:
            raise Exception(f"Failed to set Appium timeout: {str(e)}") from e

    @keyword
    def get_appium_sessionId(self) -> str:
        """
        Retrieves the current Appium session ID.

        Android and iOS.

        Input Parameters:
            - None

        Output:
            - str - The current Appium session ID.

        Error Handling:
            - Raises Exception if the session ID cannot be retrieved.

        Examples:
        | ${session_id}= | Get Appium SessionId |
        | Log | Current session ID is ${session_id} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_appium_sessionId()
        except Exception as e:
            raise Exception(f"Failed to get Appium session ID: {str(e)}") from e

    @keyword
    def switch_application(self, index_or_alias: Union[int, str]) -> int:
        """
        Switches the active application by index or alias.

        `index_or_alias` is either an application index (an integer) or an alias (a string).
        The index is obtained as the return value of `Open Application`.

        Android and iOS.

        Input Parameters:
            - index_or_alias: Union[int, str] - The index or alias of the application to switch to. Required.

        Output:
            - int - The index of the previous active application.

        Error Handling:
            - Raises Exception if switching the application fails due to invalid index/alias or driver issues.

        Examples:
        | ${appium1}= | Open Application | http://localhost:4723/wd/hub | alias=MyApp1 | platformName=iOS | platformVersion=7.0 | deviceName=iPhone Simulator | app=your.app |
        | ${appium2}= | Open Application | http://localhost:4755/wd/hub | alias=MyApp2 | platformName=iOS | platformVersion=7.0 | deviceName=iPhone Simulator | app=your.app |
        | Click Element | sendHello | # Executed on appium at localhost:4755 |
        | ${prev}= | Switch Application | ${appium1} | # Switch using index |
        | Click Element | ackHello | # Executed on appium at localhost:4723 |
        | Switch Application | MyApp2 | # Switch using alias |
        | Page Should Contain Text | ackHello Received | # Executed on appium at localhost:4755 |
        """
        try:
            return self.applicationmanagementtestlibrary.switch_application(index_or_alias)
        except Exception as e:
            raise Exception(f"Failed to switch application to '{index_or_alias}': {str(e)}") from e

    @keyword
    def remove_application(self, application_id: str) -> None:
        """
        Removes the application identified by the given application ID.

        Android and iOS.

        Input Parameters:
            - application_id: str - The package name (Android) or bundle ID (iOS) of the application to remove. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if removing the application fails due to driver issues.

        Examples:
        | Remove Application | com.netease.qa.orangedemo |
        """
        try:
            return self.applicationmanagementtestlibrary.remove_application(application_id)
        except Exception as e:
            raise Exception(f"Failed to remove application '{application_id}': {str(e)}") from e

    @keyword
    def get_source(self) -> str:
        """
        Returns the entire source of the current page.

        Android and iOS.

        Input Parameters:
            - None

        Output:
            - str - The page source of the current application.

        Error Handling:
            - Raises Exception if retrieving the page source fails due to driver issues.

        Examples:
        | ${source}= | Get Source |
        | Log | Page source: ${source} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_source()
        except Exception as e:
            raise Exception(f"Failed to get page source: {str(e)}") from e

    @keyword
    def log_source(self, loglevel: str = 'INFO') -> str:
        """
        Logs and returns the entire HTML source of the current page or frame.
        
        Android and iOS.
        
        Input Parameters:
            - loglevel: str - The log level to use ('WARN', 'INFO', 'DEBUG', 'TRACE', or 'NONE'). Optional, defaults to 'INFO'.

        Output:
            - str - The page source if logged, empty string if loglevel is 'NONE' or called within run_keyword_and_ignore_error.

        Error Handling:
            - Raises Exception if logging or retrieving the page source fails due to driver issues.

        Examples:
        | ${source}= | Log Source |
        | Log | Source logged at INFO level: ${source} |
        | ${source}= | Log Source | loglevel=DEBUG |
        | ${source}= | Log Source | loglevel=NONE |
        """
        try:
            return self.applicationmanagementtestlibrary.log_source(loglevel)
        except Exception as e:
            raise Exception(f"Failed to log page source with loglevel '{loglevel}': {str(e)}") from e

    @keyword
    def execute_script(self, script: str, **kwargs: Any) -> Any:
        """
        Executes a variety of native, mobile commands that aren't associated with a specific endpoint.

        Android and iOS.

        Input Parameters:
            - script: str - The mobile command script to execute (e.g., 'mobile: scrollGesture'). Required.
            - **kwargs: Any - Additional arguments as a dictionary (e.g., left, top, width, height, direction, percent). Optional.

        Output:
            - Any - The result of the executed script (depends on the command).

        Error Handling:
            - Raises Exception if executing the script fails due to driver issues or invalid arguments.

        Examples:
        | &{scrollGesture}= | Create Dictionary | left=${50} | top=${150} | width=${50} | height=${200} | direction=down | percent=${100} |
        | Sleep | 1 |
        | ${result}= | Execute Script | mobile: scrollGesture | &{scrollGesture} |
        | Log | Scroll result: ${result} |
        """
        try:
            return self.applicationmanagementtestlibrary.execute_script(script, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to execute script '{script}': {str(e)}") from e

    @keyword
    def execute_async_script(self, script: str, **kwargs: Any) -> Any:
        """
        Injects a snippet of Async JavaScript into the page for execution in the context of the currently selected frame (Web context only).

        The executed script is assumed to be asynchronous and must signal completion by invoking the provided callback,
        which is always the final argument. The value passed to this callback is returned to the client.

        Input Parameters:
            - script: str - The asynchronous JavaScript code to execute. Required.
            - **kwargs: Any - Additional arguments as a dictionary to pass to the script. Optional.

        Output:
            - Any - The value returned by the callback in the executed script.

        Error Handling:
            - Raises Exception if executing the async script fails due to driver issues or invalid arguments.
            
        Examples:
        | &{args}= | Create Dictionary | key=value |
        | ${result}= | Execute Async Script | var callback = arguments[arguments.length - 1]; setTimeout(function() { callback('done'); }, 1000); | &{args} |
        | Log | Async result: ${result} |
        """
        try:
            return self.applicationmanagementtestlibrary.execute_async_script(script, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to execute async script '{script}': {str(e)}") from e

    @keyword
    def execute_adb_shell(self, command: str, *args: str) -> Any:
        """
        Executes ADB shell commands on an Android device.

        Android Only.

        Input Parameters:
            - command: str - The ADB shell command to execute. Required.
            - *args: str - Variable number of arguments to send to the command. Optional.

        Output:
            - Any - The exit code or result of the ADB shell command.

        Error Handling:
            - Raises Exception if executing the ADB shell command fails due to driver issues or Appium server restrictions.

        Examples:
        | ${result}= | Execute Adb Shell | ls | -l |
        | Log | ADB shell result: ${result} |
        """
        try:
            return self.applicationmanagementtestlibrary.execute_adb_shell(command, *args)
        except Exception as e:
            raise Exception(f"Failed to execute ADB shell command '{command}': {str(e)}") from e

    @keyword
    def execute_adb_shell_timeout(self, command: str, timeout: int, *args: str) -> Any:
        """
        Executes ADB shell commands on an Android device with a specified timeout.

        Android Only.

        Input Parameters:
            - command: str - The ADB shell command to execute. Required.
            - timeout: int - The timeout in milliseconds to apply to the command. Required.
            - *args: str - Variable number of arguments to send to the command. Optional.

        Output:
            - Any - The exit code or result of the ADB shell command.

        Error Handling:
            - Raises Exception if executing the ADB shell command fails due to driver issues, timeout, or Appium server restrictions.
        Examples:
        | ${result}= | Execute Adb Shell Timeout | ls | 5000 | -l |
        | Log | ADB shell result: ${result} |
        """
        try:
            return self.applicationmanagementtestlibrary.execute_adb_shell_timeout(command, timeout, *args)
        except Exception as e:
            raise Exception(f"Failed to execute ADB shell command '{command}' with timeout '{timeout}': {str(e)}") from e

    @keyword
    def go_back(self) -> None:
        """
        Goes one step backward in the browser history.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if navigating back fails due to driver issues.

        Examples:
        | Go Back |
        """
        try:
            return self.applicationmanagementtestlibrary.go_back()
        except Exception as e:
            raise Exception(f"Failed to go back in browser history: {str(e)}") from e

    @keyword
    def lock(self, seconds: Union[int, str] = 5) -> None:
        """
        Locks the device for a specified period of time.

        IOS only.

        Input Parameters:
            - seconds: Union[int, str] - The duration in seconds to lock the device. Can be a string (e.g., "10 seconds") or an integer. Optional, defaults to 5.

        Output:
            - None

        Error Handling:
            - Raises Exception if locking the device fails due to driver issues or invalid duration.

        Examples:
        | Lock |
        | Lock | 10 |
        | Lock | 5 seconds |
        """
        try:
            return self.applicationmanagementtestlibrary.lock(seconds)
        except Exception as e:
            raise Exception(f"Failed to lock device for {seconds} seconds: {str(e)}") from e

    @keyword
    def stop_application(self, app_id: str, timeout: int = 5000, include_stderr: bool = True) -> None:
        """
        Stops the given app on the device.

        Android only.

        Input Parameters:
            - app_id: str - The package name of the app to stop. Required.
            - timeout: int - The timeout in milliseconds for the command. Optional, defaults to 5000.
            - include_stderr: bool - Whether to include stderr in the response if the command fails. Optional, defaults to True.

        Output:
            - None

        Error Handling:
            - Raises Exception if stopping the application fails due to driver issues or command execution errors.

        Examples:
        | Stop Application | com.example.myapp |
        | Stop Application | com.example.myapp | timeout=10000 | include_stderr=False |
        """
        try:
            return self.applicationmanagementtestlibrary.stop_application(app_id, timeout=timeout, include_stderr=include_stderr)
        except Exception as e:
            raise Exception(f"Failed to stop application '{app_id}': {str(e)}") from e

    @keyword
    def touch_id(self, match: bool = True) -> None:
        """
        Simulates Touch ID on iOS Simulator.

        IOS only.

        Input Parameters:
            - match: bool - Whether the simulated fingerprint is valid. Optional, defaults to True.

        Output:
            - None

        Error Handling:
            - Raises Exception if simulating Touch ID fails due to driver issues.

        Examples:
        | Touch Id |
        | Touch Id | match=False |
        """
        try:
            return self.applicationmanagementtestlibrary.touch_id(match)
        except Exception as e:
            raise Exception(f"Failed to simulate Touch ID with match={match}: {str(e)}") from e

    @keyword
    def toggle_touch_id_enrollment(self) -> None:
        """
        Toggles the Touch ID enrolled state on iOS Simulator.

        IOS only.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if toggling Touch ID enrollment fails due to driver issues.

        Examples:
        | Toggle Touch Id Enrollment |
        """
        try:
            return self.applicationmanagementtestlibrary.toggle_touch_id_enrollment()
        except Exception as e:
            raise Exception(f"Failed to toggle Touch ID enrollment: {str(e)}") from e

    @keyword
    def shake(self) -> None:
        """
        Shakes the device.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if shaking the device fails due to driver issues.
            
        Examples:
        | Shake |
        """
        try:
            return self.applicationmanagementtestlibrary.shake()
        except Exception as e:
            raise Exception(f"Failed to shake device: {str(e)}") from e

    @keyword
    def portrait(self) -> None:
        """
        Sets the device orientation to PORTRAIT.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if setting the orientation to PORTRAIT fails due to driver issues.

        Examples:
        | Portrait |
        """
        try:
            return self.applicationmanagementtestlibrary.portrait()
        except Exception as e:
            raise Exception(f"Failed to set device orientation to PORTRAIT: {str(e)}") from e

    @keyword
    def landscape(self) -> None:
        """
        Sets the device orientation to LANDSCAPE.
        
        Android and IOS.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if setting the orientation to LANDSCAPE fails due to driver issues.

        Examples:
        | Landscape |
        """
        try:
            return self.applicationmanagementtestlibrary.landscape()
        except Exception as e:
            raise Exception(f"Failed to set device orientation to LANDSCAPE: {str(e)}") from e

    @keyword
    def get_current_context(self) -> str:
        """
        Gets the current context.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - str - The current context of the application.

        Error Handling:
            - Raises Exception if retrieving the current context fails due to driver issues.

        Examples:
        | ${context}= | Get Current Context |
        | Log | Current context: ${context} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_current_context()
        except Exception as e:
            raise Exception(f"Failed to get current context: {str(e)}") from e

    @keyword
    def get_contexts(self) -> List[str]:
        """
        Gets the available contexts.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - List[str] - A list of available contexts for the application.

        Error Handling:
            - Raises Exception if retrieving the contexts fails due to driver issues.

        Examples:
        | ${contexts}= | Get Contexts |
        | Log | Available contexts: ${contexts} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_contexts()
        except Exception as e:
            raise Exception(f"Failed to get contexts: {str(e)}") from e

    @keyword
    def get_window_height(self) -> int:
        """
        Gets the current device height.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - int - The height of the current window in pixels.

        Error Handling:
            - Raises Exception if retrieving the window height fails due to driver issues.

        Examples:
        | ${width}= | Get Window Width |
        | ${height}= | Get Window Height |
        | Click A Point | ${width} | ${height} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_window_height()
        except Exception as e:
            raise Exception(f"Failed to get window height: {str(e)}") from e

    @keyword
    def get_window_width(self) -> int:
        """
        Gets the current device width.

        Android and IOS.
        
        Input Parameters:
            - None

        Output:
            - int - The width of the current window in pixels.

        Error Handling:
            - Raises Exception if retrieving the window width fails due to driver issues.

        Examples:
        | ${width}= | Get Window Width |
        | ${height}= | Get Window Height |
        | Click A Point | ${width} | ${height} |
        """
        try:
            return self.applicationmanagementtestlibrary.get_window_width()
        except Exception as e:
            raise Exception(f"Failed to get window width: {str(e)}") from e

    @keyword
    def switch_to_context(self, context_name: str) -> None:
        """
        Switches to a new context.

        Android and IOS.

        Input Parameters:
            - context_name: str - The name of the context to switch to. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if switching to the context fails due to driver issues or invalid context name.

        Examples:
        | Switch To Context | NATIVE_APP |
        | Switch To Context | WEBVIEW_1 |
        """
        try:
            return self.applicationmanagementtestlibrary.switch_to_context(context_name)
        except Exception as e:
            raise Exception(f"Failed to switch to context '{context_name}': {str(e)}") from e

    @keyword
    def switch_to_frame(self, frame: Union[int, str, WebElement]) -> None:
        """
        Switches focus to the specified frame, by index, name, or WebElement.

        Android and IOS.

        Input Parameters:
            - frame: Union[int, str, WebElement] - The frame to switch to (index, name, or WebElement). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if switching to the frame fails due to driver issues or invalid frame.

        Examples:
        | Go To Url | http://www.xxx.com |
        | Switch To Frame | iframe_name |
        | Click Element | xpath=//*[@id="online-btn"] |
        """
        try:
            return self.applicationmanagementtestlibrary.switch_to_frame(frame)
        except Exception as e:
            raise Exception(f"Failed to switch to frame '{frame}': {str(e)}") from e

    @keyword
    def switch_to_parent_frame(self) -> None:
        """
        Switches focus to the parent frame of the current context.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if switching to the parent frame fails due to driver issues or invalid context.

        Examples:
        | Switch To Parent Frame |
        | Click Element | xpath=//button[text()='Submit'] |
        """
        try:
            return self.applicationmanagementtestlibrary.switch_to_parent_frame()
        except Exception as e:
            raise Exception(f"Failed to switch to parent frame: {str(e)}") from e

    @keyword
    def switch_to_window(self, window_name: str) -> None:
        """
        Switches focus to a specified window or webview.

        Android and IOS.

        Input Parameters:
            - window_name: str - The name or handle of the window/webview to switch to. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the window name is invalid or the switch fails.

        Examples:
        | Switch To Window | WEBVIEW_1 |
        | Click Element    | id=logout_button |
        """
        try:
            return self.applicationmanagementtestlibrary.switch_to_window(window_name)
        except Exception as e:
            raise Exception(f"Failed to switch to window '{window_name}': {str(e)}") from e

    @keyword
    def go_to_url(self, url: str) -> None:
        """
        Opens the specified URL in the active browser session.
        
        Android and IOS.

        Input Parameters:
            - url: str - The web URL to open in the current session. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the URL cannot be opened or the session is not browser-capable.

        Examples:
        | Open Application | http://localhost:4723/wd/hub | platformName=iOS | browserName=Safari |
        | Go To URL        | https://example.com |
        """
        try:
            return self.applicationmanagementtestlibrary.go_to_url(url)
        except Exception as e:
            raise Exception(f"Failed to go to URL '{url}': {str(e)}") from e

    @keyword
    def get_capability(self, capability_name: str) -> str:
        """
        Returns the value of a specific desired capability from the current session.

        Android and IOS.

        Input Parameters:
            - capability_name: str - The name of the desired capability (e.g., platformName, deviceName). Required.

        Output:
            - str - The value of the specified capability.

        Error Handling:
            - Raises Exception if the capability is not found or session is invalid.

        Examples:
        | ${platform}= | Get Capability | platformName |
        | Should Be Equal | ${platform} | Android |
        """
        try:
            return self.applicationmanagementtestlibrary.get_capability(capability_name)
        except Exception as e:
            raise Exception(f"Failed to get capability '{capability_name}': {str(e)}") from e

    @keyword
    def get_window_title(self) -> str:
        """
        Returns the title of the current WebView window.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - str - The title of the current window.

        Error Handling:
            - Raises Exception if the title cannot be retrieved due to driver or session issues.

        Examples:
        | ${title}= | Get Window Title |
        | Should Contain | ${title} | Home |
        """
        try:
            return self.applicationmanagementtestlibrary.get_window_title()
        except Exception as e:
            raise Exception(f"Failed to get window title: {str(e)}") from e

    @keyword
    def get_window_url(self) -> str:
        """
        Returns the URL of the current WebView window. Useful to confirm navigation or redirection within web-based sessions.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - str - The current URL.

        Error Handling:
            - Raises Exception if the URL cannot be retrieved due to driver or session issues.

        Examples:
        | ${url}= | Get Window URL |
        | Should Start With | ${url} | https:// |
        """
        try:
            return self.applicationmanagementtestlibrary.get_window_url()
        except Exception as e:
            raise Exception(f"Failed to get window URL: {str(e)}") from e

    @keyword
    def get_windows(self) -> List[str]:
        """
        Returns a list of available WebView window handles.

        Android and IOS.

        Input Parameters:
            - None

        Output:
            - List[str] - A list of available window handles.

        Error Handling:
            - Raises Exception if window handles cannot be retrieved.

        Examples:
        | ${windows}= | Get Windows |
        | Switch To Window | ${windows}[1] |
        """
        try:
            return self.applicationmanagementtestlibrary.get_windows()
        except Exception as e:
            raise Exception(f"Failed to get window handles: {str(e)}") from e