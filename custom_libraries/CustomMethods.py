from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn
import pyautogui


@library
class CustomMethods:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def zoomout(self):
        """
        Works on Windows/Mac/Linux
        """
        # pyautogui.press('enter')  # Presses enter
        # pyautogui.hotkey('ctrl', 'shift', 'esc')  # Performs ctrl+shift+esc
        pyautogui.hotkey('ctrl', 'subtract')
        pyautogui.hotkey('ctrl', 'subtract')
