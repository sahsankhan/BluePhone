from robot.api.deco import library
from ZmxMobAppTestLibrary import ZmxMobAppTestLibrary
from .AppiumTestLibrary import *
from .AndroidTestLibrary import *
from .iOSTestLibrary import *
from .ApplicationManagementTestLibrary import *
from .ElementTestLibrary import *
from .KeyEventTestLibrary import *
from .MobileUserDefinedKeywordsTestLibrary import *
from .RunOnFailureTestLibrary import *
from .ScreenRecordTestLibrary import *
from .ScreenShotTestLibrary import *
from .TouchActionTestLibrary import *
from .WaitingTestLibrary import *
from .WebDriverAgentLibrary import *

@library(scope='SUITE')
class MobAppTestLibrary(
    AppiumTestLibrary, 
    AndroidTestLibrary, 
    ApplicationManagementTestLibrary, 
    ElementTestLibrary, 
    iOSTestLibrary,
    KeyEventTestLibrary, 
    MobileUserDefinedKeywordsTestLibrary, 
    RunOnFailureTestLibrary, 
    ScreenRecordTestLibrary, 
    ScreenShotTestLibrary, 
    TouchActionTestLibrary, 
    WaitingTestLibrary, 
    WebDriverAgentLibrary,
):
    def __init__(self, timeout=10, run_on_failure="No Operation", sleep_between_wait_loop=0.3):
        # Create the ZmxMobAppTestLibrary instance
        self.zmx_instance = ZmxMobAppTestLibrary(
            timeout=timeout,
            run_on_failure=run_on_failure,
            sleep_between_wait_loop=sleep_between_wait_loop,
        )
        
        # Initialize libraries that need zmx_instance
        AppiumTestLibrary.__init__(self, self.zmx_instance)
        AndroidTestLibrary.__init__(self, self.zmx_instance)
        ApplicationManagementTestLibrary.__init__(self, self.zmx_instance)
        ElementTestLibrary.__init__(self, self.zmx_instance)
        iOSTestLibrary.__init__(self, self.zmx_instance)
        KeyEventTestLibrary.__init__(self, self.zmx_instance)
        MobileUserDefinedKeywordsTestLibrary.__init__(self, self.zmx_instance)
        RunOnFailureTestLibrary.__init__(self, self.zmx_instance)
        ScreenRecordTestLibrary.__init__(self, self.zmx_instance)
        ScreenShotTestLibrary.__init__(self, self.zmx_instance)
        TouchActionTestLibrary.__init__(self, self.zmx_instance)
        WaitingTestLibrary.__init__(self, self.zmx_instance)
        WebDriverAgentLibrary.__init__(self, self.zmx_instance)

    # Expose ZmxMobAppTestLibrary methods directly
    def __getattr__(self, name):
        """Delegate to zmx_instance for any missing methods"""
        if hasattr(self.zmx_instance, name):
            return getattr(self.zmx_instance, name)
        raise AttributeError(f"'{self.__class__.__name__}' object has no attribute '{name}'")
