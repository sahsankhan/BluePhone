from robot.api.deco import library
from CommonUtils import CommonUtils
from .CryptographyTestLibrary import *
from .DateTimeTestLibrary import *
from .GmailTestLibrary import *
from .DataLoaderTestLibrary import *

@library(scope='SUITE')
class CommonUtilsTestLibrary(
    CryptographyTestLibrary,
    DateTimeTestLibrary,
    GmailTestLibrary,
    DataLoaderTestLibrary
):
    def __init__(self):
        self.common_instance = CommonUtils()
        CryptographyTestLibrary.__init__(self, self.common_instance),
        DateTimeTestLibrary.__init__(self, self.common_instance),
        GmailTestLibrary.__init__(self, self.common_instance),
        DataLoaderTestLibrary.__init__(self,self.common_instance)
    
    # Expose CommonUtils methods directly
    def __getattr__(self, name):
        """Delegate to common_instance for any missing methods"""
        if hasattr(self.common_instance, name):
            return getattr(self.common_instance, name)
        raise AttributeError(f"'{self.__class__.__name__}' object has no attribute '{name}'")