# PFAboutWindow ![License](https://img.shields.io/badge/License-MIT-lightgreen.svg) ![Platform](https://img.shields.io/badge/Platform-OSX-blue.svg)
A replacement for the otherwise bleak "About" dialog. Its nice, looks like xCode6's one, and offers the following abilities : 
* Open the app's website by clicking its (big) icon (in the dialog) (see *Usage* below)
* Extend the dialog to show the "License Agreement", or
* The "Acknowledgments" (see *Content* below)
* Translate the button's text (see *Localization* below)

![PFAboutWindow in action](https://raw.github.com/perfaram/PFAboutWindow/master/screenshots/PFAboutWindow.gif)

# Setup

## Manually

Clone this repo and add files from `PFAboutWindow` to your project.

# Usage

For a live, detailed example, see in `PFAboutWindowExample` directory.

1. Import `PFAboutWindowController`:

  ```#import <PFAboutWindow/PFAboutWindowController.h>```
2. Create a `@property`: 

  ```@property PFAboutWindowController *aboutWindowController;```
3. Instantiate `PFAboutWindow` (in `applicationDidFinishLaunching:`, most likely) :

  ```self.aboutWindowController = [[PFAboutWindowController alloc] init];```
  
  You may want to personalize what's going to show up on the window. As every property is accessible, you can tweak everything you want (see `PFAboutWindow/PFAboutWindowController.h` to see them all, and what they fall back to): 
  ```
  [self.aboutWindowController setAppURL:[[NSURL alloc] initWithString:@"http://app.faramaz.com"]];
  [self.aboutWindowController setAppCopyright:[[NSAttributedString alloc] initWithString:@"Nice Small String"
                                                                              attributes:@{
                                                          NSForegroundColorAttributeName:[NSColor tertiaryLabelColor],
                                                                     NSFontAttributeName:[NSFont fontWithName:@"HelveticaNeue" size:11]}]]; //NSAttributedStrings are real shit to work with
  [self.aboutWindowController setAppName:@"PFAbout"]; //'cause it's shorter
	```

4. Create an IBAction to display the window, and bind it to its caller (usually, the "About [your app]" menu item):
    ```
    - (IBAction)showAboutWindow:(id)sender {
        [self.aboutWindowController showWindow:nil];
    }
    ```

5. You may also want the localize the buttons' text : 
   
   Add the following lines to your Localizable.string (below, for example, French)
   ```
    /* Version %@ (Build %@), displayed in the about window */
    "Version %@ (Build %@)" = "Version %@ (%@)";

    /* Caption of the 'Acknowledgments' button in the about window */
    "Credits" = "Remerciements";
    
    /* Caption of the 'License Agreement' button in the about window */
    "EULA" = "CL Utilisateur Final";
   ```

# Acknowledgments
Thanks to @DangerCove for its DCOAboutWindow, which served as a ground for this (heavy) modification. Thanks !
