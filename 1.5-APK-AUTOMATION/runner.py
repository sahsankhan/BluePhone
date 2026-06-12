import argparse

from panacea_runner import Panacea_Test_Runner

report_directory_path = "1.5-APK-AUTOMATION"
yaml_file_path        = "1.5-APK-AUTOMATION/test_execution.yaml"
test_data_file_path   = "1.5-APK-AUTOMATION/ConfigFiles/testdata.yaml"

config = {
    "ALM": False,
    "TERMINAL_LOG": False,
    "LOG_LENS": False,
    "AWS_S3": False,
    "OPENSEARCH": False
}

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--execution_id", default="")

    args = parser.parse_args()

    zmx = Panacea_Test_Runner(
        config,
        report_directory_path,
        yaml_file_path,
        test_data_file_path,
        args.execution_id
    )
    zmx.run_runner()