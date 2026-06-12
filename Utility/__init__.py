from robot.api.deco import library
from robot.libraries.BuiltIn import BuiltIn
from panacea_runtime.MobAppTestLibrary import MobAppTestLibrary
from .CommonMethods import CommonMethods
from .Voip import Voip

@library
class Utility(CommonMethods, Voip):

    def __init__(self):
        self._mob: MobAppTestLibrary = None

    @property
    def mob(self) -> MobAppTestLibrary:
        if self._mob is None:
            self._mob = BuiltIn().get_library_instance("MobAppTestLibrary")
        return self._mob
