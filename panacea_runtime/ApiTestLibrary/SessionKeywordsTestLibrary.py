from typing import Optional, Union, Any
from ZmxApiLibrary import ZmxApiLibrary
from robot.api.deco import library, keyword

@library
class SessionKeywordsTestLibrary:
    """A APITestLibrary for managing HTTP sessions with various authentication methods.

    This library provides keywords for creating and managing HTTP sessions, including standard sessions,
    client certificate sessions, custom sessions, digest authentication sessions, and NTLM authentication
    sessions. It is designed to be used with Robot Framework for API testing.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    APITestLibrary

    *** Test Cases ***
    Create Session Example
        Create Session    alias=my_session    url=https://api.example.com
        ${exists}=    Session Exists    alias=my_session
        Should Be True    ${exists}
    ```
    """

    def __init__(self, api: ZmxApiLibrary) -> None:
        """Initialize the SessionKeywordsTestLibrary.

        Args:
            api (ZmxApiLibrary): Instance of ZmxApiLibrary to handle HTTP operations.
        """
        self.sessionkeywordstestlibrary = api

    @keyword
    def create_session(
        self,
        alias: str,
        url: str,
        headers: dict = {},
        cookies: dict = {},
        auth: Optional[Any] = None,
        timeout: Optional[float] = None,
        proxies: Optional[dict] = None,
        verify: bool = False,
        debug: int = 0,
        max_retries: int = 3,
        backoff_factor: float = 0.10,
        disable_warnings: int = 0,
        retry_status_list: list = [],
        retry_method_list: list = []
    ) -> None:
        """
        Creates a new HTTP session identified by an alias, with configurable headers, cookies, authentication, and other 
        parameters. The session can be used for subsequent HTTP requests.

        Input Parameters:
            - alias: String — Unique identifier for the session. Required.
            - url: String — Base URL for the session (e.g., https://api.example.com). Required.
            - headers: Dict — HTTP headers for the session. Optional. Defaults to {}.
            - cookies: Dict — Cookies for the session. Optional. Defaults to {}.
            - auth: Any — Authentication credentials (e.g., tuple of (username, password)). Optional. Defaults to None.
            - timeout: Float — Request timeout in seconds. Optional. Defaults to None.
            - proxies: Dict — Proxy configuration (e.g., {'http': 'proxy.com:8080'}). Optional. Defaults to None.
            - verify: Bool — Verify SSL certificates. Optional. Defaults to False.
            - debug: Integer — Debug level (0 or higher). Optional. Defaults to 0.
            - max_retries: Integer — Maximum retry attempts for requests. Optional. Defaults to 3.
            - backoff_factor: Float — Backoff factor for retries. Optional. Defaults to 0.10.
            - disable_warnings: Integer — Disable warnings (0 or 1). Optional. Defaults to 0.
            - retry_status_list: List — List of HTTP status codes to retry. Optional. Defaults to [].
            - retry_method_list: List — List of HTTP methods to retry. Optional. Defaults to [].

        Output:
            - Session object — The created HTTP session object.

        Error Handling:
            - Raises Exception if the session creation fails, with a message indicating the failure  	reason.

        Example:
            | Create Session | alias=my_session | url=https://api.example.com | headers=${headers} |
        """
        try:
            return self.sessionkeywordstestlibrary.create_session(
                alias=alias,
                url=url,
                headers=headers,
                cookies=cookies,
                auth=auth,
                timeout=timeout,
                proxies=proxies,
                verify=verify,
                debug=debug,
                max_retries=max_retries,
                backoff_factor=backoff_factor,
                disable_warnings=disable_warnings,
                retry_status_list=retry_status_list,
                retry_method_list=retry_method_list,
            )
        except Exception as e:
            raise Exception(f"Failed to create session: {str(e)}") from e

    @keyword
    def create_client_cert_session(
        self,
        alias: str,
        url: str,
        headers: dict = {},
        cookies: dict = {},
        client_certs: Optional[tuple] = None,
        timeout: Optional[float] = None,
        proxies: Optional[dict] = None,
        verify: bool = False,
        debug: int = 0,
        max_retries: int = 3,
        backoff_factor: float = 0.10,
        disable_warnings: int = 0,
        retry_status_list: list = [],
        retry_method_list: list = []
    ) -> None:
        """
        Creates a new HTTP session identified by an alias, using client certificates for authentication. 
        Configurable with headers, cookies, and other parameters for secure communication.

        Input Parameters:
            - alias: String — Unique identifier for the session. Required.
            - url: String — Base URL for the session (e.g., https://api.example.com). Required.
            - headers: Dict — HTTP headers for the session. Optional. Defaults to {}.
            - cookies: Dict — Cookies for the session. Optional. Defaults to {}.
            - client_certs: Tuple — Tuple of (cert, key) for client certificate authentication. Optional. Defaults to None.
            - timeout: Float — Request timeout in seconds. Optional. Defaults to None.
            - proxies: Dict — Proxy configuration (e.g., {'http': 'proxy.com:8080'}). Optional. Defaults to None.
            - verify: Bool — Verify SSL certificates. Optional. Defaults to False.
            - debug: Integer — Debug level (0 or higher). Optional. Defaults to 0.
            - max_retries: Integer — Maximum retry attempts for requests. Optional. Defaults to 3.
            - backoff_factor: Float — Backoff factor for retries. Optional. Defaults to 0.10.
            - disable_warnings: Integer — Disable warnings (0 or 1). Optional. Defaults to 0.
            - retry_status_list: List — List of HTTP status codes to retry. Optional. Defaults to [].
            - retry_method_list: List — List of HTTP methods to retry. Optional. Defaults to [].
   
        Output:
            - Session object — The created HTTP session object.

        Error Handling:
            - Raises Exception if the session creation fails, with a message indicating the failure reason.

        Example:
            | Create Client Cert Session | alias=cert_session | url=https://api.example.com | client_certs=${certs} |
        """
        try:
            return self.sessionkeywordstestlibrary.create_client_cert_session(
                alias=alias,
                url=url,
                headers=headers,
                cookies=cookies,
                client_certs=client_certs,
                timeout=timeout,
                proxies=proxies,
                verify=verify,
                debug=debug,
                max_retries=max_retries,
                backoff_factor=backoff_factor,
                disable_warnings=disable_warnings,
                retry_status_list=retry_status_list,
                retry_method_list=retry_method_list,
            )
        except Exception as e:
            raise Exception(f"Failed to create client cert session: {str(e)}") from e

    @keyword
    def create_custom_session(
        self,
        alias: str,
        url: str,
        auth: Any,
        headers: dict = {},
        cookies: dict = {},
        timeout: Optional[float] = None,
        proxies: Optional[dict] = None,
        verify: bool = False,
        debug: int = 0,
        max_retries: int = 3,
        backoff_factor: float = 0.10,
        disable_warnings: int = 0,
        retry_status_list: list = [],
        retry_method_list: list = []
    ) -> None:
        """
        Creates a new HTTP session identified by an alias, using custom authentication credentials. Configurable with 
        headers, cookies, and other parameters for flexible session setup.

        Input Parameters:
            - alias: String — Unique identifier for the session. Required.
            - url: String — Base URL for the session (e.g., https://api.example.com). Required.
            - auth: Any — Required authentication credentials (e.g., custom auth object). Required.
            - headers: Dict — HTTP headers for the session. Optional. Defaults to {}.
            - cookies: Dict — Cookies for the session. Optional. Defaults to {}.
            - timeout: Float — Request timeout in seconds. Optional. Defaults to None.
            - proxies: Dict — Proxy configuration (e.g., {'http': 'proxy.com:8080'}). Optional. Defaults to None.
            - verify: Bool — Verify SSL certificates. Optional. Defaults to False.
            - debug: Integer — Debug level (0 or higher). Optional. Defaults to 0.
            - max_retries: Integer — Maximum retry attempts for requests. Optional. Defaults to 3.
            - backoff_factor: Float — Backoff factor for retries. Optional. Defaults to 0.10.
            - disable_warnings: Integer — Disable warnings (0 or 1). Optional. Defaults to 0.4).
            - retry_status_list: List — List of HTTP status codes to retry. Optional. Defaults to [].
            - retry_method_list: List — List of HTTP methods to retry. Optional. Defaults to [].

        Output:
            - Session object — The created HTTP session object.

        Error Handling:
            - Raises Exception if the session creation fails, with a message indicating the failure reason.

        Example:
            | Create Custom Session | alias=custom_session | url=https://api.example.com | auth=${auth} |
        """
        try:
            return self.sessionkeywordstestlibrary.create_custom_session(
                alias=alias,
                url=url,
                headers=headers,
                cookies=cookies,
                auth=auth,
                timeout=timeout,
                proxies=proxies,
                verify=verify,
                debug=debug,
                max_retries=max_retries,
                backoff_factor=backoff_factor,
                disable_warnings=disable_warnings,
                retry_status_list=retry_status_list,
                retry_method_list=retry_method_list,
            )
        except Exception as e:
            raise Exception(f"Failed to create custom session: {str(e)}") from e

    @keyword
    def create_digest_session(
        self,
        alias: str,
        url: str,
        auth: Any,
        headers: dict = {},
        cookies: dict = {},
        timeout: Optional[float] = None,
        proxies: Optional[dict] = None,
        verify: bool = False,
        debug: int = 0,
        max_retries: int = 3,
        backoff_factor: float = 0.10,
        disable_warnings: int = 0,
        retry_status_list: list = [],
        retry_method_list: list = []
    ) -> None:
        """
        Creates a new HTTP session identified by an alias, using Digest authentication credentials. Configurable with 
        headers, cookies, and other parameters for secure API interactions.

        Input Parameters:
            - alias: String — Unique identifier for the session. Required.
            - url: String — Base URL for the session (e.g., https://api.example.com). Required.
            - auth: Any — Digest authentication credentials (e.g., HTTPDigestAuth object). Required.
            - headers: Dict — HTTP headers for the session. Optional. Defaults to {}.
            - cookies: Dict — Cookies for the session. Optional. Defaults to {}.
            - timeout: Float — Request timeout in seconds. Optional. Defaults to None.
            - proxies: Dict — Proxy configuration (e.g., {'http': 'proxy.com:8080'}). Optional. Defaults to None.
            - verify: Bool — Verify SSL certificates. Optional. Defaults to False.
            - debug: Integer — Debug level (0 or higher). Optional. Defaults to 0.
            - max_retries: Integer — Maximum retry attempts for requests. Optional. Defaults to 3.
            - backoff_factor: Float — Backoff factor for retries. Optional. Defaults to 0.10.
            - disable_warnings: Integer — Disable warnings (0 or 1). Optional. Defaults to 0.
            - retry_status_list: List — List of HTTP status codes to retry. Optional. Defaults to [].
            - retry_method_list: List — List of HTTP methods to retry. Optional. Defaults to [].

        Output:
            - Session object — The created HTTP session object.

        Error Handling:
            - Raises Exception if the session creation fails, with a message indicating the failure reason.

        Example:
            | Create Digest Session | alias=digest_session | url=https://api.example.com | auth=${auth} |
        """
        try:
            return self.sessionkeywordstestlibrary.create_digest_session(
                alias=alias,
                url=url,
                headers=headers,
                cookies=cookies,
                auth=auth,
                timeout=timeout,
                proxies=proxies,
                verify=verify,
                debug=debug,
                max_retries=max_retries,
                backoff_factor=backoff_factor,
                disable_warnings=disable_warnings,
                retry_status_list=retry_status_list,
                retry_method_list=retry_method_list
            )
        except Exception as e:
            raise Exception(f"Failed to create digest session: {str(e)}") from e

    @keyword
    def create_ntlm_session(
        self,
        alias: str,
        url: str,
        auth: Any,
        headers: dict = {},
        cookies: dict = {},
        timeout: Optional[float] = None,
        proxies: Optional[dict] = None,
        verify: bool = False,
        debug: int = 0,
        max_retries: int = 3,
        backoff_factor: float = 0.10,
        disable_warnings: int = 0,
        retry_status_list: list = [],
        retry_method_list: list = []
    ) -> None:
        """
        Creates a new HTTP session identified by an alias, using NTLM authentication credentials. Configurable with 
        headers, cookies, and other parameters for secure API interactions.

        Input Parameters:
            - alias: String — Unique identifier for the session. Required.
            - url: String — Base URL for the session (e.g., https://api.example.com). Required.
            - auth: Any — NTLM authentication credentials (e.g., HttpNtlmAuth object). Required.
            - headers: Dict — HTTP headers for the session. Optional. Defaults to {}.
            - cookies: Dict — Cookies for the session. Optional. Defaults to {}.
            - timeout: Float — Request timeout in seconds. Optional. Defaults to None.
            - proxies: Dict — Proxy configuration (e.g., {'http': 'proxy.com:8080'}). Optional. Defaults to None.
            - verify: Bool — Verify SSL certificates. Optional. Defaults to False.
            - debug: Integer — Debug level (0 or higher). Optional. Defaults to 0.
            - max_retries: Integer — Maximum retry attempts for requests. Optional. Defaults to 3.
            - backoff_factor: Float — Backoff factor for retries. Optional. Defaults to 0.10.
            - disable_warnings: Integer — Disable warnings (0 or 1). Optional. Defaults to 0.
            - retry_status_list: List — List of HTTP status codes to retry. Optional. Defaults to [].
            - retry_method_list: List — List of HTTP methods to retry. Optional. Defaults to [].

        Output:
	        - Session object — The created HTTP session object.

        Error Handling:
            - Raises Exception if the session creation fails, with a message indicating the failure reason.

        Example:
            | Create NTLM Session | alias=ntlm_session | url=https://api.example.com | auth=${auth} |
        """
        try:
            return self.sessionkeywordstestlibrary.create_ntlm_session(
                alias=alias,
                url=url,
                headers=headers,
                cookies=cookies,
                auth=auth,
                timeout=timeout,
                proxies=proxies,
                verify=verify,
                debug=debug,
                max_retries=max_retries,
                backoff_factor=backoff_factor,
                disable_warnings=disable_warnings,
                retry_status_list=retry_status_list,
                retry_method_list=retry_method_list
            )
        except Exception as e:
            raise Exception(f"Failed to create NTLM session: {str(e)}") from e

    @keyword
    def session_exists(self, alias: str) -> bool:
        """
        Verifies whether an HTTP session with the specified alias exists in the current context. 
        Useful for ensuring a session is available before making requests.

        Input Parameters:
            - alias: String — Session alias name to check. Required.

        Output:
            - Bool — True if the session exists, False otherwise.

        Error Handling:
            - Raises Exception if checking session existence fails, with a message indicating the failure reason.

        Example:
            | ${exists}= | Session Exists | alias=my_session |
            | Should Be True | ${exists} |
        """
        try:
            return self.sessionkeywordstestlibrary.session_exists(alias=alias)
        except Exception as e:
            raise Exception(f"Failed to check session existence: {str(e)}") from e

    @keyword
    def delete_all_sessions(self) -> None:
        """
        Removes all HTTP sessions currently managed by the library. Useful for cleaning up session state between tests or 
        when sessions are no longer needed.

        Input Parameters:
            - None

        Output:
            - None
            
        Error Handling:
            - Raises Exception if session deletion fails, with a message indicating the failure reason.

        Example:
            | Delete All Sessions |
        """
        try:
            return self.sessionkeywordstestlibrary.delete_all_sessions()
        except Exception as e:
            raise Exception(f"Failed to delete all sessions: {str(e)}") from e
