import os
import certifi

# Override broken system SSL_CERT_FILE (e.g. invalid PostgreSQL ca-bundle path)
os.environ["SSL_CERT_FILE"] = certifi.where()
os.environ["REQUESTS_CA_BUNDLE"] = certifi.where()
os.environ.pop("CURL_CA_BUNDLE", None)

import requests
from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
import time
from robot.api import logger
import yaml
from panacea_runtime.MobAppTestLibrary import MobAppTestLibrary

@library
class Voip:
    mob: MobAppTestLibrary
    DEFAULT_TIMEOUT = 20   # seconds

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

    @keyword("Make Primary Inbound Call")
    def make_primary_inbound_call(self, duration=None):
        logger.info("===== START Make Primary Inbound Call =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]
            request = data["requests"]["make_primary_inbound_call"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            type_value = request["type"]

            if duration is None:
                duration = data["common"]["default_payload"]["duration"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "account": data["common"]["default_payload"]["account"],
                "region": data["common"]["default_payload"]["region"],
                "version": data["common"]["default_payload"]["version"],
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}"),
                "did": BuiltIn().get_variable_value("${DID_1}"),
                "password": BuiltIn().get_variable_value("${DID_1_PASSWORD}"),
                "cmd": request["cmd"],
                "type": type_value,
                "media": data["common"]["default_payload"]["media"],
                "duration": duration,
                "callee_number": BuiltIn().get_variable_value("${CALLEE_NUMBER}")
            }

            url = base_url + request["endpoint"]

            logger.info(f"Request URL: {url}")
            logger.info(f"Payload: {payload}")

            for attempt in range(3):
                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.post(url, headers=headers, json=payload)

                    logger.info(f"Response Status Code: {response.status_code}")
                    logger.info(f"Response Text: {response.text}")

                    if response.status_code == 200:
                        return response.status_code
                    else:
                        logger.error("API call failed, retrying after cleanup")
                        self.remove_primary_container(type_value)

                except Exception as api_error:
                    logger.error(f"API exception: {api_error}")
                    self.remove_primary_container(type_value)

            raise Exception("API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error in Make Primary Inbound Call: {e}")
            raise


    @keyword("Remove Primary Container")
    def remove_primary_container(self, type):

        logger.info("===== Removing Primary Container =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            request = data["requests"]["remove_container"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "account": data["common"]["default_payload"]["account"],
                "region": data["common"]["default_payload"]["region"],
                "version": data["common"]["default_payload"]["version"],
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}"),
                "did": BuiltIn().get_variable_value("${DID_1}"),
                "password": BuiltIn().get_variable_value("${DID_1_PASSWORD}"),
                "cmd": request["cmd"],
                "type": type,
                "media": data["common"]["default_payload"]["media"],
                "duration": data["common"]["default_payload"]["duration"],
                "callee_number": BuiltIn().get_variable_value("${CALLEE_NUMBER}")
            }

            url = base_url + request["endpoint"]

            logger.info(f"Remove Container URL: {url}")
            logger.info(f"Payload: {payload}")

            for attempt in range(3):
                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.post(url, headers=headers, json=payload)

                    logger.info(f"Remove Container Status: {response.status_code}")
                    logger.info(f"Response: {response.text}")

                    if response.status_code == 200:
                        return response.status_code
                    else:
                        logger.error("Remove container API failed, retrying...")

                except Exception as api_error:
                    logger.error(f"API exception while removing container: {api_error}")

            raise Exception("Remove primary container API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error while removing primary container: {e}")
            raise

    @keyword("Make Secondary Inbound Call")
    def make_secondary_inbound_call(self, duration=None):

        logger.info("===== START Make Secondary Inbound Call =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]
            request = data["requests"]["make_secondary_inbound_call"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            type_value = request["type"]

            if duration is None:
                duration = data["common"]["default_payload"]["duration"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "account": data["common"]["default_payload"]["account"],
                "region": data["common"]["default_payload"]["region"],
                "version": data["common"]["default_payload"]["version"],
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}"),
                "did": BuiltIn().get_variable_value("${DID_2}"),
                "password": BuiltIn().get_variable_value("${DID_2_PASSWORD}"),
                "cmd": request["cmd"],
                "type": type_value,
                "media": data["common"]["default_payload"]["media"],
                "duration": duration,
                "callee_number": BuiltIn().get_variable_value("${CALLEE_NUMBER}")
            }

            url = base_url + request["endpoint"]

            logger.info(f"Secondary Call URL: {url}")
            logger.info(f"Payload: {payload}")

            for attempt in range(3):

                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.post(url, headers=headers, json=payload)

                    logger.info(f"Status Code: {response.status_code}")
                    logger.info(f"Response: {response.text}")

                    if response.status_code == 200:
                        return response.status_code
                    else:
                        logger.error("API call failed, removing secondary container before retry")
                        self.remove_secondary_container(type_value)

                except Exception as api_error:
                    logger.error(f"API exception: {api_error}")
                    self.remove_secondary_container(type_value)

            raise Exception("Secondary inbound call API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"KeyError while reading YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error in Make Secondary Inbound Call: {e}")
            raise

    @keyword("Remove Secondary Container")
    def remove_secondary_container(self, type):

        logger.info("===== Removing Secondary Container =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            request = data["requests"]["remove_container"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "account": data["common"]["default_payload"]["account"],
                "region": data["common"]["default_payload"]["region"],
                "version": data["common"]["default_payload"]["version"],
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}"),
                "did": BuiltIn().get_variable_value("${DID_2}"),
                "password": BuiltIn().get_variable_value("${DID_2_PASSWORD}"),
                "cmd": request["cmd"],
                "type": type,
                "media": data["common"]["default_payload"]["media"],
                "duration": data["common"]["default_payload"]["duration"],
                "callee_number": BuiltIn().get_variable_value("${CALLEE_NUMBER}")
            }

            url = base_url + request["endpoint"]

            logger.info(f"Remove Secondary URL: {url}")
            logger.info(f"Payload: {payload}")

            for attempt in range(3):
                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.post(url, headers=headers, json=payload)

                    logger.info(f"Remove Secondary Status: {response.status_code}")
                    logger.info(f"Response: {response.text}")

                    if response.status_code == 200:
                        return response.status_code
                    else:
                        logger.error("Remove secondary container API failed, retrying...")

                except Exception as api_error:
                    logger.error(f"API exception while removing secondary container: {api_error}")

            raise Exception("Remove secondary container API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error while removing secondary container: {e}")
            raise

    @keyword("Make Primary Outbound Call")
    def make_primary_outbound_call(self, duration=None):
        
        logger.info("===== START Make Primary Outbound Call =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]
            request = data["requests"]["make_primary_outbound_call"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            type_value = request["type"]
            did1 = BuiltIn().get_variable_value("${DID_1}")

            if duration is None:
                duration = data["common"]["default_payload"]["duration"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "account": data["common"]["default_payload"]["account"],
                "region": data["common"]["default_payload"]["region"],
                "version": data["common"]["default_payload"]["version"],
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}"),
                "did": did1,
                "password": BuiltIn().get_variable_value("${DID_1_PASSWORD}"),
                "cmd": request["cmd"],
                "type": type_value,
                "media": data["common"]["default_payload"]["media"],
                "duration": duration,
                "callee_number": BuiltIn().get_variable_value("${CALLEE_NUMBER}")
            }

            url = base_url + request["endpoint"]

            for attempt in range(3):
                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.post(url, headers=headers, json=payload)

                    logger.info(f"Response Status Code: {response.status_code}")
                    logger.info(f"Response Text: {response.text}")

                    if response.status_code == 200:
                        return response.status_code
                    else:
                        logger.error("API call failed, removing container before retry")
                        self.remove_primary_container(type_value)

                except Exception as api_error:
                    logger.error(f"API exception: {api_error}")
                    self.remove_primary_container(type_value)

            raise Exception("Primary outbound call API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error in Make Primary Outbound Call: {e}")
            raise

    @keyword("Make Secondary Outbound Call")
    def make_secondary_outbound_call(self, duration=None, compareCaptionDuration=60):

        logger.info("===== START Make Secondary Outbound Call =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]
            request = data["requests"]["make_secondary_outbound_call"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            type_value = request["type"]
            did2 = BuiltIn().get_variable_value("${DID_2}")

            if duration is None:
                duration = data["common"]["default_payload"]["duration"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "account": data["common"]["default_payload"]["account"],
                "region": data["common"]["default_payload"]["region"],
                "version": data["common"]["default_payload"]["version"],
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}"),
                "did": did2,
                "password": BuiltIn().get_variable_value("${DID_2_PASSWORD}"),
                "cmd": request["cmd"],
                "type": type_value,
                "media": data["common"]["default_payload"]["media"],
                "duration": duration,
                "callee_number": BuiltIn().get_variable_value("${CALLEE_NUMBER}")
            }

            url = base_url + request["endpoint"]

            for attempt in range(3):

                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.post(url, headers=headers, json=payload)

                    logger.info(f"Response Status Code: {response.status_code}")
                    logger.info(f"Response Text: {response.text}")

                    if response.status_code == 200:
                        return response.status_code
                    else:
                        logger.error("API call failed, removing secondary container before retry")
                        self.remove_secondary_container(type_value)

                except Exception as api_error:
                    logger.error(f"API exception: {api_error}")
                    self.remove_secondary_container(type_value)

            logger.error("FAILED after 3 attempts")
            raise Exception("Secondary outbound call API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error in Make Secondary Outbound Call: {e}")
            raise


    @keyword("Dial Number With Keycodes")
    def dial_number_with_keycodes(self, number_to_dial):

        logger.info(f"Dialing number: {number_to_dial}")

        try:
            
            test_data_path = BuiltIn().get_variable_value("${TEST_DATA_YAML_FILE}")
            data = self.load_yaml(test_data_path)
            keycodes = data["keycodes"]

            digits = list(str(number_to_dial))

            for digit in digits:

                key_name = f"KEY_EVENT_{digit}"

                if key_name not in keycodes:
                    raise Exception(f"Keycode for digit {digit} not found in YAML")

                keycode = keycodes[key_name]

                for attempt in range(3):
                    try:
                        logger.info(f"Pressing key '{digit}' (Attempt {attempt+1})")

                        BuiltIn().run_keyword("Press Keycode", keycode)
                        time.sleep(0.3)

                        break  # success → exit retry loop

                    except Exception as key_error:
                        logger.error(f"Error pressing key '{digit}': {key_error}")

                        if attempt == 2:
                            raise Exception(f"Failed to press key '{digit}' after retries")

                        time.sleep(0.5)

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error while dialing number using keycodes: {e}")
            raise


    @keyword("Derive SIP Logs")
    def derive_sip_logs(self):

        logger.info("===== Deriving SIP Logs =====")

        try:
            voip_config_path = BuiltIn().get_variable_value("${VOIP_CONFIG_YAML_FILE}")
            data = self.load_yaml(voip_config_path)

            base_url = data["common"]["base_url"]

            headers = {
                "Authorization": data["common"]["headers"]["Authorization"],
                "x-auth-token": data["common"]["headers"]["x-auth-token"],
                "Content-Type": data["common"]["headers"]["Content-Type"],
            }

            request = data["requests"]["derive_sip_logs"]

            payload = {
                "user_name": BuiltIn().get_variable_value("${USERNAME}"),
                "blue_device_id": BuiltIn().get_variable_value("${BLUE_DEVICE_ID}")
            }

            url = base_url + request["endpoint"]

            logger.info(f"Derive SIP Logs URL: {url}")
            logger.info(f"Params: {payload}")

            for attempt in range(3):
                logger.info(f"===== Attempt {attempt+1} =====")

                try:
                    response = requests.get(url, headers=headers, params=payload)

                    logger.info(f"SIP Logs Status: {response.status_code}")
                    logger.info(f"Response: {response.text}")

                    if response.status_code == 200:
                        # Call Robot keyword
                        BuiltIn().run_keyword(
                            "Save SIP Logs To File",
                            response.text,
                            BuiltIn().get_variable_value("${BLUE_DEVICE_ID}")
                        )
                        return response

                    else:
                        logger.error("Derive SIP Logs API failed, retrying...")

                except Exception as api_error:
                    logger.error(f"API exception while deriving SIP logs: {api_error}")

            raise Exception("Derive SIP Logs API failed after 3 attempts")

        except KeyError as e:
            logger.error(f"Missing key in YAML configuration: {e}")
            raise Exception(f"Missing required YAML key: {e}")

        except Exception as e:
            logger.error(f"Error while deriving SIP logs: {e}")
            raise
