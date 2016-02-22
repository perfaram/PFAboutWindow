//
//  PFAboutWindowController.m
//
//  Copyright (c) 2015 Perceval FARAMAZ (@perfaram). All rights reserved.
//

#import "PFAboutWindowController.h"

@interface PFAboutWindowController()

/** The window nib to load. */
+ (NSString *)nibName;

/** The info view. */
@property (assign) IBOutlet NSView *infoView;

/** The main text view. */
@property (assign) IBOutlet NSTextView *textField;

/** The button that opens the app's website. */
@property (assign) IBOutlet NSButton *visitWebsiteButton;

/** The button that opens the EULA. */
@property (assign) IBOutlet NSButton *EULAButton;

/** The button that opens the credits. */
@property (assign) IBOutlet NSButton *creditsButton;

/** The view that's currently active. */
@property (assign) NSView *activeView;

/** The string to hold the credits if we're showing them in same window. */
@property (copy) NSAttributedString *creditsString;

@end

@implementation PFAboutWindowController

#pragma mark - Class Methods

+ (NSString *)nibName {
    return @"PFAboutWindow";
}

#pragma mark - Overrides

- (id)init {
    
    self.windowShouldHaveShadow = YES;
	self.creditsFileExtension = @"rtf";
	self.eulaFileExtension = @"rtf";
	
    return [super initWithWindowNibName:[[self class] nibName]];
}

- (void)windowDidLoad {
    [super windowDidLoad];
	self.windowState = 0;
	self.infoView.layer.cornerRadius = 10.0;
	self.window.backgroundColor = [NSColor whiteColor];
    [self.window setHasShadow:self.windowShouldHaveShadow];
    // Change highlight of the `visitWebsiteButton` when it's clicked. Otherwise, the button will have a highlight around it which isn't visually pleasing.
       [self.visitWebsiteButton.cell setHighlightsBy:NSContentsCellMask];
   
    // Load variables
    NSDictionary *bundleDict = [[NSBundle mainBundle] infoDictionary];
    
    // Set app name
    if(!self.appName) {
        self.appName = [bundleDict objectForKey:@"CFBundleName"];
    }
    
    // Set app version
    if(!self.appVersion) {
        NSString *version = [bundleDict objectForKey:@"CFBundleVersion"];
        NSString *shortVersion = [bundleDict objectForKey:@"CFBundleShortVersionString"];
        self.appVersion = [NSString stringWithFormat:NSLocalizedString(@"Version %@ (Build %@)", @"Version %@ (Build %@), displayed in the about window"), shortVersion, version];
    }
	
    // Set copyright
    if(!self.appCopyright) {
        
        if (floor(NSAppKitVersionNumber) <= NSAppKitVersionNumber10_9){
            //On OS X Mavericks or below
            
            //Therefore we need to set properties that are available on OS X Mavericks or below
            self.appCopyright = [[NSAttributedString alloc] initWithString:[bundleDict objectForKey:@"NSHumanReadableCopyright"] attributes:@{
                                                                                                                                              NSForegroundColorAttributeName : [NSColor lightGrayColor],//Looks very close to 'tertiaryLabelColor' on OS X Yosemite
                                                                                                                                              NSFontAttributeName:[NSFont fontWithName:@"HelveticaNeue" size:11]/*/NSParagraphStyleAttributeName  : paragraphStyle*/}];
            
        } else{
            
            //On OS 10.10 or later. We don't need to do anything special
            
            self.appCopyright = [[NSAttributedString alloc] initWithString:[bundleDict objectForKey:@"NSHumanReadableCopyright"] attributes:@{
                                                                                                                                              NSForegroundColorAttributeName : [NSColor tertiaryLabelColor],
                                                                                                                                              NSFontAttributeName			: [NSFont fontWithName:@"HelveticaNeue" size:11]/*,
                                                                                                                                                                                                                             NSParagraphStyleAttributeName  : paragraphStyle*/}];
        }

    }
    
    @try {
        //Code that can potentially throw an exception
        
        // Set credits
        if(!self.appCredits) {
            self.appCredits = [[NSAttributedString alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"Credits" ofType:self.creditsFileExtension] documentAttributes:nil];
        }
        
        // Set EULA
        if(!self.appEULA) {
            self.appEULA = [[NSAttributedString alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"EULA" ofType:self.eulaFileExtension] documentAttributes:nil];
        }

    } @catch (NSException *exception) {
        // Handle an exception thrown in the @try block
        
        //The Credits or EULU could not be found at the default path
        
        //Hide buttons
        [self.creditsButton setHidden:YES];
        [self.EULAButton setHidden:YES];
        
        NSLog(@"PFAboutWindowController did handle exception: %@",exception);
    }

	[self.textField.textStorage setAttributedString:self.appCopyright];
	self.creditsButton.title = NSLocalizedString(@"Acknowledgments", @"Caption of the 'Credits' button in the about window");
	self.EULAButton.title = NSLocalizedString(@"License Agreement", @"Caption of the 'License Agreement' button in the about window");
}

- (BOOL)windowShouldClose:(id)sender {
	[self showCopyright:sender];
	return TRUE;
}

-(void) showCredits:(id)sender {
	if (self.windowState!=1) {
		CGFloat amountToIncreaseHeight = 100;
		NSRect oldFrame = [self.window frame];
		oldFrame.size.height += amountToIncreaseHeight;
		oldFrame.origin.y -= amountToIncreaseHeight;
		[self.window setFrame:oldFrame display:YES animate:NSAnimationLinear];
		self.windowState = 1;
	}
	[self.textField.textStorage setAttributedString:self.appCredits];
}

-(void) showEULA:(id)sender {
	if (self.windowState!=1) {
		CGFloat amountToIncreaseHeight = 100;
		NSRect oldFrame = [self.window frame];
		oldFrame.size.height += amountToIncreaseHeight;
		oldFrame.origin.y -= amountToIncreaseHeight;
		[self.window setFrame:oldFrame display:YES animate:NSAnimationLinear];
		self.windowState = 1;
	}
	[self.textField.textStorage setAttributedString:self.appEULA];
}

-(void) showCopyright:(id)sender {
	if (self.windowState!=0) {
		CGFloat amountToIncreaseHeight = -100;
		NSRect oldFrame = [self.window frame];
		oldFrame.size.height += amountToIncreaseHeight;
		oldFrame.origin.y -= amountToIncreaseHeight;
		[self.window setFrame:oldFrame display:YES animate:NSAnimationLinear];
		self.windowState = 0;
	}
	[self.textField.textStorage setAttributedString:self.appCopyright];
}

- (IBAction)visitWebsite:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:self.appURL];
}

- (void)showWindow:(id)sender
{
	// make sure the window will be visible and centered
	[NSApp activateIgnoringOtherApps:YES];
	[self.window center];
	
    [super showWindow:sender];
}

#pragma mark - Private Methods

@end
