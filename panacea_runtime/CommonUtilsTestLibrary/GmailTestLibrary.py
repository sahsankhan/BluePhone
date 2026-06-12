from typing import Optional
from robot.api.deco import library, keyword
from CommonUtils import CommonUtils

@library
class GmailTestLibrary:
    """
    A CommonUtilsTestLibrary for Gmail operations.

    This library provides keywords for connecting to Gmail, searching emails, fetching email content,
    and managing emails. It is designed to be used with Robot Framework for testing email functionalities.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    CommonUtilsTestLibrary
    ```
    """

    def __init__(self, common: CommonUtils) -> None:
        """Initialize the GmailTestLibrary.

        Args:
            common (CommonUtils): Instance of CommonUtils.
        """
        self.gmailtestlibrary = common

    @keyword
    def connect_to_mailbox(self, email_id: str, app_password: str):
        """
        Connects to Gmail using the provided email ID and app password, and returns the mailbox object.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.

        Output:
            - Mailbox object - Connected to inbox.

        Error Handling:
            - Raises Exception if connection or login fails.

        Example:
            | ${mailbox}= | Connect To Mailbox | user@gmail.com | app_password_here |
        """
        try:
            return self.gmailtestlibrary.connect_to_mailbox(email_id, app_password)
        except Exception as e:
            raise Exception(f"Failed to connect to mailbox: {str(e)}") from e

    @keyword
    def search_emails(self, email_id: str, app_password: str, search_criteria: str = "ALL"):
        """
        Searches emails matching the given criteria and returns a list of email IDs.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.
            - search_criteria: String - IMAP search criteria. Default: "ALL". Optional.

        Output:
            - List - List of matching email IDs.

        Error Handling:
            - Raises Exception if email retrieval fails.

        Example:
            | ${email_ids}= | Search Emails | user@gmail.com | app_password_here |
            | ${email_ids}= | Search Emails | user@gmail.com | app_password_here | UNSEEN |
        """
        try:
            return self.gmailtestlibrary.search_emails(email_id, app_password, search_criteria)
        except Exception as e:
            raise Exception(f"Failed to search emails: {str(e)}") from e

    @keyword
    def fetch_email_by_id(self, email_id: str, app_password: str, email_uid: str):
        """
        Fetches the full email content for the specified email UID.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.
            - email_uid: String - The unique identifier of the email to fetch. Required.

        Output:
            - Parsed email message object.

        Error Handling:
            - Raises Exception if fetching the email fails.

        Example:
            | ${message}= | Fetch Email By Id | user@gmail.com | app_password_here | 12345 |
        """
        try:
            return self.gmailtestlibrary.fetch_email_by_id(email_id, app_password, email_uid)
        except Exception as e:
            raise Exception(f"Failed to fetch email by ID: {str(e)}") from e

    @keyword
    def decode_subject(self, raw_subject: str) -> str:
        """
        Decodes a MIME encoded email subject to a readable string.

        Input Parameters:
            - raw_subject: String - The raw MIME encoded subject string. Required.

        Output:
            - String - Decoded subject string.

        Error Handling:
            - Handles decoding errors by ignoring invalid bytes.

        Example:
            | ${subject}= | Decode Subject | ${raw_subject} |
        """
        try:
            return self.gmailtestlibrary.decode_subject(raw_subject)
        except Exception as e:
            raise Exception(f"Failed to decode subject: {str(e)}") from e

    @keyword
    def get_email_body(self, email_id: str, app_password: str, email_uid: str) -> str:
        """
        Retrieves the body of a specific email, trying plain text first and falling back to HTML.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.
            - email_uid: String - The unique identifier of the email. Required.

        Output:
            - String - Plain text email body.

        Error Handling:
            - Returns empty string if no body content is found.

        Example:
            | ${body}= | Get Email Body | user@gmail.com | app_password_here | 12345 |
        """
        try:
            return self.gmailtestlibrary.get_email_body(email_id, app_password, email_uid)
        except Exception as e:
            raise Exception(f"Failed to get email body: {str(e)}") from e

    @keyword
    def fetch_mail_body_by_subject(self, email_id: str, app_password: str, subject: str = "CareLink™ Personal Verification Code") -> str:
        """
        Gets the body of the latest email that matches the given subject.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.
            - subject: String - The exact subject line to match. Default: "CareLink™ Personal Verification Code". Optional.

        Output:
            - String - Body of the matched email.

        Error Handling:
            - Raises Exception if no matching email is found.

        Example:
            | ${body}= | Fetch Mail Body By Subject | user@gmail.com | app_password_here |
            | ${body}= | Fetch Mail Body By Subject | user@gmail.com | app_password_here | Your OTP Code |
        """
        try:
            return self.gmailtestlibrary.fetch_mail_body_by_subject(email_id, app_password, subject)
        except Exception as e:
            raise Exception(f"Failed to fetch mail body by subject: {str(e)}") from e

    @keyword
    def wait_for_unread_mail_body_by_subject(self, email_id: str, app_password: str, subject: str = "CareLink™ Personal Verification Code", timeout: int = 180, poll_interval: int = 5) -> str:
        """
        Waits up to a specified timeout for an unread email with the given subject, polling at regular intervals.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.
            - subject: String - The exact subject line to match. Default: "CareLink™ Personal Verification Code". Optional.
            - timeout: Integer - Maximum time to wait in seconds. Default: 180. Optional.
            - poll_interval: Integer - Time between polling attempts in seconds. Default: 5. Optional.

        Output:
            - String - Body of the matched unread email.

        Error Handling:
            - Raises Exception if no matching unread email is received within timeout.

        Example:
            | ${body}= | Wait For Unread Mail Body By Subject | user@gmail.com | app_password_here |
            | ${body}= | Wait For Unread Mail Body By Subject | user@gmail.com | app_password_here | Your OTP | 300 | 10 |
        """
        try:
            return self.gmailtestlibrary.wait_for_unread_mail_body_by_subject(email_id, app_password, subject, timeout, poll_interval)
        except Exception as e:
            raise Exception(f"Failed to wait for unread mail body by subject: {str(e)}") from e

    @keyword
    def delete_email_by_subject(self, email_id: str, app_password: str, subject: str = "CareLink™ Personal Verification Code") -> int:
        """
        Deletes all emails from the inbox that match the given subject.

        Input Parameters:
            - email_id: String - The Gmail email address. Required.
            - app_password: String - The Gmail app password for authentication. Required.
            - subject: String - The exact subject line to match for deletion. Default: "CareLink™ Personal Verification Code". Optional.

        Output:
            - Integer - Number of emails deleted.

        Error Handling:
            - Logs errors and returns 0 if deletion fails.

        Example:
            | ${count}= | Delete Email By Subject | user@gmail.com | app_password_here |
            | ${count}= | Delete Email By Subject | user@gmail.com | app_password_here | Spam Email Subject |
        """
        try:
            return self.gmailtestlibrary.delete_email_by_subject(email_id, app_password, subject)
        except Exception as e:
            raise Exception(f"Failed to delete email by subject: {str(e)}") from e