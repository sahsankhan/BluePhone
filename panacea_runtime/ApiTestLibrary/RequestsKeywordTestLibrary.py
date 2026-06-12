from ZmxApiLibrary import ZmxApiLibrary
from robot.api.deco import library, keyword
from typing import Optional, Union, Any

@library
class RequestsKeywordTestLibrary:
    """A APITestLibrary for performing HTTP requests using ZmxApiLibrary.

    This library provides keywords to perform various HTTP requests (POST, GET, PUT, PATCH, DELETE, HEAD, OPTIONS)
    with both session-based and sessionless operations. It is designed to be used with Robot Framework for API testing.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    APITestLibrary

    *** Test Cases ***
    Perform GET Request
        Create Session    alias=my_session    url=https://api.example.com
        ${response}=    Get On Session    alias=my_session    url=/endpoint
        Status Should Be    200    ${response}
    ```
    """

    def __init__(self, api: ZmxApiLibrary) -> None:
        """Initialize the RequestsKeywordTestLibrary.

        Args:
            api (ZmxApiLibrary): Instance of ZmxApiLibrary to handle HTTP requests.
        """
        self.RequestsKeywordTestLibrary = api

    @keyword
    def status_should_be(self, expected_status: Union[int, str], response: Optional[Any] = None, msg: Optional[str] = None) -> None:
        """
        Verifies that the HTTP status code of a response matches the expected status code.
        Useful for validating the outcome of an HTTP request.

        Input Parameters:
            - expected_status: String/Integer — The expected HTTP status code (e.g., 200, "404"). Required.
            - response: Any — The response object to check, typically returned from an HTTP request. Optional.
            - msg: String — Custom error message to display if the assertion fails. Optional.

        Output:
            - None

        Error Handling:
            - Raises Exception if there is an issue verifying the status code, with a message indicating the failure reason.

        Example:
            | Status Should Be | 200 | ${response} |
        """
        try:
            return self.RequestsKeywordTestLibrary.status_should_be(expected_status=expected_status, response=response, msg=msg)
        except Exception as e:
            raise Exception(f"Failed to verify status code: {str(e)}") from e

    @keyword
    def request_should_be_successful(self, response: Optional[Any] = None) -> None:
        """
        Verifies that an HTTP request was successful by checking if the response status code is in the 2xx range 
        (e.g., 200, 201, 204). Useful for ensuring a request completed successfully without specifying an exact 
        status code.

        Input Parameters:
	        - response: Any — The response object to check, typically returned from an HTTP request. Optional.

        Output Parameters:
	        - None

        Error Handling:
	        - Raises Exception if there is an issue verifying the request success, with a message indicating the 
            failure reason.
     
        Example:
            | Request Should Be Successful | ${response} |
        """
        try:
            return self.RequestsKeywordTestLibrary.request_should_be_successful(response=response)
        except Exception as e:
            raise Exception(f"Failed to verify request success: {str(e)}") from e

    @keyword
    def session_less_get(self, url: str, params: Optional[dict] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless GET request to the specified URL, retrieving the resource without requiring a pre-existing session.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - params: Dict/List of tuples/Bytes/String — Query string parameters to include in the request. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "404"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request.

        Error Handling:
	        - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Get | url=https://api.example.com/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_get(
                url=url,
                params=params,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless GET request: {str(e)}") from e

    @keyword
    def session_less_post(self, url: str, data: Optional[Any] = None, json: Optional[Any] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless POST request to the specified URL, typically used to create or submit data. 
        Supports sending data as form data or JSON, with optional status code validation.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - data: Any — Data to send in the request body (e.g., form data). Optional.
            - json: Any — JSON data to send in the request body. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 201, "400"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request.

        Error Handling:
	        - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Post | url=https://api.example.com/endpoint | json=${payload} |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_post(
                url=url,
                data=data,
                json=json,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless POST request: {str(e)}") from e

    @keyword
    def session_less_put(self, url: str, data: Optional[Any] = None, json: Optional[Any] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless PUT request to the specified URL, typically used to update a resource. Supports sending data 
        as form data or JSON, with optional status code validation.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - data: Any — Data to send in the request body (e.g., form data). Optional.
            - json: Any — JSON data to send in the request body. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "400"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request.

        Error Handling:
	        - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Put | url=https://api.example.com/endpoint | json=${payload} |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_put(
                url=url,
                data=data,
                json=json,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless PUT request: {str(e)}") from e

    @keyword
    def session_less_head(self, url: str, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless HEAD request to the specified URL, retrieving only the headers of the resource. 
        Supports optional status code validation.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "404"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request (containing headers only).

        Error Handling:
	        - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Head | url=https://api.example.com/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_head(
                url=url,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless HEAD request: {str(e)}") from e

    @keyword
    def session_less_patch(self, url: str, data: Optional[Any] = None, json: Optional[Any] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless PATCH request to the specified URL, typically used to partially update a resource. 
        Supports sending data as form data or JSON, with optional status code validation.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - data: Any — Data to send in the request body (e.g., form data). Optional.
            - json: Any — JSON data to send in the request body. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "400"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request.

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Patch | url=https://api.example.com/endpoint | json=${payload} |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_patch(
                url=url,
                data=data,
                json=json,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless PATCH request: {str(e)}") from e

    @keyword
    def session_less_delete(self, url: str, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless DELETE request to the specified URL, typically used to remove a resource. 
        Supports optional status code validation.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 204, "404"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request.

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Delete | url=https://api.example.com/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_delete(
                url=url,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless DELETE request: {str(e)}") from e

    @keyword
    def session_less_options(self, url: str, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a sessionless OPTIONS request to the specified URL, retrieving the allowed HTTP methods and other options 
        for the resource. Supports optional status code validation.

        Input Parameters:
            - url: String — The full URL for the request (e.g., https://api.example.com/endpoint). Required.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "204"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request.
        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Session Less Options | url=https://api.example.com/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.session_less_options(
                url=url,
                expected_status=expected_status,
                msg=msg,
                **kwargs
            )
        except Exception as e:
            raise Exception(f"Failed to perform sessionless OPTIONS request: {str(e)}") from e

    @keyword
    def get_on_session(self, alias: str, url: str, params: Optional[dict] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a GET request on a previously created HTTP session identified by an alias. Retrieves the resource from the 
        specified URL relative to the session's base URL, with optional query parameters.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - params: Dict/List of tuples/Bytes/String — Query string parameters to include in the request. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "404"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request.

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Get On Session | alias=my_session | url=/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.get_on_session(alias=alias, url=url, params=params, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform GET request on session: {str(e)}") from e

    @keyword
    def post_on_session(self, alias: str, url: str, data: Optional[Any] = None, json: Optional[Any] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a POST request on a previously created HTTP session identified by an alias. Typically used to create or 
        submit data, with support for sending data as form data or JSON.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - data: Any — Data to send in the request body (e.g., form data). Optional.
            - json: Any — JSON data to send in the request body. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 201, "400"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request.
        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Post On Session | alias=my_session | url=/endpoint | json=${payload} |
        """
        try:
            return self.RequestsKeywordTestLibrary.post_on_session(alias=alias, url=url, data=data, json=json, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform POST request on session: {str(e)}") from e

    @keyword
    def patch_on_session(self, alias: str, url: str, data: Optional[Any] = None, json: Optional[Any] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a PATCH request on a previously created HTTP session identified by an alias. Typically used to partially 
        update a resource, with support for sending data as form data or JSON.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - data: Any — Data to send in the request body (e.g., form data). Optional.
            - json: Any — JSON data to send in the request body. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "400"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
	        - Response object from the HTTP request.

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Patch On Session | alias=my_session | url=/endpoint | json=${payload} |
        """
        try:
            return self.RequestsKeywordTestLibrary.patch_on_session(alias=alias, url=url, data=data, json=json, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform PATCH request on session: {str(e)}") from e

    @keyword
    def put_on_session(self, alias: str, url: str, data: Optional[Any] = None, json: Optional[Any] = None, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a PUT request on a previously created HTTP session identified by an alias. Typically used to update a 
        resource, with support for sending data as form data or JSON.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - data: Any — Data to send in the request body (e.g., form data). Optional.
            - json: Any — JSON data to send in the request body. Optional.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "400"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request.

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure 

        Example:
            | ${response}= | Put On Session | alias=my_session | url=/endpoint | json=${payload} |
        """
        try:
            return self.RequestsKeywordTestLibrary.put_on_session(alias=alias, url=url, data=data, json=json, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform PUT request on session: {str(e)}") from e

    @keyword
    def delete_on_session(self, alias: str, url: str, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a DELETE request on a previously created HTTP session identified by an alias. Typically used to remove a 
        resource, with optional status code validation.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 204, "404"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request.
        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Delete On Session | alias=my_session | url=/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.delete_on_session(alias=alias, url=url, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform DELETE request on session: {str(e)}") from e

    @keyword
    def head_on_session(self, alias: str, url: str, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends a HEAD request on a previously created HTTP session identified by an alias. Retrieves only the headers 
        of the resource, with optional status code validation.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "404"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request (containing headers only).

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Head On Session | alias=my_session | url=/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.head_on_session(alias=alias, url=url, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform HEAD request on session: {str(e)}") from e

    @keyword
    def options_on_session(self, alias: str, url: str, expected_status: Optional[Union[int, str]] = None, msg: Optional[str] = None, **kwargs) -> Any:
        """
        Sends an OPTIONS request on a previously created HTTP session identified by an alias. Retrieves the allowed HTTP 
        methods and other options for the resource, with optional status code validation.

        Input Parameters:
            - alias: String — Session alias name identifying the HTTP session. Required.
            - url: String — API endpoint URL (relative to the session's base URL, e.g., /endpoint). Required.
            - expected_status: String/Integer — Expected HTTP status code(s) (e.g., 200, "204"). Use "any" to disable status checking. Optional.
            - msg: String — Custom error message for assertion failures. Optional.
            - **kwargs: Any — Additional arguments to pass to the request (e.g., headers, timeout). Optional.

        Output:
            - Response object from the HTTP request.

        Error Handling:
            - Raises Exception if the request fails, with a message indicating the failure reason.

        Example:
            | ${response}= | Options On Session | alias=my_session | url=/endpoint |
        """
        try:
            return self.RequestsKeywordTestLibrary.options_on_session(alias=alias, url=url, expected_status=expected_status, msg=msg, **kwargs)
        except Exception as e:
            raise Exception(f"Failed to perform OPTIONS request on session: {str(e)}") from e