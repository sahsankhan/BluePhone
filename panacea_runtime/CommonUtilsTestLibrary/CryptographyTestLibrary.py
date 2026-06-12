from typing import Optional, Dict, List, Union, Any
from robot.api.deco import library, keyword
from CommonUtils import CommonUtils

@library
class CryptographyTestLibrary:
    """
    A CommonUtilsTestLibrary for cryptographic operations.

    This library provides keywords for generating Fernet keys, encrypting plaintext strings, and decrypting
    encrypted strings. It is designed to be used with Robot Framework for testing cryptographic functionalities.

    Example usage in Robot Framework:
    ```robot
    *** Settings ***
    Library    CommonUtilsTestLibrary
    ```
    """

    def __init__(self, common: CommonUtils) -> None:
        """Initialize the CryptographyTestLibrary.

        Args:
            common (CommonUtilsTestLibrary): Instance of CommonUtilsTestLibrary.
        """
        self.cryptographytestlibrary = common

    @keyword
    def generate_key(self) -> str:
        """
        Generates a new Fernet key that can be used for encryption and decryption.

        Input Parameters:
            - None

        Output:
            -String - A base64-encoded Fernet key.

        Error Handling:
            - Raises Exception if key generation fails.

        Example:
            | ${key}= | Generate Key |
        """
        try:
            return self.cryptographytestlibrary.generate_key()
        except Exception as e:
            raise Exception(f"Failed to generate Fernet key: {str(e)}") from e

    @keyword
    def encrypt_string(self, plain_text: str, key: str) -> str:
        """
        Encrypts a plaintext string using the provided Fernet key.

        Input Parameters:	
            - plain_text: str - The plaintext string to encrypt. Required.
            - key: str - A base64-encoded Fernet key. Required.

        Output:
            - String - The base64-encoded encrypted string.

        Error Handling:
            - Raises Exception if encryption fails (e.g., invalid key or plaintext).

        Example:
            | ${key}=        | Generate Key |
            | ${cipher}=     | Encrypt String | Hello World | ${key} |
        """
        try:
            return self.cryptographytestlibrary.encrypt_string(plain_text, key)
        except Exception as e:
            raise Exception(f"Failed to encrypt string: {str(e)}") from e

    @keyword
    def decrypt_string(self, encrypted_text: str, key: str) -> str:
        """
        Decrypts an encrypted string using the provided Fernet key.

        Input Parameters:
            - encrypted_text: str - The base64-encoded encrypted string. Required.
            - key: str - A base64-encoded Fernet key. Required.

        Output:
            - String - The decrypted plaintext string.

        Error Handling:
            - Raises Exception if decryption fails (e.g., invalid key or invalid ciphertext).

        Example:
            | ${key}=        | Generate Key |
            | ${cipher}=     | Encrypt String | Hello World | ${key} |
            | ${original}=   | Decrypt String | ${cipher}   | ${key} |
        """
        try:
            return self.cryptographytestlibrary.decrypt_string(encrypted_text, key)
        except Exception as e:
            raise Exception(f"Failed to decrypt string: {str(e)}") from e