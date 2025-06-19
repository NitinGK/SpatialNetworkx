import requests

class HttpClientLibrary:
    """
    Custom robot framework library to interact with the http server.
    """
    def __init__(self, base_url="http://127.0.0.1:8000"):
        self.base_url = base_url
        self.last_response = None

    def set_base_url(self, url):
        """Set the base URL for the server."""
        self.base_url = url

    def send_command(self, command):
        """Send a command to the /command endpoint and store the response."""
        url = f"{self.base_url}/command"
        payload = {"command": command}
        self.last_response = requests.post(url, json=payload)
        return self.last_response

    def response_should_contain(self, expected):
        """Assert that the last response JSON contains the expected key-value pair."""
        assert self.last_response is not None, "No response available."
        data = self.last_response.json()
        for key, value in expected.items():
            assert key in data, f"Key '{key}' not in response."
            assert data[key] == value, f"Expected {key}: {value}, got {data[key]}"

    def response_status_should_be(self, status_code):
        """Assert that the last response status code matches the expected value."""
        assert self.last_response is not None, "No response available."
        assert self.last_response.status_code == int(status_code), \
            f"Expected status {status_code}, got {self.last_response.status_code}" 