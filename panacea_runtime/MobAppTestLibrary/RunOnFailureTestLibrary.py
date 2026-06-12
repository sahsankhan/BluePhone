from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword

@library
class RunOnFailureTestLibrary:
    """
    A MobAppTestLibrary for managing keyword execution on failure.

    This library provides a Robot Framework keyword to register a fallback keyword
    that should be executed automatically whenever a keyword from the library fails.
    Commonly used for actions like capturing screenshots or logging diagnostics
    upon test failures.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the RunOnFailureTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.runonfailuretestlibrary = mob

    @keyword
    def register_keyword_to_run_on_failure(self, keyword: str) -> str:
        """
        Registers a keyword to be executed automatically on failure of any library keyword.

        Input Parameters:
            - keyword: str - The keyword to be run on failure (e.g., 'Capture Page Screenshot'). Use 'Nothing' to disable this functionality. Required.

        Output:
            - str - The previously registered failure keyword (or 'Nothing' if none was set).

        Error Handling:
            - Raises Exception if registration of the failure keyword fails.
            
        """
        try:
            return self.runonfailuretestlibrary.register_keyword_to_run_on_failure(keyword)
        except Exception as e:
            raise Exception(f"Failed to register keyword to run on failure: {e}") from e