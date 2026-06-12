from typing import Dict, List, Union, Any
from robot.api.deco import library, keyword
from CommonUtils import CommonUtils


@library
class DataLoaderTestLibrary:
    """
    A CommonUtilsTestLibrary for loading and reading data from JSON, YAML, and CSV files.

    This library provides keywords for retrieving values, sections, and complete data
    from structured data files. It is designed to be used with Robot Framework for
    testing data-driven functionalities.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    CommonUtilsTestLibrary
    ```
    """

    def __init__(self, common: CommonUtils) -> None:
        """Initialize the DataLoaderTestLibrary.

        Args:
            data_loader (DataLoader): Instance of DataLoader.
        """
        self.dataloadertestlibrary = common

    @keyword
    def get_value_from_file(self, file_path: str, section: str, key: str) -> Any:
        """
        Returns a single value from a data file.

        Input Parameters:
            - file_path: str - Path to the data file (JSON / YAML / CSV). Required.
            - section: str   - Top-level key / section name that contains the target value.
                               For CSV files this is the column name of the row-identifier
                               column (first column by default) and `key` is the actual
                               column whose value you want. Required.
            - key: str       - The key whose value you want inside `section`. Required.

        Output:
            - Any - The value found at data[section][key].

        Error Handling:
            - Raises FileNotFoundError if the file does not exist.
            - Raises ValueError if the extension is unsupported or the key is missing.
            - Raises Exception for any other unexpected errors.

        Example:
            | ${browser}=  | Get Value From File | config.yaml  | browser_config | browser |
            | ${email}=    | Get Value From File | users.csv    | admin          | email   |
        """
        try:
            return self.dataloadertestlibrary.get_value_from_file(file_path, section, key)
        except FileNotFoundError as e:
            raise FileNotFoundError(f"File not found: {str(e)}") from e
        except (ValueError, KeyError) as e:
            raise ValueError(f"Failed to get value from file '{file_path}': {str(e)}") from e
        except Exception as e:
            raise Exception(f"Unexpected error while reading '{file_path}': {str(e)}") from e

    @keyword
    def get_section_from_file(self, file_path: str, section: str) -> Dict:
        """
        Returns an entire section / block from the file as a dictionary.

        Input Parameters:
            - file_path: str - Path to the data file (JSON / YAML / CSV). Required.
            - section: str   - The top-level key / section name to retrieve.
                               For CSV files, this is the value in the first column
                               of the target row. Required.

        Output:
            - Dict - The full section or CSV row as a dictionary.

        Error Handling:
            - Raises FileNotFoundError if the file does not exist.
            - Raises KeyError if the section is not found in the file.
            - Raises ValueError if the file extension is unsupported.
            - Raises Exception for any other unexpected errors.

        Example:
            | ${config}=   | Get Section From File | config.yaml | browser_config |
            | ${user_row}= | Get Section From File | users.csv   | admin          |
        """
        try:
            return self.dataloadertestlibrary.get_section_from_file(file_path, section)
        except FileNotFoundError as e:
            raise FileNotFoundError(f"File not found: {str(e)}") from e
        except KeyError as e:
            raise KeyError(f"Section not found in '{file_path}': {str(e)}") from e
        except ValueError as e:
            raise ValueError(f"Failed to get section from file '{file_path}': {str(e)}") from e
        except Exception as e:
            raise Exception(f"Unexpected error while reading '{file_path}': {str(e)}") from e

    @keyword
    def get_all_data_from_file(self, file_path: str) -> Union[Dict, List]:
        """
        Returns the entire contents of the file.

        Input Parameters:
            - file_path: str - Path to the data file (JSON / YAML / CSV). Required.

        Output:
            - Dict | List - The complete file contents.
                            JSON/YAML files return a Dict; CSV files return a List of Dicts.

        Error Handling:
            - Raises FileNotFoundError if the file does not exist.
            - Raises ValueError if the file extension is unsupported.
            - Raises Exception for any other unexpected errors.

        Example:
            | ${all_data}= | Get All Data From File | config.yaml |
            | ${all_rows}= | Get All Data From File | users.csv   |
        """
        try:
            return self.dataloadertestlibrary.get_all_data_from_file(file_path)
        except FileNotFoundError as e:
            raise FileNotFoundError(f"File not found: {str(e)}") from e
        except ValueError as e:
            raise ValueError(f"Failed to load file '{file_path}': {str(e)}") from e
        except Exception as e:
            raise Exception(f"Unexpected error while reading '{file_path}': {str(e)}") from e

    @keyword
    def clear_cache(self) -> None:
        """
        Clears the in-memory file cache.

        Input Parameters:
            - None

        Output:
            - None

        Error Handling:
            - Raises Exception if the cache cannot be cleared.

        Example:
            | Clear Cache |
        """
        try:
            self.dataloadertestlibrary.clear_cache()
        except Exception as e:
            raise Exception(f"Failed to clear cache: {str(e)}") from e