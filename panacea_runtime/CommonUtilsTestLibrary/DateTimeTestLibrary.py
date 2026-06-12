from typing import Optional
from robot.api.deco import library, keyword
from CommonUtils import CommonUtils

@library
class DateTimeTestLibrary:
    """
    A CommonUtilsTestLibrary for date and time operations.

    This library provides keywords for working with dates, timestamps, and timezones.
    It is designed to be used with Robot Framework for testing date/time functionalities.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    CommonUtilsTestLibrary
    ```
    """

    def __init__(self, common: CommonUtils) -> None:
        """Initialize the DateTimeTestLibrary.

        Args:
            common (CommonUtils): Instance of CommonUtils.
        """
        self.datetimetestlibrary = common

    @keyword
    def get_current_timestamp(self, fmt: str = "%Y-%m-%d %H:%M:%S", timezone_str: str = "Asia/Kolkata") -> str:
        """
        Returns the current timestamp formatted according to the given format string and timezone.

        Input Parameters:
            - fmt: String - The datetime format string. Default: "%Y-%m-%d %H:%M:%S". Optional.
            - timezone_str: String - The timezone string. Default: "Asia/Kolkata". Optional.

        Output:
            - String - Formatted current timestamp string.

        Error Handling:
            - Raises ValueError if timezone retrieval or formatting fails.

        Example:
            | ${timestamp}= | Get Current Timestamp |
            | ${timestamp}= | Get Current Timestamp | %d/%m/%Y %H:%M | UTC |
        """
        try:
            return self.datetimetestlibrary.get_current_timestamp(fmt, timezone_str)
        except Exception as e:
            raise Exception(f"Failed to get current timestamp: {str(e)}") from e

    @keyword
    def get_formatted_timestamp(self, fmt: str = "%d-%m-%Y_%H-%M-%S", timezone_str: str = "Asia/Kolkata") -> str:
        """
        Returns the current timestamp formatted in a user-defined format and timezone.

        Input Parameters:
            - fmt: String - The datetime format string. Default: "%d-%m-%Y_%H-%M-%S". Optional.
            - timezone_str: String - The timezone string. Default: "Asia/Kolkata". Optional.

        Output:
            - String - Formatted current timestamp string.

        Error Handling:
            - Raises ValueError if timezone retrieval or formatting fails.

        Example:
            | ${timestamp}= | Get Formatted Timestamp |
            | ${timestamp}= | Get Formatted Timestamp | %Y%m%d_%H%M%S | US/Eastern |
        """
        try:
            return self.datetimetestlibrary.get_formatted_timestamp(fmt, timezone_str)
        except Exception as e:
            raise Exception(f"Failed to get formatted timestamp: {str(e)}") from e

    @keyword
    def get_current_date_plus_offset(self, days: int, fmt: str = "%Y-%m-%d", timezone_str: str = "Asia/Kolkata") -> str:
        """
        Returns the current date offset by a specified number of days, formatted accordingly.

        Input Parameters:
            - days: Integer - The number of days to offset (positive for future, negative for past). Required.
            - fmt: String - The date format string. Default: "%Y-%m-%d". Optional.
            - timezone_str: String - The timezone string. Default: "Asia/Kolkata". Optional.

        Output:
            - String - Offset date string formatted and localized.

        Error Handling:
            - Raises ValueError if timezone retrieval or formatting fails.

        Example:
            | ${future_date}= | Get Current Date Plus Offset | 7 |
            | ${past_date}=   | Get Current Date Plus Offset | -30 | %d/%m/%Y |
        """
        try:
            return self.datetimetestlibrary.get_current_date_plus_offset(days, fmt, timezone_str)
        except Exception as e:
            raise Exception(f"Failed to get current date plus offset: {str(e)}") from e

    @keyword
    def add_days_to_date(self, date_str: str, days: int, fmt: str = "%Y-%m-%d") -> str:
        """
        Adds a specified number of days to a given date string and returns the new date string.

        Input Parameters:
            - date_str: String - The date string to add days to. Required.
            - days: Integer - The number of days to add. Required.
            - fmt: String - The date format string. Default: "%Y-%m-%d". Optional.

        Output:
            - String - New date string after adding days.

        Error Handling:
            - Raises ValueError if date format is invalid or on other errors.

        Example:
            | ${new_date}= | Add Days To Date | 2024-01-15 | 10 |
            | ${new_date}= | Add Days To Date | 15/01/2024 | 5 | %d/%m/%Y |
        """
        try:
            return self.datetimetestlibrary.add_days_to_date(date_str, days, fmt)
        except Exception as e:
            raise Exception(f"Failed to add days to date: {str(e)}") from e

    @keyword
    def subtract_days_from_date(self, date_str: str, days: int, fmt: str = "%Y-%m-%d") -> str:
        """
        Subtracts a specified number of days from a given date string and returns the result.

        Input Parameters:
            - date_str: String - The date string to subtract days from. Required.
            - days: Integer - The number of days to subtract. Required.
            - fmt: String - The date format string. Default: "%Y-%m-%d". Optional.

        Output:
            - String - New date string after subtracting days.

        Error Handling:
            - Raises ValueError if date format is invalid or on other errors.

        Example:
            | ${new_date}= | Subtract Days From Date | 2024-01-15 | 10 |
            | ${new_date}= | Subtract Days From Date | 15/01/2024 | 5 | %d/%m/%Y |
        """
        try:
            return self.datetimetestlibrary.subtract_days_from_date(date_str, days, fmt)
        except Exception as e:
            raise Exception(f"Failed to subtract days from date: {str(e)}") from e

    @keyword
    def get_difference_in_days(self, date1: str, date2: str, fmt: str = "%Y-%m-%d") -> int:
        """
        Calculates the number of days between two date strings.

        Input Parameters:
            - date1: String - The first date string. Required.
            - date2: String - The second date string. Required.
            - fmt: String - The date format string for both dates. Default: "%Y-%m-%d". Optional.

        Output:
            - Integer - Days between date1 and date2 (date2 - date1).

        Error Handling:
            - Raises ValueError if date formats are invalid or on other errors.

        Example:
            | ${days}= | Get Difference In Days | 2024-01-01 | 2024-01-15 |
            | ${days}= | Get Difference In Days | 01/01/2024 | 15/01/2024 | %d/%m/%Y |
        """
        try:
            return self.datetimetestlibrary.get_difference_in_days(date1, date2, fmt)
        except Exception as e:
            raise Exception(f"Failed to get difference in days: {str(e)}") from e

    @keyword
    def convert_date_format(self, date_str: str, from_fmt: str, to_fmt: str) -> str:
        """
        Converts a date string from one format to another.

        Input Parameters:
            - date_str: String - The date string to convert. Required.
            - from_fmt: String - The current format of the date string. Required.
            - to_fmt: String - The desired output format. Required.

        Output:
            - String - Date string converted to the new format.

        Error Handling:
            - Raises ValueError if conversion fails or formats are invalid.

        Example:
            | ${converted}= | Convert Date Format | 2024-01-15 | %Y-%m-%d | %d/%m/%Y |
            | ${converted}= | Convert Date Format | 15/01/2024 | %d/%m/%Y | %Y-%m-%d |
        """
        try:
            return self.datetimetestlibrary.convert_date_format(date_str, from_fmt, to_fmt)
        except Exception as e:
            raise Exception(f"Failed to convert date format: {str(e)}") from e