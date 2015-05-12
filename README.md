# PFAboutWindow ![License](https://img.shields.io/badge/License-MIT-lightgreen.svg) ![Platform](https://img.shields.io/badge/Platform-OSX-blue.svg)
A sleek replacement for the otherwise bleak "About" dialog. Its nice, looks like xCode6's one, and offers the following abilities : 
* Open the app's website by clicking its (big) icon (in the dialog) (see *Usage* below)
* Extend the dialog to show the "License Agreement", or
* The "Acknowledgments" (see *Content* below)
* Translate the button's text (see *Localization* below)

![PFAboutWindow in action](https://raw.github.com/perfaram/PFAboutWindow/master/screenshots/PFAboutWindow.gif)
> Pull request welcome !

# Setup

## Manually

Clone this repo and add files from `PFAboutWindow` to your project.

## Using [cocoapods](http://cocoapods.org/)

Add `pod 'PFAboutWindow', :git => 'https://github.com/perfaram/PFAboutWindow.git'` to your `Podfile` and run `pod install`.
Add `use_frameworks!` to the end of the `Podfile`.

# Usage

For a live, detailed example, see in `PFAboutWindowExample` directory.

1. Import `PFAboutWindowController`:

  ```objc
  #import <PFAboutWindow/PFAboutWindowController.h>
  ```
2. Create a `@property`: 

  ```objc
  @property PFAboutWindowController *aboutWindowController;
  ```
3. Instantiate `PFAboutWindow` (in `applicationDidFinishLaunching:`, most likely) :

  ```objc
  self.aboutWindowController = [[PFAboutWindowController alloc] init];
  ```
  
  You may want to personalize what's going to show up on the window. As every property is accessible, you can tweak everything you want (see `PFAboutWindow/PFAboutWindowController.h` to see them all, and what they fall back to): 
  ```objc
  [self.aboutWindowController setAppURL:[[NSURL alloc] initWithString:@"http://app.faramaz.com"]];
  [self.aboutWindowController setAppCopyright:[[NSAttributedString alloc] initWithString:@"Nice Small String"
                                                                              attributes:@{
                                                          NSForegroundColorAttributeName:[NSColor tertiaryLabelColor],
                                                                     NSFontAttributeName:[NSFont fontWithName:@"HelveticaNeue" size:11]}]]; //NSAttributedStrings are real shit to work with
  [self.aboutWindowController setAppName:@"PFAbout"]; //'cause it's shorter
	```

4. Create an IBAction to display the window, and bind it to its caller (usually, the "About [your app]" menu item):
    ```objc
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
* Thanks to [**@DangerCove**](https://github.com/dangercove) for its DCOAboutWindow, which served as a ground for this (heavy) modification.
* Thanks to  [**@SoneeJohn**](https://github.com/SoneeJohn) for his numerous contributions

# License (MIT)
The MIT License (MIT)

Copyright (c) 2015 Perceval [**@perfaram**](https://github.com/perfaram) FARAMAZ

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

--------
###### Published in the hope that it will be useful
