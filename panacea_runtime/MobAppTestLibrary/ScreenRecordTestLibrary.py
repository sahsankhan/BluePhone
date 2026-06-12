from typing import Optional
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from robot.api.deco import library, keyword

@library
class ScreenRecordTestLibrary:
    """
    A MobAppTestLibrary for managing Android screen recording via ADB.

    This library provides Robot Framework keywords to start and stop screen recording
    on Android devices. Recordings are saved in chunks and merged into a single
    compressed video file using FFmpeg.

    Example usage in Robot Framework:
    | *** Settings ***
    | Library    MobAppTestLibrary
    """

    def __init__(self, mob: ZmxMobAppTestLibrary) -> None:
        """Initialize the ScreenRecordTestLibrary.

        Args:
            mob (MobAppTestLibrary): Instance of MobAppTestLibrary.
        """
        self.screenrecordtestlibrary = mob

    @keyword
    def start_screen_recording(self, report_dir: str, udid: Optional[str] = None) -> None:
        """
        Starts continuous screen recording on the Android device using ADB.

        Input Parameters:
            - report_dir: str - Directory to store recording chunks and final video. Required.
            - udid: str - Device UDID. Optional, defaults to None.

        Output:
            - None

        Error Handling:
            - Raises ValueError if UDID is not provided.
            - Raises Exception if recording thread fails to start.

        Example:
            | Start Screen Recording  | ${OUTPUT DIR}/recordings  | emulator-5554 |
        """
        try:
            return self.screenrecordtestlibrary.start_screen_recording(report_dir, udid=udid)
        except Exception as e:
            raise Exception(f"Failed to start screen recording for device {udid}: {e}") from e

    @keyword
    def stop_screen_recording(self, udid: str) -> str:
        """
        Stops recording, merges recorded chunks, compresses the final video, and performs cleanup.

        Input Parameters:
            - udid: str - Device UDID to stop the corresponding recording session. Required.

        Output:
            - str - Path to the merged and compressed video file.

        Error Handling:
            - Raises Exception if stopping or merging fails.

        Example:
            | Stop Screen Recording  | emulator-5554 |
        """
        try:
            return self.screenrecordtestlibrary.stop_screen_recording(udid)
        except Exception as e:
            raise Exception(f"Failed to stop and finalize screen recording for device {udid}: {e}") from e