from ZmxApiLibrary import ZmxApiLibrary
from robot.api.deco import library, keyword
from typing import Any


@library
class ValidationKeywordsTestLibrary:
    """A APITestLibrary for validating HTTP responses using ZmxApiLibrary.

    This library provides keywords to assert response bodies, headers, status codes,
    JSON values, and response timing. It is designed to be used with Robot Framework
    for API testing.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    ApiTestLibrary

    *** Test Cases ***
    Validate API Response
        Create Session    api    https://api.example.com
        ${response}=    Get On Session    api    /users/1
        Response Status Should Be In    ${response}    200
        Response JSON Should Contain Key    ${response}    id
        JSON Value Should Equal    ${response}    id    1
    ```
    """

    def __init__(self, api: ZmxApiLibrary) -> None:
        """Initialize the validationkeywordstestlibrary.

        Args:
            api (ZmxApiLibrary): Instance of ZmxApiLibrary to handle validations.
        """
        self.validationkeywordstestlibrary = api

    @keyword
    def response_should_contain(self, response: Any, text: str) -> None:
        """
        Asserts that the response body contains the given text.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - text: String — The text expected to be present in the response body. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the text is not found in the response body.

        Example:
            | Response Should Contain | ${response} | success |
        """
        try:
            return self.validationkeywordstestlibrary.response_should_contain(response, text)
        except Exception as e:
            raise Exception(f"Failed to verify response contains text: {str(e)}") from e

    @keyword
    def response_should_not_contain(self, response: Any, text: str) -> None:
        """
        Asserts that the response body does NOT contain the given text.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - text: String — The text expected to be absent from the response body. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the text is found in the response body.

        Example:
            | Response Should Not Contain | ${response} | error |
        """
        try:
            return self.validationkeywordstestlibrary.response_should_not_contain(response, text)
        except Exception as e:
            raise Exception(f"Failed to verify response does not contain text: {str(e)}") from e

    @keyword
    def response_header_should_exist(self, response: Any, header: str) -> None:
        """
        Asserts that the response contains the specified header (case-insensitive).

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - header: String — The header name to check for (e.g., Content-Type). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the header is not present in the response.

        Example:
            | Response Header Should Exist | ${response} | Content-Type |
        """
        try:
            return self.validationkeywordstestlibrary.response_header_should_exist(response, header)
        except Exception as e:
            raise Exception(f"Failed to verify header exists: {str(e)}") from e

    @keyword
    def response_header_should_equal(self, response: Any, header: str, expected_value: str) -> None:
        """
        Asserts that the given response header equals the expected value.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - header: String — The header name to check (e.g., Content-Type). Required.
            - expected_value: String — The expected value of the header. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the header is missing or its value does not match.

        Example:
            | Response Header Should Equal | ${response} | Content-Type | application/json |
        """
        try:
            return self.validationkeywordstestlibrary.response_header_should_equal(response, header, expected_value)
        except Exception as e:
            raise Exception(f"Failed to verify header value: {str(e)}") from e

    @keyword
    def response_should_be_json(self, response: Any) -> Any:
        """
        Asserts that the response body is valid JSON and returns the parsed object.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.

        Output:
            - The parsed JSON object (dict or list).

        Error Handling:
            - Raises Exception if the response body is not valid JSON.

        Example:
            | ${data}= | Response Should Be JSON | ${response} |
        """
        try:
            return self.validationkeywordstestlibrary.response_should_be_json(response)
        except Exception as e:
            raise Exception(f"Failed to verify response is JSON: {str(e)}") from e

    @keyword
    def response_time_should_be_less_than(self, response: Any, milliseconds: float) -> None:
        """
        Asserts that the response time was less than the given number of milliseconds.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - milliseconds: Float — The maximum acceptable response time in milliseconds. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the response time exceeds the specified limit.

        Example:
            | Response Time Should Be Less Than | ${response} | 2000 |
        """
        try:
            return self.validationkeywordstestlibrary.response_time_should_be_less_than(response, milliseconds)
        except Exception as e:
            raise Exception(f"Failed to verify response time: {str(e)}") from e

    @keyword
    def response_status_should_be_in(self, response: Any, *statuses) -> None:
        """
        Asserts that the response status code is one of the given values.
        Useful when multiple success codes are acceptable.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - *statuses: Integer — One or more acceptable status codes (e.g., 200, 201). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the status code is not in the list of expected values.

        Example:
            | Response Status Should Be In | ${response} | 200 | 201 |
        """
        try:
            return self.validationkeywordstestlibrary.response_status_should_be_in(response, *statuses)
        except Exception as e:
            raise Exception(f"Failed to verify response status: {str(e)}") from e

    @keyword
    def get_json_value(self, response: Any, path: str) -> Any:
        """
        Extracts a value from the JSON response using dot notation.
        Supports simple keys, nested keys, and array indices.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - path: String — Dot-notation path to the value (e.g., user.name, items.0.id). Required.

        Output:
            - The value found at the given JSON path.

        Error Handling:
            - Raises Exception if the path cannot be resolved or the response is not valid JSON.

        Example:
            | ${id}=    | Get JSON Value | ${response} | id          |
            | ${name}=  | Get JSON Value | ${response} | user.name   |
            | ${first}= | Get JSON Value | ${response} | items.0.title |
        """
        try:
            return self.validationkeywordstestlibrary.get_json_value(response, path)
        except Exception as e:
            raise Exception(f"Failed to get JSON value at path '{path}': {str(e)}") from e

    @keyword
    def json_value_should_equal(self, response: Any, path: str, expected: Any) -> None:
        """
        Asserts that the value at the given JSON path equals the expected value.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - path: String — Dot-notation path to the value (e.g., user.role). Required.
            - expected: Any — The expected value to compare against. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the value does not match the expected value.

        Example:
            | JSON Value Should Equal | ${response} | status    | active |
            | JSON Value Should Equal | ${response} | user.role | admin  |
        """
        try:
            return self.validationkeywordstestlibrary.json_value_should_equal(response, path, expected)
        except Exception as e:
            raise Exception(f"Failed to verify JSON value equals at path '{path}': {str(e)}") from e

    @keyword
    def json_value_should_not_equal(self, response: Any, path: str, expected: Any) -> None:
        """
        Asserts that the value at the given JSON path does NOT equal the expected value.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - path: String — Dot-notation path to the value (e.g., status). Required.
            - expected: Any — The value that should NOT be present at the path. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the value equals the expected value.

        Example:
            | JSON Value Should Not Equal | ${response} | status | deleted |
        """
        try:
            return self.validationkeywordstestlibrary.json_value_should_not_equal(response, path, expected)
        except Exception as e:
            raise Exception(f"Failed to verify JSON value not equal at path '{path}': {str(e)}") from e

    @keyword
    def json_value_should_contain(self, response: Any, path: str, expected: str) -> None:
        """
        Asserts that the value at the given JSON path contains the expected substring.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - path: String — Dot-notation path to the value (e.g., user.email). Required.
            - expected: String — The substring expected to be present in the value. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the value does not contain the expected substring.

        Example:
            | JSON Value Should Contain | ${response} | message    | success      |
            | JSON Value Should Contain | ${response} | user.email | @example.com |
        """
        try:
            return self.validationkeywordstestlibrary.json_value_should_contain(response, path, expected)
        except Exception as e:
            raise Exception(f"Failed to verify JSON value contains at path '{path}': {str(e)}") from e

    @keyword
    def json_array_length_should_be(self, response: Any, path: str, expected_length: int) -> None:
        """
        Asserts that the JSON array at the given path has the expected number of items.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - path: String — Dot-notation path to the array (e.g., items, data.results). Required.
            - expected_length: Integer — The expected number of items in the array. Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the array length does not match or the path is not an array.

        Example:
            | JSON Array Length Should Be | ${response} | items | 5 |
        """
        try:
            return self.validationkeywordstestlibrary.json_array_length_should_be(response, path, expected_length)
        except Exception as e:
            raise Exception(f"Failed to verify JSON array length at path '{path}': {str(e)}") from e

    @keyword
    def json_array_should_not_be_empty(self, response: Any, path: str) -> None:
        """
        Asserts that the JSON array at the given path has at least one item.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - path: String — Dot-notation path to the array (e.g., results, data.items). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the array is empty or the path is not an array.

        Example:
            | JSON Array Should Not Be Empty | ${response} | results |
        """
        try:
            return self.validationkeywordstestlibrary.json_array_should_not_be_empty(response, path)
        except Exception as e:
            raise Exception(f"Failed to verify JSON array not empty at path '{path}': {str(e)}") from e

    @keyword
    def response_json_should_contain_key(self, response: Any, key: str) -> None:
        """
        Asserts that the top-level JSON response object contains the given key.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.
            - key: String — The top-level key to check for (e.g., id, accessToken). Required.

        Output:
            - None

        Error Handling:
            - Raises Exception if the key is not present in the top-level JSON object.

        Example:
            | Response JSON Should Contain Key | ${response} | accessToken |
            | Response JSON Should Contain Key | ${response} | data        |
        """
        try:
            return self.validationkeywordstestlibrary.response_json_should_contain_key(response, key)
        except Exception as e:
            raise Exception(f"Failed to verify JSON contains key '{key}': {str(e)}") from e

    @keyword
    def log_response_body(self, response: Any) -> str:
        """
        Pretty-prints the full response body to the Robot Framework log and returns it as a string.

        Input Parameters:
            - response: Any — The response object returned from an HTTP request. Required.

        Output:
            - String — The formatted response body.

        Error Handling:
            - Raises Exception if the response body cannot be read or formatted.

        Example:
            | Log Response Body | ${response} |
        """
        try:
            return self.validationkeywordstestlibrary.log_response_body(response)
        except Exception as e:
            raise Exception(f"Failed to log response body: {str(e)}") from e
