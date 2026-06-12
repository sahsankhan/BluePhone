from datetime import timedelta
from typing import Literal, Union, Optional, List, Dict
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword
from selenium.webdriver.remote.webelement import WebElement

@library
class ElementTestLibrary:
    """
    A MobAppTestLibrary for managing UI element interactions across platforms.

    This library provides Robot Framework keywords to interact with UI elements,
    including finding elements, interacting with them, verifying states, and more.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the ElementTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.elementtestlibrary = mob

    @keyword
    def clear_text(self, locator: str) -> None:
        """
        Clears the text from an input field identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to identify the text field. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the text field cannot be found or cleared.

        Examples:
        | Clear Text | xpath=//input[@id="username"] |
        """
        try:
            return self.elementtestlibrary.clear_text(locator)
        except Exception as e:
            raise Exception(f"Failed to clear text for locator '{locator}': {str(e)}") from e

    @keyword
    def click_element(self, locator: str) -> None:
        """
        Clicks an element identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to find the element (e.g., xpath, id, name). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found or the click fails.

        Examples:
        | Click Element | xpath=//button[@type='submit'] |
        """
        try:
            return self.elementtestlibrary.click_element(locator)
        except Exception as e:
            raise Exception(f"Failed to click element '{locator}': {str(e)}") from e

    @keyword
    def click_button(self, index_or_name: Union[str, int]) -> None:
        """
        Clicks a button using its index or name.

        Input Parameters:
            - index_or_name: Union[str, int] - The index or name of the button. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the button is not found or cannot be clicked.

        Examples:
        | Click Button | 1 |
        | Click Button | Login |
        """
        try:
            return self.elementtestlibrary.click_button(index_or_name)
        except Exception as e:
            raise Exception(f"Failed to click button '{index_or_name}': {str(e)}") from e

    @keyword
    def click_text(self, text: str, exact_match: bool = False) -> None:
        """
        Clicks a UI element that contains or exactly matches the given text.

        By default, it clicks the first element that contains the given text.
        To match the text exactly, set `exact_match=True`.

        Input Parameters:
            - text: str - The visible text to locate and click. Required.
            - exact_match: bool - Set to True to click only exact match. Optional, defaults to False.

        Output:
            - None

        Error Handling:
            - Raises Exception if no element with the given text is found or cannot be clicked.

        Examples:
        | Click Text | Login |
        | Click Text | Submit | exact_match=True |
        """
        try:
            return self.elementtestlibrary.click_text(text, exact_match=exact_match)
        except Exception as e:
            raise Exception(f"Failed to click text '{text}': {str(e)}") from e

    @keyword
    def input_text_into_current_element(self, text: str) -> None:
        """
        Inputs text into the currently selected field.
        
        Android only

        Input Parameters:
            - text: str - The text to input into the current field. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if text cannot be typed into the current element.

        Examples:
        | Input Text Into Current Element | Hello World |
        """
        try:
            return self.elementtestlibrary.input_text_into_current_element(text)
        except Exception as e:
            raise Exception(f"Failed to input text into current element: {str(e)}") from e

    @keyword
    def input_text(self, locator: str, text: str) -> None:
        """
        Inputs text into a text field identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to identify the input field. Required.
            - text: str - The text to input into the field. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the input field cannot be found or typed into.

        Examples:
        | Input Text | xpath=//input[@id="email"] | user@example.com |
        """
        try:
            return self.elementtestlibrary.input_text(locator, text)
        except Exception as e:
            raise Exception(f"Failed to input text into field '{locator}': {str(e)}") from e

    @keyword
    def input_password(self, locator: str, text: str) -> None:
        """
        Inputs a password into the text field identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to identify the password input field. Required.
            - text: str - The password to input. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the input field cannot be found or the password cannot be entered.

        Examples:
        | Input Password | id=password_field | mySecret123 |
        """
        try:
            return self.elementtestlibrary.input_password(locator, text)
        except Exception as e:
            raise Exception(f"Failed to input password in field '{locator}': {str(e)}") from e

    @keyword
    def input_value(self, locator: str, text: str) -> None:
        """
        Sets the given value into a text field using iOS's `set_value` method.
        
        IOS Only

        Input Parameters:
            - locator: str - The locator of the text field. Required.
            - text: str - The value to set. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the input field cannot be found or the value cannot be set.

        Examples:
        | Input Value | xpath=//XCUIElementTypeTextField | 123456 |
        """
        try:
            return self.elementtestlibrary.input_value(locator, text)
        except Exception as e:
            raise Exception(f"Failed to input value in field '{locator}': {str(e)}") from e

    @keyword
    def hide_keyboard(self, key_name: Optional[str] = None) -> None:
        """
        Hides the software keyboard on the device.

        On iOS, optionally provide a key name (e.g., `Done`) to close the keyboard.
        On Android, this keyword hides the keyboard without needing parameters.

        Input Parameters:
            - key_name: str - iOS only – the name of the key to press to close the keyboard. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if the keyboard cannot be hidden.

        Examples:
        | Hide Keyboard |
        | Hide Keyboard | Done |
        """
        try:
            return self.elementtestlibrary.hide_keyboard(key_name)
        except Exception as e:
            raise Exception(f"Failed to hide keyboard: {str(e)}") from e

    @keyword
    def is_keyboard_shown(self) -> bool:
        """
        Returns whether the Android keyboard is currently displayed.

        This keyword checks the current application context and returns True if the keyboard is shown,
        otherwise returns False. Only applicable on Android.

        Input Parameters:
            - None

        Output:
            - bool - True if keyboard is visible, False otherwise.

        Error Handling:
            - Raises Exception if the keyboard state cannot be determined.

        Examples:
        | ${keyboard_visible}= | Is Keyboard Shown |
        | Should Be True       | ${keyboard_visible} |
        """
        try:
            return self.elementtestlibrary.is_keyboard_shown()
        except Exception as e:
            raise Exception(f"Failed to check if keyboard is shown: {str(e)}") from e

    @keyword
    def page_should_contain_text(self, text: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the current page contains the specified text.

        If the text is not found, this keyword logs the page source using the given log level
        (unless `NONE` is specified) and raises an assertion error.

        Input Parameters:
            - text: str - The text to search for on the page. Required.
            - loglevel: str - Log level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Page Should Contain Text | Welcome |
        | Page Should Contain Text | Login Successful | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.page_should_contain_text(text, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify page contains text '{text}': {str(e)}") from e

    @keyword
    def page_should_not_contain_text(self, text: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the current page does NOT contain the specified text.

        If the text is found, this keyword logs the page source using the given log level
        (unless `NONE` is specified) and raises an assertion error.

        Input Parameters:
            - text: str - The text that should not appear on the page. Required.
            - loglevel: str - Log level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Page Should Not Contain Text | Error |
        | Page Should Not Contain Text | Invalid Login | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.page_should_not_contain_text(text, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify page does not contain text '{text}': {str(e)}") from e

    @keyword
    def page_should_contain_element(self, locator: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the current page contains the element identified by the given locator.

        If the element is not found, this keyword logs the page source using the given log level
        (unless `NONE` is specified) and raises an assertion error.

        Input Parameters:
            - locator: str - The locator used to identify the element. Required.
            - loglevel: str - Log level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Page Should Contain Element | xpath=//button[@id='submit'] |
        | Page Should Contain Element | id=loginForm | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.page_should_contain_element(locator, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify page contains element '{locator}': {str(e)}") from e

    @keyword
    def page_should_not_contain_element(self, locator: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the current page does NOT contain the element identified by the given locator.

        If the element is found, this keyword logs the page source using the specified log level
        (unless `NONE` is used) and raises an assertion error.

        Input Parameters:
            - locator: str - The locator used to identify the element. Required.
            - loglevel: str - Logging level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Page Should Not Contain Element | xpath=//div[@class='error'] |
        | Page Should Not Contain Element | id=alert | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.page_should_not_contain_element(locator, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify absence of element '{locator}': {str(e)}") from e

    @keyword
    def element_should_be_disabled(self, locator: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the element identified by the given locator is disabled.

        If the element is found to be enabled, this keyword logs the page source using
        the given log level and raises an assertion error.

        Input Parameters:
            - locator: str - The locator of the element to check. Required.
            - loglevel: str - Logging level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Should Be Disabled | id=submitBtn |
        | Element Should Be Disabled | xpath=//input[@disabled] | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.element_should_be_disabled(locator, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify element '{locator}' is disabled: {str(e)}") from e

    @keyword
    def element_should_be_enabled(self, locator: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the element identified by the given locator is enabled.

        If the element is found to be disabled, this keyword logs the page source using
        the given log level and raises an assertion error.

        Input Parameters:
            - locator: str - The locator of the element to check. Required.
            - loglevel: str - Logging level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Should Be Enabled | name=username |
        | Element Should Be Enabled | xpath=//input[@id='email'] | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.element_should_be_enabled(locator, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify element '{locator}' is enabled: {str(e)}") from e

    @keyword
    def element_should_be_visible(self, locator: str, loglevel: str = 'INFO') -> None:
        """
        Verifies that the element identified by the given locator is visible on the screen.

        If the element is not visible, this keyword logs the page source using the specified
        log level and raises an assertion error.

        Input Parameters:
            - locator: str - The locator used to identify the element. Required.
            - loglevel: str - Logging level for page source (e.g., INFO, DEBUG, NONE). Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Should Be Visible | id=loginButton |
        | Element Should Be Visible | xpath=//div[@class='visible'] | loglevel=DEBUG |
        """
        try:
            return self.elementtestlibrary.element_should_be_visible(locator, loglevel=loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify visibility of element '{locator}': {str(e)}") from e

    @keyword
    def element_name_should_be(self, locator: str, expected: str) -> None:
        """
        Verifies that the element identified by the given locator has the expected name attribute.

        Input Parameters:
            - locator: str - The locator used to find the element. Required.
            - expected: str - The expected name attribute value. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Name Should Be | id=usernameField | username |
        """
        try:
            return self.elementtestlibrary.element_name_should_be(locator, expected)
        except Exception as e:
            raise Exception(f"Failed to verify name of element '{locator}': {str(e)}") from e

    @keyword
    def element_value_should_be(self, locator: str, expected: str) -> None:
        """
        Verifies that the element identified by the given locator has the expected value attribute.

        Input Parameters:
            - locator: str - The locator used to find the element. Required.
            - expected: str - The expected value attribute. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Value Should Be | id=otpField | 1234 |
        """
        try:
            return self.elementtestlibrary.element_value_should_be(locator, expected)
        except Exception as e:
            raise Exception(f"Failed to verify value of element '{locator}': {str(e)}") from e

    @keyword
    def element_attribute_should_match(self, locator: str, attr_name: str, match_pattern: Union[str, bool], regexp: bool = False) -> None:
        """
        Verifies that the specified attribute of an element matches the expected pattern.

        Supports boolean, string pattern, and regular expression matching. The first matched
        element is used if multiple are found.

        Input Parameters:
            - locator: str - The element locator (e.g., id, xpath). Required.
            - attr_name: str - Name of the attribute to verify. Required.
            - match_pattern: Union[str, bool] - The expected value or pattern. Required.
            - regexp: bool - Whether to treat match_pattern as a regular expression. Optional, defaults to False.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Attribute Should Match | xpath=//*[@text='Login'] | enabled | True |
        | Element Attribute Should Match | xpath=//*[@text='Login'] | text | *Log* |
        | Element Attribute Should Match | xpath=//*[@text='Login'] | text | L.*n | regexp=True |
        """
        try:
            return self.elementtestlibrary.element_attribute_should_match(locator, attr_name, match_pattern, regexp=regexp)
        except Exception as e:
            raise Exception(f"Failed to verify attribute '{attr_name}' for element '{locator}': {str(e)}") from e

    @keyword
    def element_should_contain_text(self, locator: str, expected: str, message: str = '') -> None:
        """
        Verifies that the element identified by the locator contains the expected text.

        Input Parameters:
            - locator: str - The element locator. Required.
            - expected: str - The expected substring. Required.
            - message: str - Custom message to override default assertion error. Optional, defaults to ''.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Should Contain Text | xpath=//*[@id='message'] | Success |
        """
        try:
            return self.elementtestlibrary.element_should_contain_text(locator, expected, message=message)
        except Exception as e:
            raise Exception(f"Failed to verify element '{locator}' contains text '{expected}': {str(e)}") from e

    @keyword
    def element_should_not_contain_text(self, locator: str, expected: str, message: str = '') -> None:
        """
        Verifies that the element identified by the locator does NOT contain the expected text.

        Input Parameters:
            - locator: str - The element locator. Required.
            - expected: str - The text that should not be present. Required.
            - message: str - Custom message to override default assertion error. Optional, defaults to ''.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Should Not Contain Text | xpath=//*[@id='error'] | Invalid Credentials |
        """
        try:
            return self.elementtestlibrary.element_should_not_contain_text(locator, expected, message=message)
        except Exception as e:
            raise Exception(f"Failed to verify element '{locator}' does not contain text '{expected}': {str(e)}") from e

    @keyword
    def element_text_should_be(self, locator: str, expected: str, message: str = '') -> None:
        """
        Verifies that the element identified by the given locator has exactly the expected text.

        This keyword performs an exact match (not a substring match). A custom message can
        be provided for failure.

        Input Parameters:
            - locator: str - The locator used to find the element. Required.
            - expected: str - The expected exact text. Required.
            - message: str - Custom error message for assertion failure. Optional, defaults to ''.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Element Text Should Be | id=loginMessage | Welcome Back |
        """
        try:
            return self.elementtestlibrary.element_text_should_be(locator, expected, message)
        except Exception as e:
            raise Exception(f"Failed to verify text of element '{locator}': {str(e)}") from e

    @keyword
    def get_webelement(self, locator: str) -> WebElement:
        """
        Returns the first matching WebElement object identified by the given locator.

        This keyword can be used when direct access to the underlying WebElement is needed,
        for advanced interactions or external libraries.

        Input Parameters:
            - locator: str - The locator to identify the element. Required.

        Output:
            - WebElement - The matched Selenium WebElement object.

        Error Handling:
            - Raises Exception if the element is not found.

        Examples:
        | ${element}= | Get WebElement | id=myInput |
        | Click Element | ${element} |
        """
        try:
            return self.elementtestlibrary.get_webelement(locator)
        except Exception as e:
            raise Exception(f"Failed to retrieve WebElement for '{locator}': {str(e)}") from e

    @keyword
    def scroll_element_into_view(self, locator: str, max_swipes=8, direction='down', scroll_speed=800) -> WebElement:
        """
        Scrolls the page to bring the element identified by the given locator into view.

        Input Parameters:
            - ``locator``: Element locator (XPath, id=value, name=value, class=value, etc.)
            - ``max_swipes``: Maximum number of swipe attempts before giving up (default: 5)
            - ``direction``: Scroll direction - 'down', 'up', 'left', or 'right' (default: 'down')
            - ``scroll_speed``: Swipe duration in milliseconds (default: 800)
        
        Output:
            - WebElement - The scrolled-into-view WebElement.

        Error Handling:
            - NoSuchElementException: If element not found after max_swipes attempts

        Examples:
        | Scroll Element Into View | //android.widget.TextView[@text='Location'] |
        | Scroll Element Into View | id=submit_button | max_swipes=10 |
        | Scroll Element Into View | xpath=//android.view.View[@content-desc='Settings'] | direction=up |
        | Scroll Element Into View | class=android.widget.Button | max_swipes=8 | direction=down |
        """
        try:
            return self.elementtestlibrary.scroll_element_into_view(locator, max_swipes, direction, scroll_speed)
        except Exception as e:
            raise Exception(f"Failed to scroll element '{locator}' into view: {str(e)}") from e

    @keyword
    def scroll_to_element_by_exact_text(self, element_text: str) -> None:
        """
        Scrolls to an element with the exact text on the screen using Android UIAutomator.

        Input Parameters:
            - element_text: str - The exact text of the element to scroll to. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found or scrolling fails.

        Examples:
        | Scroll To Element By Exact Text | Submit |
        """
        try:
            return self.elementtestlibrary.scroll_to_element_By_Exact_Text(element_text)
        except Exception as e:
            raise Exception(f"Failed to scroll to element with exact text '{element_text}': {str(e)}") from e

    @keyword
    def scroll_to_element_by_exact_text_in_long_view(self, element_text: str, max_swipe_count: str) -> None:
        """
        Scrolls to an element with the exact text in a long view (using maximum swipe limit).

        Input Parameters:
            - element_text: str - The exact text of the element to scroll to. Required.
            - max_swipe_count: str - Maximum swipe attempts to search for the element. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found or scrolling fails.

        Examples:
        | Scroll To Element By Exact Text In Long View | Submit | 5 |
        """
        try:
            return self.elementtestlibrary.scroll_to_element_By_Exact_Text_in_longView(element_text, max_swipe_count)
        except Exception as e:
            raise Exception(f"Failed to scroll in long view to element '{element_text}': {str(e)}") from e

    @keyword
    def scroll_to_element_by_partial_text(self, element_text: str) -> None:
        """
        Scrolls to an element that contains partial text on the screen.

        Input Parameters:
            - element_text: str - Partial text of the element to scroll to. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found or scrolling fails.

        Examples:
        | Scroll To Element By Partial Text | Settings |
        """
        try:
            return self.elementtestlibrary.scroll_to_element_by_Partial_text(element_text)
        except Exception as e:
            raise Exception(f"Failed to scroll to element containing text '{element_text}': {str(e)}") from e

    @keyword
    def scroll_to_element_by_partial_text_in_long_view(self, element_text: str, max_swipe_count: str) -> None:
        """
        Scrolls to an element that contains partial text in a long view with limited swipes.

        Input Parameters:
            - element_text: str - Partial text of the element. Required.
            - max_swipe_count: str - Maximum swipe attempts. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found or scrolling fails.

        Examples:
        | Scroll To Element By Partial Text In Long View | Settings | 5 |
        """
        try:
            return self.elementtestlibrary.scroll_to_element_by_Partial_text_in_longView(element_text, max_swipe_count)
        except Exception as e:
            raise Exception(f"Failed to scroll in long view to element containing text '{element_text}': {str(e)}") from e

    @keyword
    def scroll_to_element_by_description_contains(self, description: str) -> None:
        """
        Scrolls to an element that contains the given content description.

        Input Parameters:
            - description: str - Partial content description of the element. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the element is not found or scrolling fails.

        Examples:
        | Scroll To Element By Description Contains | Settings |
        """
        try:
            return self.elementtestlibrary.scroll_to_element_by_descriptionContains(description)
        except Exception as e:
            raise Exception(f"Failed to scroll to element with description '{description}': {str(e)}") from e

    @keyword
    def get_webelement_in_webelement(self, parent_element: WebElement, locator: Union[str, WebElement]) -> WebElement:
        """
        Returns the first child WebElement found within a given parent WebElement using the provided locator.

        Input Parameters:
            - parent_element: WebElement - The parent WebElement in which to search. Required.
            - locator: Union[str, WebElement] - The locator string or WebElement to find as a child. Required.

        Output:
            - WebElement - The first matching child element.

        Error Handling:
            - Raises Exception if no matching child element is found.

        Examples:
        | ${parent}= | Get Webelement | xpath=//div[@id='container'] |
        | ${child}= | Get Webelement In Webelement | ${parent} | xpath=.//button |
        """
        try:
            return self.elementtestlibrary.get_webelement_in_webelement(parent_element, locator)
        except Exception as e:
            raise Exception(f"Failed to find child element in parent: {str(e)}") from e

    @keyword
    def get_webelements(self, locator: str) -> List[WebElement]:
        """
        Returns a list of WebElements matching the given locator.

        Input Parameters:
            - locator: str - The locator to identify elements (e.g., id, xpath, etc.). Required.

        Output:
            - List[WebElement] - A list of matching WebElements.

        Error Handling:
            - Raises Exception if no elements are found or locator is invalid.

        Examples:
        | @{elements}= | Get Webelements | id=my_element |
        | Click Element | @{elements}[1] |
        """
        try:
            return self.elementtestlibrary.get_webelements(locator)
        except Exception as e:
            raise Exception(f"Failed to get web elements by locator '{locator}': {str(e)}") from e

    @keyword
    def get_element_attribute(self, locator: str, attribute: str) -> str:
        """
        Returns the value of a specified attribute from an element identified by the given locator.

        Input Parameters:
            - locator: str - The locator to find the element. Required.
            - attribute: str - The attribute to retrieve (e.g., name, value, enabled). Required.

        Output:
            - str - The value of the specified attribute.

        Error Handling:
            - Raises Exception if the element or attribute is not found.

        Examples:
        | ${value}= | Get Element Attribute | id=username | value |
        """
        try:
            return self.elementtestlibrary.get_element_attribute(locator, attribute)
        except Exception as e:
            raise Exception(f"Failed to get attribute '{attribute}' from element '{locator}': {str(e)}") from e

    @keyword
    def get_element_location(self, locator: str) -> Dict[str, int]:
        """
        Returns the location of the element identified by the given locator.

        Input Parameters:
            - locator: str - The locator to find the element. Required.

        Output:
            - Dict[str, int] - A dictionary with 'x' and 'y' coordinates of the element.

        Error Handling:
            - Raises Exception if element is not found or location retrieval fails.

        Examples:
        | ${loc}= | Get Element Location | xpath=//button[@id='login'] |
        """
        try:
            return self.elementtestlibrary.get_element_location(locator)
        except Exception as e:
            raise Exception(f"Failed to get location of element '{locator}': {str(e)}") from e

    @keyword
    def get_element_size(self, locator: str) -> Dict[str, int]:
        """
        Returns the size (width and height) of the element identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to find the element. Required.

        Output:
            - Dict[str, int] - A dictionary containing 'width' and 'height' keys.

        Error Handling:
            - Raises Exception if element is not found or size retrieval fails.

        Examples:
        | ${size}= | Get Element Size | id=login_button |
        """
        try:
            return self.elementtestlibrary.get_element_size(locator)
        except Exception as e:
            raise Exception(f"Failed to get size of element '{locator}': {str(e)}") from e

    @keyword
    def get_element_rect(self, locator: str) -> Dict[str, int]:
        """
        Returns the location and size (rect) of the element identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to find the element. Required.

        Output:
            - Dict[str, int] - A dictionary containing 'x', 'y', 'width', and 'height'.

        Error Handling:
            - Raises Exception if element is not found or rect retrieval fails.

        Examples:
        | ${rect}= | Get Element Rect | xpath=//button[@text='Submit'] |
        """
        try:
            return self.elementtestlibrary.get_element_rect(locator)
        except Exception as e:
            raise Exception(f"Failed to get rect of element '{locator}': {str(e)}") from e

    @keyword
    def get_text(self, locator: str) -> str:
        """
        Returns the text content of the element identified by the given locator.

        Input Parameters:
            - locator: str - The locator used to find the element. Required.

        Output:
            - str - The text value of the element.

        Error Handling:
            - Raises Exception if element is not found or text retrieval fails.

        Examples:
        | ${text}= | Get Text | xpath=//*[contains(@text, 'Welcome')] |
        """
        try:
            return self.elementtestlibrary.get_text(locator)
        except Exception as e:
            raise Exception(f"Failed to get text from element '{locator}': {str(e)}") from e

    @keyword
    def get_matching_xpath_count(self, xpath: str) -> str:
        """
        Returns the number of elements matching the given XPath.

        Do not include the 'xpath=' prefix. XPath is assumed.

        Input Parameters:
            - xpath: str - The XPath string without 'xpath=' prefix. Required.

        Output:
            - str - Number of matching elements as a string.

        Error Handling:
            - Raises Exception if xpath evaluation fails.

        Examples:
        | ${count}= | Get Matching XPath Count | //android.widget.TextView[@text='Hello'] |
        """
        try:
            return self.elementtestlibrary.get_matching_xpath_count(xpath)
        except Exception as e:
            raise Exception(f"Failed to get matching xpath count for '{xpath}': {str(e)}") from e

    @keyword
    def text_should_be_visible(self, text: str, exact_match: bool = False, loglevel: str = 'INFO') -> None:
        """
        Verifies that an element with the given text is visible.

        Input Parameters:
            - text: str - The text to search for. Required.
            - exact_match: bool - Whether to match the exact text. Optional, defaults to False.
            - loglevel: str - Logging level if text is not found. Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Text Should Be Visible | Submit |
        """
        try:
            return self.elementtestlibrary.text_should_be_visible(text, exact_match, loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify text '{text}' visibility: {str(e)}") from e

    @keyword
    def xpath_should_match_x_times(self, xpath: str, count: int, error: Optional[str] = None, loglevel: str = 'INFO') -> None:
        """
        Verifies that the given XPath matches a specific number of elements.

        Do not use the 'xpath=' prefix in the XPath.

        Input Parameters:
            - xpath: str - The XPath to evaluate. Required.
            - count: int - Expected number of matches. Required.
            - error: str - Custom error message. Optional, defaults to None.
            - loglevel: str - Logging level if assertion fails. Optional, defaults to 'INFO'.

        Output:
            - None

        Error Handling:
            - Raises Exception for other unexpected errors.

        Examples:
        | Xpath Should Match X Times | //android.widget.Button | 3 |
        """
        try:
            return self.elementtestlibrary.xpath_should_match_x_times(xpath, count, error, loglevel)
        except Exception as e:
            raise Exception(f"Failed to verify XPath '{xpath}' matches count {count}: {str(e)}") from e