from robot.api.deco import library, keyword
import subprocess
from typing import Optional, Tuple, Union, Any
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import re
from datetime import datetime, timedelta
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement
from selenium.common.exceptions import *
import yaml
from robot.api import logger
from panacea_runtime.MobAppTestLibrary import MobAppTestLibrary
from fuzzywuzzy import fuzz
from robot.libraries.BuiltIn import BuiltIn
import time
import unicodedata
from appium.webdriver.common.mobileby import MobileBy as AppiumBy

@library
class CommonMethods:    
    mob: MobAppTestLibrary
    
    def __init__(self):
        self.driver = None

    @keyword
    def get_driver_instance(self):
        self.driver = self.mob._current_application()
        
    @keyword
    def load_yaml(self, path: str) -> dict:
        """
        Loads a YAML file safely, ignoring invalid UTF-8 bytes.
        Returns an empty dict if the file is empty.
        
        Args:
            path (str): Path to the YAML file.
        
        Returns:
            dict: Parsed YAML content.
        """
        logger.info(f"[INFO] Loading YAML file: {path}")

        try:
            # Read YAML file as string (ignore invalid bytes)
            with open(path, "r", encoding="utf-8", errors="ignore") as file:
                yaml_string = file.read()

            # Parse YAML string safely
            data = yaml.safe_load(yaml_string) or {}

            logger.info("[INFO] YAML file loaded successfully")
            return data

        except FileNotFoundError:
            logger.error(f"[ERROR] YAML file not found -> {path}")
            raise

        except yaml.YAMLError as e:
            logger.error(f"[ERROR] YAML parsing failed -> {e}")
            raise

        except Exception as e:
            logger.error(f"[ERROR] Unexpected error while loading YAML -> {e}")
            raise

    @keyword
    def press_speaker_button(self, udid: str):
        """
        Simulates pressing the speaker button using adb sendevent.

        Args:
            udid (str): The device UDID/serial to target.
        """
        commands = [
            ["adb", "-s", udid, "shell", "sendevent", "/dev/input/event0", "4", "4", "37"],
            ["adb", "-s", udid, "shell", "sendevent", "/dev/input/event0", "1", "61", "1"],
            ["adb", "-s", udid, "shell", "sendevent", "/dev/input/event0", "0", "0", "0"],
            ["adb", "-s", udid, "shell", "sendevent", "/dev/input/event0", "4", "4", "37"],
            ["adb", "-s", udid, "shell", "sendevent", "/dev/input/event0", "1", "61", "0"],
            ["adb", "-s", udid, "shell", "sendevent", "/dev/input/event0", "0", "0", "0"]
        ]
        for command in commands:
            try:
                logger.info(f"[INFO] Executing: {' '.join(command)}")
                result = subprocess.run(command, check=True, capture_output=True, text=True)
                if result.stdout.strip():
                    logger.info(f"[INFO] Command output: {result.stdout.strip()}")
            except subprocess.CalledProcessError as e:
                logger.info(f"[ERROR] Command execution failed: {e.stderr.strip()}")
                raise RuntimeError(f"Failed to execute sendevent: {e.stderr.strip()}")
        logger.info("[INFO] Pressed Speaker Button", console=True)

    @keyword
    def get_text_from_element(
            self,
            locator: Tuple[By, str],
            timeout: int = 20,
            visible: bool = True
    ) -> Optional[str]:
        """
        Retrieves the visible text from a WebElement.
        Waits for the element to be present or visible based on 'visible' flag.
        """
        try:
            logger.info(f"[INFO] Attempting to fetch text from element: {locator} "
                        f"(Timeout: {timeout}s, Visible: {visible})")

            cond = "visible" if visible else "present"
            element = self.find(locator, timeout, cond)

            if element:
                text = element.text.strip()
                logger.info(f"[INFO] Fetched text: '{text}' from element: {locator}")
                return text if text else None

            logger.warn(f"[WARN] Element not found or text is empty for locator: {locator}")
            return None

        except Exception as e:
            logger.error(f"[ERROR] Failed to get text from element {locator}: {e}")
            return None


    @keyword
    def scroll_page(self, direction: str = "down") -> None:
        """
        Scrolls the screen vertically using swipe gestures.
        Compatible with UIAutomator1 (Android 4.x).
        """
        try:
            logger.info("[INFO] Attempting to perform a scroll gesture on the page.")
            window_size = self.driver.get_window_size()
            width = window_size["width"]
            height = window_size["height"]

            start_x = int(width * 0.5)

            if direction == "down":
                start_y = int(height * 0.8)
                end_y   = int(height * 0.2)
            elif direction == "up":
                start_y = int(height * 0.2)
                end_y   = int(height * 0.8)
            elif direction == "left":
                start_x = int(width * 0.8)
                end_x   = int(width * 0.2)
                self.driver.swipe(start_x, int(height * 0.5), end_x, int(height * 0.5), duration=800)
                logger.info("[INFO] Scroll gesture executed successfully.")
                return
            elif direction == "right":
                start_x = int(width * 0.2)
                end_x   = int(width * 0.8)
                self.driver.swipe(start_x, int(height * 0.5), end_x, int(height * 0.5), duration=800)
                logger.info("[INFO] Scroll gesture executed successfully.")
                return
            else:
                raise ValueError(f"Unsupported scroll direction: '{direction}'. Use down/up/left/right.")

            self.driver.swipe(start_x, start_y, start_x, end_y, duration=800)
            logger.info("[INFO] Scroll gesture executed successfully.")

        except Exception as e:
            logger.error(f"[ERROR] Scroll gesture execution failed: {e}")
            raise AssertionError(f"Scroll gesture execution failed: {e}")


    @keyword
    def no_duration_is_displayed_for_missed_calls(self, locator) -> None:
        """
        Verifies that missed call entries display only the call time
        and do not display any call duration.

        Raises:
            AssertionError: If the call time is missing, incorrectly formatted,
                            or if a call duration is displayed for a missed call.
        """
        try:
            logger.info(f"[INFO] Verifying missed call time for locator: {locator}")

            # Convert RF locator to tuple
            locator_tuple = self.rf_locator_to_tuple(locator)

            # Fetch call time text
            call_time_text = self.get_text_from_element(locator_tuple)
            logger.info(f"[DEBUG] Fetched call time text: '{call_time_text}'")

            # Guard against None returned by get_text_from_element
            assert call_time_text is not None, "Element found but returned None text — element may not have a text attribute."

            # Check if call time is present
            assert call_time_text.strip(), "Call time is not displayed for missed calls."
            logger.info("[INFO] Call time is displayed")

            # Validate 12-hour time format
            time_pattern = r"\b\d{1,2}:\d{2}\s?(AM|PM)\b"
            assert re.search(time_pattern, call_time_text), f"Invalid or missing time format: '{call_time_text}'"
            logger.info("[INFO] Call time format is valid (12-hour format)")

            # Ensure no duration text
            assert "sec" not in call_time_text.lower(), f"Duration is displayed for missed calls: '{call_time_text}'"
            assert "|" not in call_time_text, f"Duration separator '|' found in missed call time: '{call_time_text}'"
            logger.info("[INFO] No duration is displayed for the missed call")

        except Exception as e:
            logger.error(f"[ERROR] Failed to verify missed call duration: {e}")
            raise AssertionError(str(e))


    @keyword
    def find(
        self,
        locator: Union[Tuple[By, str], None],
        timeout: int = 20,
        condition: str = "visible",
        condition_value: Optional[Any] = None
    ) -> Optional[WebElement]:
        """
        A unified finder that waits on any supported condition, then returns
        the element (or True for non-element conditions), or None on timeout.
        """
        try:
            wait = WebDriverWait(self.driver, timeout)
            logger.info(f"[DEBUG] Waiting for condition '{condition}' on locator: {locator} for {timeout}s")

            try:
                if condition == "visible":
                    element = wait.until(EC.visibility_of_element_located(locator))
                elif condition == "present":
                    element = wait.until(EC.presence_of_element_located(locator))
                elif condition == "clickable":
                    element = wait.until(EC.element_to_be_clickable(locator))
                elif condition == "text_present":
                    if condition_value is None:
                        raise ValueError("'text_present' needs a condition_value")
                    wait.until(EC.text_to_be_present_in_element(locator, condition_value))
                    logger.info(f"[DEBUG] Text '{condition_value}' present in element {locator}")
                    return True
                elif condition == "alert_present":
                    wait.until(EC.alert_is_present())
                    logger.info("[DEBUG] Alert is present")
                    return True
                elif condition == "timeout":
                    end_time = datetime.now() + timedelta(seconds=timeout)
                    wait.until(lambda d: datetime.now() >= end_time)
                    logger.info(f"[DEBUG] Timeout wait completed: {timeout}s")
                    return True
                else:
                    raise ValueError(f"Unsupported condition: {condition}")

                logger.info(f"[DEBUG] Condition '{condition}' satisfied for locator: {locator}")
                return element

            except TimeoutException:
                logger.warn(f"[WARN] Timeout waiting for condition '{condition}' on locator: {locator}")
                return None

        except Exception as e:
            logger.error(f"[ERROR] Error in find method for locator {locator}: {e}")
            return None
        
    def rf_locator_to_tuple(self, rf_locator: str):
        """
        Convert Robot Framework locator (like 'id=clrcap.CCClient:id/count')
        to Selenium/Appium locator tuple (By.ID, 'clrcap.CCClient:id/count').

        Args:
            rf_locator (str): Robot Framework style locator

        Returns:
            tuple: Selenium/Appium compatible locator (By.*, value)

        Raises:
            ValueError: If the locator format or strategy is invalid
        """
        try:
            if "=" not in rf_locator:
                raise ValueError(f"Invalid RF locator: {rf_locator}")

            strategy, locator = rf_locator.split("=", 1)
            strategy = strategy.strip().lower()
            locator = locator.strip()

            mapping = {
                "id": By.ID,
                "xpath": By.XPATH,
                "css": By.CSS_SELECTOR,
                "name": By.NAME,
                "class": By.CLASS_NAME,
                "accessibility_id": "accessibility id",  # Appium only
            }

            if strategy not in mapping:
                raise ValueError(f"Unknown locator strategy: {strategy}")

            locator_tuple = (mapping[strategy], locator)

            logger.info(f"[DEBUG] Converted RF locator '{rf_locator}' → {locator_tuple}")
            print(f"[DEBUG] Converted RF locator '{rf_locator}' → {locator_tuple}")

            return locator_tuple

        except Exception as e:
            logger.error(f"[ERROR] Failed to convert RF locator '{rf_locator}': {e}")
            raise


    @keyword
    def verify_recent_call_record_is_present(
        self,
        CallNumberLocator,
        did: str,
        timeout: int = 3
    ) -> bool:

        try:
            print(f"[DEBUG] Locator: {CallNumberLocator}")
            logger.info(f"[INFO] Verifying recent call record for DID: {did}")

            try:
                # Convert locator to tuple
                locator_tuple = self.rf_locator_to_tuple(CallNumberLocator)
                print(f"[DEBUG] Locator tuple: {locator_tuple}")
                logger.info(f"[INFO] Converted locator to tuple: {locator_tuple}")

                # Find the element
                call_number_element = self.find(locator_tuple, timeout=timeout)
                if not call_number_element:
                    print("[DEBUG] Call number element NOT found")
                    logger.warn("[WARN] Call number element not found on screen")
                    return False
                logger.info("[INFO] Call number element found")

                # Extract and normalize numbers
                first_number_raw = call_number_element.text.strip()
                print(f"[DEBUG] Raw call number text: {first_number_raw}")
                logger.info(f"[INFO] Raw call number from UI: {first_number_raw}")

                first_number = self.convert_to_plain_number(first_number_raw)
                did_number = self.convert_to_plain_number(did)

                print(f"[DEBUG] Normalized UI number: {first_number}")
                print(f"[DEBUG] Normalized DID: {did_number}")
                logger.info(f"[INFO] Normalized UI number: {first_number}")
                logger.info(f"[INFO] Normalized DID: {did_number}")

                # Compare
                result = (
                    first_number.endswith(did_number)
                    or did_number.endswith(first_number)
                )
                print(f"[DEBUG] Comparison result: {result}")
                logger.info(f"[INFO] DID match result: {result}")

                return result

            except Exception as e:
                logger.error(f"[ERROR] Failed to verify recent call record: {e}")
                raise AssertionError(
                    f"Failed to verify recent call record: {e}"
                )

        except Exception as e:
            logger.error(f"[ERROR] Unexpected error in verify_recent_call_record_is_present: {e}")
            raise


    @keyword
    def convert_to_plain_number(self, number: str) -> str:
        """
        Converts formatted phone numbers into a plain digit-only string.

        Example:
            "+1(123)456-7890" → "1234567890"

        Steps:
            - Removes country code (+1, +91, etc.)
            - Removes parentheses, hyphens, spaces, and any non-digit characters

        Returns:
            str: Clean 10-digit number (or full digits if longer)
        """
        try:
            if not number:
                logger.warn("Input number is empty or None. Returning empty string.")
                return ""

            try:
                logger.info(f"Original number: {number}")

                # Remove everything except digits
                digits_only = re.sub(r"\D", "", number)
                logger.info(f"Digits only: {digits_only}")

                # Remove leading country code '1' if present and number is longer than 10 digits
                if digits_only.startswith("1") and len(digits_only) > 10:
                    digits_only = digits_only[1:]
                    logger.info(f"Removed leading country code '1': {digits_only}")

                logger.info(f"Final plain number: {digits_only}")
                return digits_only

            except Exception as e:
                logger.error(f"Error while converting number '{number}' to plain digits: {e}")
                return ""

        except Exception as e:
            logger.error(f"Unexpected error in convert_to_plain_number: {e}")
            return ""


    def click(
        self,
        locator: tuple,
        timeout: int = 20
    ) -> bool:
        """
        Wait for clickability and click.
        Returns True on success, False otherwise.
        """
        try:
            logger.info(f"Attempting to click element: {locator}")

            el = self.find(locator, timeout, "clickable")

            if el:
                try:
                    el.click()
                    logger.info(f"Successfully clicked element: {locator}")
                    return True
                except Exception as e:
                    logger.error(f"Failed to click element {locator}: {e}")
                    return False
            else:
                logger.warn(f"Element not clickable or not found: {locator}")
                return False

        except Exception as e:
            logger.error(f"Error in click method for locator {locator}: {e}")
            return False

    @keyword
    def capture_all_captions(
            self,
            duration: int = 60,
            poll_interval: float = 0.3,
            element_retries: int = 3,
            captioner_ready_timeout: int = 60
    ) -> list[str]:

        CAPTION_ID = "clrcap.CCClient:id/caption_invisible_reflection"
        PLACEHOLDERS = {
            "connecting to captioner",
            "waiting for an available captioner",
            "clearcaptions started at",
            "captioner #",
        }

        # Load failure keywords from test data
        test_data_path = BuiltIn().get_variable_value("${TEST_DATA_YAML_FILE}")
        data = self.load_yaml(test_data_path)
        failure_keywords = data.get("caption_failure_keywords", [])

        logger.info("[INFO] Waiting for captioner to become ready...")

        # ── Phase 1: Wait until real captions appear ──
        ready_deadline = time.time() + captioner_ready_timeout
        captioner_ready = False

        while time.time() < ready_deadline:
            try:
                elements = self.driver.find_elements(AppiumBy.ID, CAPTION_ID)
                for el in elements:
                    try:
                        text = el.text.strip().lower()
                        if text and not any(p in text for p in PLACEHOLDERS):
                            captioner_ready = True
                            break
                    except Exception:
                        pass
            except Exception:
                pass
            if captioner_ready:
                break
            time.sleep(0.5)

        if not captioner_ready:
            try:
                report_dir = BuiltIn().get_variable_value("${REPORT_DIR}")
                BuiltIn().run_keyword(
                    "Capture Page Screenshot",
                    f"{report_dir}/captioner_not_ready_{int(time.time())}.png"
                )
            except Exception as ss_err:
                logger.warn(f"[WARN] Failed to capture screenshot: {ss_err}")
            raise AssertionError(
                f"Captioner did not become ready within {captioner_ready_timeout}s."
            )

        logger.info("[INFO] Captioner ready — starting caption capture")

        # ── Phase 2: Rapid continuous polling ──
        end_time = time.time() + duration
        all_captions: list[str] = []
        last_full_text: str = ""       # tracks the last seen full cumulative text

        while time.time() < end_time:
            try:
                elements = self.driver.find_elements(AppiumBy.ID, CAPTION_ID)

                if not elements:
                    time.sleep(poll_interval)
                    continue

                # Get the LAST element — it contains the most complete cumulative text
                for idx in [len(elements) - 1]:
                    retries = 0
                    while retries < element_retries:
                        try:
                            current_elements = self.driver.find_elements(AppiumBy.ID, CAPTION_ID)
                            if not current_elements:
                                break
                            el = current_elements[-1]

                            text = el.text.strip()

                            if text:
                                try:
                                    cleaned = unicodedata.normalize("NFKC", text)
                                    cleaned = cleaned.encode("utf-8", "ignore").decode("utf-8")
                                    cleaned = " ".join(cleaned.split())
                                except Exception:
                                    cleaned = str(text).encode("utf-8", "ignore").decode("utf-8")
                                    cleaned = " ".join(cleaned.split())

                                if any(p in cleaned.lower() for p in PLACEHOLDERS):
                                    logger.debug(f"[DEBUG] Skipping placeholder: {cleaned}")
                                    break

                                # ── Extract only NEW text appended since last poll ──
                                if cleaned == last_full_text:
                                    break  # No change, skip

                                if cleaned.startswith(last_full_text):
                                    # New text is an extension — extract only the new part
                                    new_part = cleaned[len(last_full_text):].strip()
                                else:
                                    # Caption window reset/scrolled — treat entire text as new
                                    new_part = cleaned

                                if new_part:
                                    last_full_text = cleaned
                                    all_captions.append(new_part)

                                    try:
                                        logger.info(f"Caption: {new_part}", console=True)
                                    except Exception:
                                        logger.info("Caption: [UNPRINTABLE TEXT]")

                                    for keyword in failure_keywords:
                                        if keyword.lower() in new_part.lower():
                                            msg = f"Found failure keyword in caption: '{new_part}'"
                                            logger.error(msg)
                                            raise AssertionError(msg)
                            break

                        except StaleElementReferenceException:
                            retries += 1
                            logger.debug(f"[DEBUG] Stale element, retry {retries}")
                            time.sleep(0.1)
                        except AssertionError:
                            raise
                        except Exception as e:
                            logger.warn(f"[WARN] Failed reading caption: {e}")
                            break

                time.sleep(poll_interval)

            except AssertionError:
                raise
            except Exception as loop_err:
                logger.warn(f"[WARN] Exception during polling loop: {loop_err}")
                time.sleep(0.3)

        logger.info(f"[INFO] Caption capture completed, total new segments: {len(all_captions)}")
        return all_captions

    @keyword
    def compare_captions(
            self,
            duration: int = 60,
            min_similarity: int = 60
    ) -> None:
        """
        Compares expected captions with actual captured captions.
 
        Raises:
            AssertionError if captions do not meet the required similarity threshold.
        """
 
        logger.info(f"[INFO] Starting caption comparison for duration: {duration}s")
 
        test_data_path = BuiltIn().get_variable_value("${TEST_DATA_YAML_FILE}")
        data = self.load_yaml(test_data_path)
        expected_caption = data.get("audio_caption_script", {}).get("script_2", "")
 
        # Capture actual captions
        actual_caption_fragments = self.capture_all_captions(duration)
 
        # Normalize actual caption
        if isinstance(actual_caption_fragments, list):
            actual_caption = " ".join(actual_caption_fragments)
        else:
            actual_caption = str(actual_caption_fragments)
 
        actual_caption = actual_caption.replace("\n", " ").strip()
        expected_caption = expected_caption.replace("\n", " ").strip()
 
        logger.info(f"[INFO] Expected Caption: {expected_caption}")
        logger.info(f"[INFO] Actual Caption:   {actual_caption}")
 
        # Compute similarity (better for ASR text)
        similarity = fuzz.token_set_ratio(
            expected_caption.lower(),
            actual_caption.lower()
        )
 
        logger.info(
            f"[INFO] Caption similarity: {similarity}% "
            f"(Minimum required: {min_similarity}%)",
            console=True
        )
 
        # Enforce threshold
        if similarity < min_similarity:
            logger.error("[ERROR] Caption similarity below threshold", console=True)
            raise AssertionError(
                f"Caption similarity below threshold.\n"
                f"Expected: {expected_caption}\n"
                f"Actual:   {actual_caption}\n"
                f"Similarity: {similarity}%"
            )
 
        logger.info("[INFO] Caption comparison passed successfully", console=True)

    def _adb_shell(self, *args: str, udid: str = "") -> subprocess.CompletedProcess:
        command = ["adb"]
        if udid:
            command += ["-s", udid]
        command += ["shell", *args]
        return subprocess.run(command, capture_output=True, text=True)

    @keyword
    def get_device_brightness(self, udid: str = "") -> str:
        try:
            result = self._adb_shell(
                "cat",
                "/sys/class/backlight/panel0-backlight/brightness",
                udid=udid,
            )
            if result.returncode != 0:
                raise Exception(result.stderr.strip() or "ADB command failed")
            brightness = result.stdout.strip()
            logger.info(f"Device current brightness value: {brightness}")
            return brightness
        except Exception as e:
            raise Exception(f"Failed to get device brightness: {e}") from e

    @keyword
    def verify_device_display_state(self, expected_state: str = "ON", udid: str = "") -> str:
        try:
            result = self._adb_shell(
                "cat",
                "/sys/class/backlight/panel0-backlight/brightness",
                udid=udid,
            )
            if result.returncode != 0:
                raise Exception(result.stderr.strip() or "ADB command failed")
            brightness = result.stdout.strip()
            actual_state = "OFF" if int(brightness) == 1 else "ON"
            logger.info(
                f"Display brightness={brightness}, actual={actual_state}, expected={expected_state}"
            )
            report_dir = BuiltIn().get_variable_value("${REPORT_DIR}")
            BuiltIn().run_keyword(
                "Capture Page Screenshot",
                f"{report_dir}/display_state_{int(time.time())}.png",
            )
            if actual_state != expected_state.upper():
                raise AssertionError(
                    f"Display state mismatch. Expected: {expected_state.upper()} | Actual: {actual_state}"
                )
            return actual_state
        except AssertionError:
            raise
        except Exception as e:
            raise Exception(f"Failed to verify device display state: {e}") from e