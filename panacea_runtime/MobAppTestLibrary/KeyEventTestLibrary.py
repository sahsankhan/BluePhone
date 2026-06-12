from typing import Optional
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword

@library
class KeyEventTestLibrary:
    """
    A MobAppTestLibrary for managing Android key events and clipboard operations.

    This library provides Robot Framework keywords to send key presses,
    long key presses, and clipboard text operations on Android devices.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the KeyEventTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.keyeventtestlibrary = mob

    @keyword
    def press_keycode(self, keycode: int, metastate: Optional[int] = None) -> None:
        """
        Sends a press of the specified keycode to the Android device.

        Input Parameters:
            - keycode: int - The keycode to send. Required.
            - metastate: int - Meta state for key modifiers like Shift, Alt. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if sending keycode fails.

        Example:
            | Press Keycode | 66 | # Sends Enter key |
        """
        try:
            return self.keyeventtestlibrary.press_keycode(keycode, metastate)
        except Exception as e:
            raise Exception(f"Failed to press keycode {keycode} with metastate {metastate}: {e}") from e

    @keyword
    def long_press_keycode(self, keycode: int, metastate: Optional[int] = None) -> None:
        """
        Sends a long press of the specified keycode to the Android device.

        Input Parameters:
            - keycode: int - The keycode to send. Required.
            - metastate: int - Meta state for key modifiers. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises Exception if sending long press keycode fails.

        Example:
            | Long Press Keycode | 66 | # Long presses Enter key |
        """
        try:
            return self.keyeventtestlibrary.long_press_keycode(keycode, metastate)
        except Exception as e:
            raise Exception(f"Failed to long press keycode {keycode} with metastate {metastate}: {e}") from e

    @keyword
    def set_given_text_clipBoard(self, text: str) -> None:
        """
        Sets the given text to the device clipboard.

        Input Parameters:
            - text: str - Text to set on the clipboard. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if setting clipboard text fails.

        Example:
            | Set Given Text ClipBoard | Hello, World! |
        """
        try:
            return self.keyeventtestlibrary.set_Given_Text_clipBoard(text)
        except Exception as e:
            raise Exception(f"Failed to set clipboard text '{text}': {e}") from e

    @keyword
    def get_text_from_clipboard(self) -> Optional[str]:
        """
        Retrieves text from the device clipboard.

        Input Parameters:
            - None

        Output:
            - Optional[str] - The clipboard text or None if failed.

        Error Handling:
            - Raises Exception if retrieving clipboard text fails.
            
        Example:
            | ${clipboard_text}= | Get Text From Clipboard |
        """
        try:
            return self.keyeventtestlibrary.getText_From_Clipboard()
        except Exception as e:
            raise Exception(f"Failed to get text from clipboard: {e}") from e