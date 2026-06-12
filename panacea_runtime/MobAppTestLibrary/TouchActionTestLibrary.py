from typing import Optional, Union, List, Tuple
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword
from datetime import timedelta
from selenium.common.exceptions import WebDriverException

@library
class TouchActionTestLibrary:
    """
    A MobAppTestLibrary for performing touch actions on mobile devices.

    This library provides Robot Framework keywords for performing gestures
    such as swiping by coordinates or percentage, and scrolling between
    UI elements.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the TouchActionTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.touchactiontestlibrary = mob

    @keyword
    def swipe(
        self,
        *, 
        start_x: Union[int, float], 
        start_y: Union[int, float], 
        end_x: Union[int, float], 
        end_y: Union[int, float], 
        duration: Union[int, timedelta] = timedelta(seconds=1)
    ) -> None:
        """
        Swipes on the screen from the specified starting point to an offset position.

        Input Parameters:
            - start_x: x-coordinate at which to start
            - start_y: y-coordinate at which to start
            - end_x: x-coordinate at which to stop
            - end_y: y-coordinate at which to stop
            - duration: defines the swipe speed as time taken to swipe from point a to point b.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Example:
        | Swipe | start_x=500 | start_y=100 | end_x=100 | end_y=0 | duration=1s |
        | Swipe | start_x=500 | start_y=100 | end_x=100 | end_y=0 | duration=100ms |
        """
        try:
            return self.touchactiontestlibrary.swipe(start_x=start_x, start_y=start_y, end_x=end_x, end_y=end_y, duration=duration)
        except Exception as e:
            raise Exception(f"Swipe action failed: {e}") from e

    @keyword
    def swipe_by_percent(
        self, 
        start_x: Union[int, float], 
        start_y: Union[int, float], 
        end_x: Union[int, float], 
        end_y: Union[int, float], 
        duration: Union[int, timedelta] = timedelta(seconds=1)
    ) -> None:
        """
        Swipes on the screen using percentage-based coordinates, useful for
        devices with varying resolutions.

        Input Parameters:
            - start_x: float - Start X as percentage (0-100). Required.
            - start_y: float - Start Y as percentage. Required.
            - end_x: float - End X as percentage. Required.
            - end_y: float - End Y as percentage. Required.
            - duration: int - Duration in milliseconds. Optional, defaults to 1000.

        Output:
            - None

        Error Handling:
            - Raises Exception for calculation or unexpected errors.

        Example:
        | Swipe By Percent | 90 | 50 | 10 | 50 |
        """
        try:
            return self.touchactiontestlibrary.swipe_by_percent(start_x=start_x, start_y=start_y, end_x=end_x, end_y=end_y, duration=duration)
        except Exception as e:
            raise Exception(f"Swipe by percent action failed: {e}") from e

    @keyword
    def tap_with_positions(self, duration:Union[int, timedelta] = timedelta(milliseconds=500), *locations) -> None:
        """
        Taps on specific screen coordinates, with optional duration.

        Input Parameters:
            - duration: int - Duration of the tap in milliseconds. Optional, defaults to 500.
            - *locations: List[Tuple[int, int]] - X,Y positions to tap. Up to 5 allowed. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected issues.

        Example:
        | @{point1}     | Create List | 100 | 500 |
        | @{point2}     | Create List | 300 | 700 |
        | @{fingers}    | Create List | ${point1} | ${point2} |
        | Tap With Positions | 800 | @{fingers} |
        """
        try:
            return self.touchactiontestlibrary.tap_with_positions(duration, *locations)
        except Exception as e:
            raise Exception(f"Failed to perform tap with positions: {e}") from e

    @keyword
    def tap_with_number_of_taps(self, locator: str, number_of_taps: int, number_of_touches: int) -> None:
        """
        Sends multiple taps with one or more touch points.

        IOS only

        Input Parameters:
            - locator: str - The element locator to tap. Required.
            - number_of_taps: int - Number of taps. Required.
            - number_of_touches: int - Number of simultaneous fingers. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if locator is not found or other errors occur.

        Example:
        | Tap With Number Of Taps | xpath=//XCUIElementTypeButton[@name="OK"] | 2 | 2 |
        """
        try:
            return self.touchactiontestlibrary.tap_with_number_of_taps(locator, number_of_taps, number_of_touches)
        except Exception as e:
            raise Exception(f"Failed to tap with number of taps on '{locator}': {e}") from e

    @keyword
    def drag_and_drop(self, locator: str, target: str) -> None:
        """
        Drags an element identified by `locator` and drops it onto the `target` element.

        Input Parameters:
            - locator: str - Locator of the element to drag. Required.
            - target: str - Locator of the destination element. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception for all other unexpected errors.

        Example:
        | Drag And Drop | id=draggable | id=droppable |
        """
        try:
            return self.touchactiontestlibrary.drag_and_drop(locator, target)
        except Exception as e:
            raise Exception(f"Failed to perform drag and drop: {e}") from e

    @keyword
    def flick(self, start_x: int, start_y: int, end_x: int, end_y: int) -> None:
        """
        Performs a flick gesture from one point to another.

        Input Parameters:
            - start_x: int - X-coordinate of the start point. Required.
            - start_y: int - Y-coordinate of the start point. Required.
            - end_x: int - X-coordinate of the end point. Required.
            - end_y: int - Y-coordinate of the end point. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception for other general errors.

        Example:
        | Flick | 100 | 300 | 100 | 100 | # Flicks screen upward |
        """
        try:
            return self.touchactiontestlibrary.flick(start_x, start_y, end_x, end_y)
        except Exception as e:
            raise Exception(f"Failed to perform flick gesture: {e}") from e

    @keyword
    def scroll_screen_up(self, max_scrolls: int = 1, delay: float = 5.0) -> None:
        """
        Scrolls the screen upward a specified number of times with a delay between each scroll.

        Input Parameters:
            - max_scrolls: int - Number of times to scroll up. Optional, defaults to 1.
            - delay: float - Delay in seconds between each scroll. Optional, defaults to 5.0.

        Output:
            - None

        Error Handling:
            - Raises Exception if the scroll gesture fails.

        Example:
        | Scroll Screen Up |
        | Scroll Screen Up | max_scrolls=3 | delay=2.0 |
        """
        try:
            return self.touchactiontestlibrary.scroll_screen_up(max_scrolls=max_scrolls, delay=delay)
        except Exception as e:
            raise Exception(f"Failed to scroll screen up: {e}") from e

    @keyword
    def scroll_up_until_element_found(
        self,
        locator: str,
        max_scrolls: int = 5,
        delay: float = 5.0,
        timeout: Union[int, timedelta] = timedelta(seconds=10)
    ) -> bool:
        """
        Scrolls up repeatedly until the specified element becomes visible or the maximum scroll count is reached.

        Input Parameters:
            - locator: str - Locator of the element to find. Required.
            - max_scrolls: int - Maximum number of scroll attempts. Optional, defaults to 5.
            - delay: float - Delay in seconds between each scroll attempt. Optional, defaults to 5.0.
            - timeout: int - Time in seconds to wait for element visibility on each attempt. Optional, defaults to 10.

        Output:
            - bool: Returns True when the element becomes visible.

        Error Handling:
            - Raises Exception if the element is not found after all scroll attempts.

        Example:
        | Scroll Up Until Element Found | xpath=//android.widget.TextView[@text="Settings"] |
        | Scroll Up Until Element Found | xpath=//android.widget.TextView[@text="Settings"] | max_scrolls=10 | delay=2.0 | timeout=15s |
        """
        try:
            return self.touchactiontestlibrary.scroll_up_until_element_found(
                locator, max_scrolls=max_scrolls, delay=delay, timeout=timeout
            )
        except Exception as e:
            raise Exception(f"Element '{locator}' not found after scrolling up {max_scrolls} time(s): {e}") from e

    @keyword
    def tap_on_element(self, locator: str, timeout: Union[int, timedelta] = timedelta(seconds=10)) -> None:
        """
        Waits for an element to be present and taps on it.

        Input Parameters:
            - locator: str - XPath locator of the element to tap. Required.
            - timeout: int - Time in seconds to wait for the element to appear. Optional, defaults to 10.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found within the timeout or the tap fails.

        Example:
        | Tap On Element | xpath=//android.widget.Button[@text="OK"] |
        | Tap On Element | xpath=//XCUIElementTypeButton[@name="Continue"] | timeout=15s |
        """
        try:
            return self.touchactiontestlibrary.tap_on_element(locator, timeout=timeout)
        except Exception as e:
            raise Exception(f"Failed to tap on element '{locator}': {e}") from e

    @keyword
    def tap(self, element: Union[str, list], count: int = 1, duration=timedelta(seconds=1)) -> None:
        """
        Taps the element (using locator or coordinates) for the given count times over the specified duration.

        Input Parameters:
            - element: Union[str, list] - XPath locator (string) or coordinates as list [x, y]. Required.
            - count: int - Number of times the element should be tapped. Optional, defaults to 1.
            - duration: int - Duration of each tap in seconds. Optional, defaults to 1.

        Output:
            - None

        Error Handling:
            - Raises Exception if the tap fails due to invalid locator/coordinates, element not found, timeout, or other issues.

        Examples:
        | Tap | xpath=//*[@resource-id='login_button'] |
        | Tap | xpath=//*[@name='picture'] | count=2 |
        | Tap | xpath=//*[@name='picture'] | count=2 | duration=3 |
        
        | VAR | @{coordinates} | 100 | 270 |
        | Tap | ${coordinates} | count=3 |
        """
        try:
            return self.touchactiontestlibrary.tap(element, count, duration)
        except Exception as e:
            raise Exception(f"Failed to tap on '{element}': {e}") from e
        