from robot.api.deco import library
from ZmxApiLibrary import ZmxApiLibrary
from .RequestsKeywordTestLibrary import *
from .SessionKeywordsTestLibrary import *

@library(scope='SUITE')
class ApiTestLibrary(
    SessionKeywordsTestLibrary,
    RequestsKeywordTestLibrary
):
    def __init__(self):
        self.api_instance = ZmxApiLibrary()
        RequestsKeywordTestLibrary.__init__(self, self.api_instance)
        SessionKeywordsTestLibrary.__init__(self, self.api_instance)
    
    # Expose ZmxApiTestLibrary methods directly
    def __getattr__(self, name):
        """Delegate to api_instance for any missing methods"""
        if hasattr(self.api_instance, name):
            return getattr(self.api_instance, name)
        raise AttributeError(f"'{self.__class__.__name__}' object has no attribute '{name}'")