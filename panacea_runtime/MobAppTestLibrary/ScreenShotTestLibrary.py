from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword
from selenium.common.exceptions import WebDriverException

@library
class ScreenShotTestLibrary:
    """
    A MobAppTestLibrary for capturing screenshots of the current mobile screen.

    This library provides Robot Framework keywords to take and optionally save
    screenshots from Android or iOS devices. Screenshots can either be saved to a
    file or embedded directly into the Robot Framework log.html as a Base64 image.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary):
        """Initialize the ScreenShotTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.screenshottestlibrary = mob

    @keyword
    def capture_page_screenshot(self, filename=None):
        """
        Takes a screenshot of the current page and embeds it into the Robot log.

        If `filename` is provided, the screenshot is saved to that file and
        linked in the log. If not, it is embedded directly as a Base64 image
        into the log without saving to disk.

        Input Parameters:
            - filename: str - File path to save the screenshot. Optional, defaults to None.

        Output:
            - Optional[str] - File path if saved; None if only embedded in log.

        Error Handling:
            - Raises Exception for all other unexpected failures.

        Example:
            | Capture Page Screenshot    screenshot.png |
            | Capture Page Screenshot |
        """
        try:
            return self.screenshottestlibrary.capture_page_screenshot(filename)
        except (WebDriverException, FileNotFoundError, OSError, IOError) as e:
            raise Exception(f"Failed to capture page screenshot (filename={filename}): {e}") from e