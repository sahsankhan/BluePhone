from typing import Union
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword

@library
class MobileUserDefinedKeywordsTestLibrary:
    """
    A MobAppTestLibrary for managing custom mobile utilities and user-defined functions.

    This library provides Robot Framework keywords for extracting substrings from text
    and launching the Android camera app.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the MobileUserDefinedKeywordsTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.mobileuserdefinedkeywordstestlibrary = mob

    @keyword
    def get_text_from_index(self, txt: str, startIndex: Union[int, str], lastIndex: Union[int, str]) -> str:
        """
        Extracts a substring from the given text between startIndex and lastIndex.

        Input Parameters:
            - txt: str - The source string. Required.
            - startIndex: Union[int, str] - Starting index for extraction. Required.
            - lastIndex: Union[int, str] - Ending index (exclusive) for extraction. Required.

        Output:
            - str - The extracted substring.

        Error Handling:
            - Raises Exception if the slicing operation fails.

        Example:
            | ${result}=  | Get Text From Index  | Hello, World!  | 0  | 5  |
            | Should Be Equal  | ${result}  | Hello  |
        """
        try:
            return self.mobileuserdefinedkeywordstestlibrary.get_text_from_index(txt, startIndex, lastIndex)
        except Exception as e:
            raise Exception(f"Failed to extract text from index {startIndex} to {lastIndex}: {e}") from e

    @keyword
    def get_text_from_startindex(self, txt: str, startIndex: Union[int, str]) -> str:
        """
        Extracts a substring from the given text starting at startIndex to the end.

        Input Parameters:
            - txt: str - The source string. Required.
            - startIndex: Union[int, str] - Starting index for extraction. Required.

        Output:
            - str - The extracted substring.

        Error Handling:
            - Raises Exception if the slicing operation fails.

        Example:
            | ${result}=  | Get Text From Startindex  | Hello, World!  | 7  |
            | Should Be Equal  | ${result}  | World!  |
        """
        try:
            return self.mobileuserdefinedkeywordstestlibrary.get_text_from_startindex(txt, startIndex)
        except Exception as e:
            raise Exception(f"Failed to extract text from start index {startIndex}: {e}") from e

    @keyword
    def launch_camera_app(self) -> None:
        """
        Launches the camera application on an Android device using an ADB shell command.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if launching the camera app fails.

        Example:
            | Launch Camera App  |
        """
        try:
            return self.mobileuserdefinedkeywordstestlibrary.launch_camera_app()
        except Exception as e:
            raise Exception(f"Failed to launch camera app: {e}") from e