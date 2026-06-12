from typing import Optional, Union
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword
from selenium.common.exceptions import WebDriverException

@library
class WaitingTestLibrary:
    """
    A MobAppTestLibrary for waiting and synchronization keywords.

    This library provides Robot Framework keywords to wait for elements to
    become visible, wait until a page contains or does not contain certain text.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the WaitingTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.waitingtestlibrary = mob

    @keyword
    def wait_until_element_is_visible(
        self,
        locator: str,
        timeout: Optional[Union[int, float]] = None,
        error: Optional[str] = None
    ) -> None:
        """
        Waits until element specified with `locator` is visible.

        Input Parameters:
            - locator: str - Element locator. Required.
            - timeout: Union[int, float, None] - Optional timeout in seconds. Optional, defaults to None.
            - error: str - Optional error message override. Optional, defaults to None.

        Output:
            - None - Returns nothing if element becomes visible within timeout.

        Error Handling:
            - Raises Exception if element is not visible within timeout.

        Example:
        | Wait Until Element Is Visible | id=my-element | 10 |
        """
        try:
            return self.waitingtestlibrary.wait_until_element_is_visible(locator, timeout, error)
        except Exception as e:
            raise Exception(f"Failed waiting for element visibility '{locator}': {e}") from e

    @keyword
    def wait_until_page_contains(
        self,
        text: str,
        timeout: Optional[Union[int, float]] = None,
        error: Optional[str] = None
    ) -> None:
        """
        Waits until `text` appears on current page.

        Input Parameters:
            - text: str - Text to wait for. Required.
            - timeout: Union[int, float, None] - Optional timeout in seconds. Optional, defaults to None.
            - error: str - Optional error message override. Optional, defaults to None.

        Output:
            - None - Returns nothing if text appears within timeout.

        Error Handling:
            - Raises WebDriverException if webdriver encounters an error.
            - Raises Exception if text does not appear within timeout.

        Example:
        | Wait Until Page Contains | Welcome | 15 |
        """
        try:
            return self.waitingtestlibrary.wait_until_page_contains(text, timeout, error)
        except Exception as e:
            raise Exception(f"Failed waiting for page to contain text '{text}': {e}") from e

    @keyword
    def wait_until_page_does_not_contain(
        self,
        text: str,
        timeout: Optional[Union[int, float]] = None,
        error: Optional[str] = None
    ) -> None:
        """
        Waits until `text` disappears from current page.

        Input Parameters:
            - text: str - Text that should disappear. Required.
            - timeout: Union[int, float, None] - Optional timeout in seconds. Optional, defaults to None.
            - error: str - Optional error message override. Optional, defaults to None.

        Output:
            - None - Returns nothing if text disappears within timeout.

        Error Handling:
            - Raises Exception if text does not disappear within timeout.

        Example:
        | Wait Until Page Does Not Contain | Loading... | 20 |
        """
        try:
            return self.waitingtestlibrary.wait_until_page_does_not_contain(text, timeout, error)
        except Exception as e:
            raise Exception(f"Failed waiting for page to not contain text '{text}': {e}") from e

    @keyword
    def wait_until_page_contains_element(
        self,
        locator: str,
        timeout: Optional[Union[int, float]] = None,
        error: Optional[str] = None
    ) -> None:
        """
        Waits until element specified with `locator` appears on current page.

        Input Parameters:
            - locator: str - Element locator. Required.
            - timeout: Union[int, float, None] - Optional timeout in seconds. Optional, defaults to None.
            - error: str - Optional error message override. Optional, defaults to None.

        Output:
            - None - Returns nothing if element appears within timeout.

        Error Handling:
            - Raises Exception if element does not appear within timeout.

        Example:
        | Wait Until Page Contains Element | id=my-element | 10 |
        """
        try:
            return self.waitingtestlibrary.wait_until_page_contains_element(locator, timeout, error)
        except Exception as e:
            raise Exception(f"Failed waiting for element to appear '{locator}': {e}") from e

    @keyword
    def wait_until_page_does_not_contain_element(
        self,
        locator: str,
        timeout: Optional[Union[int, float]] = None,
        error: Optional[str] = None
    ) -> None:
        """
        Waits until element specified with `locator` disappears from current page.

        Input Parameters:
            - locator: str - Element locator. Required.
            - timeout: Union[int, float, None] - Optional timeout in seconds. Optional, defaults to None.
            - error: str - Optional error message override. Optional, defaults to None.

        Output:
            - None - Returns nothing if element disappears within timeout.

        Error Handling:
            - Raises Exception if element does not disappear within timeout.

        Example:
        | Wait Until Page Does Not Contain Element | id=my-element | 10 |
        """
        try:
            return self.waitingtestlibrary.wait_until_page_does_not_contain_element(locator, timeout, error)
        except Exception as e:
            raise Exception(f"Failed waiting for element to disappear '{locator}': {e}") from e

    @keyword
    def set_sleep_between_wait_loop(self, seconds: float = 0.2) -> float:
        """
        Sets the sleep duration between wait loops used by wait-related keywords.

        This controls the pause time in seconds between retries in waiting loops.
        Adjusting this value can help optimize test execution speed, especially when
        running tests against remote Appium servers where network latency can affect performance.

        Input Parameters:
            - seconds: float - The new sleep duration in seconds. Optional, defaults to 0.2.

        Output:
            - float - The previous sleep duration before this call.

        Error Handling:
            - Raises Exception if setting the sleep duration fails.

        Example:
            | ${old_sleep} | Set Sleep Between Wait Loop | 0.5 |
        """
        try:
            return self.waitingtestlibrary.set_sleep_between_wait_loop(seconds)
        except Exception as e:
            raise Exception(f"Failed to set sleep between wait loop: {e}") from e

    @keyword
    def get_sleep_between_wait_loop(self) -> str:
        """
        Gets the current sleep duration between wait loops used by wait-related keywords.

        Returns the sleep time as a string formatted for Robot Framework time literals
        (e.g., '0.2s').

        Input Parameters:
            - None

        Output:
            - str - Current sleep duration between wait loops as a Robot Framework time string.

        Error Handling:
            - Raises Exception if retrieving the sleep duration fails.

        Example:
            | ${sleep} | Get Sleep Between Wait Loop |
        """
        try:
            return self.waitingtestlibrary.get_sleep_between_wait_loop()
        except Exception as e:
            raise Exception(f"Failed to get sleep between wait loop: {e}") from e