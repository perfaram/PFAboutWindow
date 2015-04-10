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
@property (assign) IBOutlet NSTextField *textField;

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
    return [super initWithWindowNibName:[[self class] nibName]];
}

- (void)windowDidLoad {
    [super windowDidLoad];
	self.windowState = 0;
	self.infoView.layer.cornerRadius = 10.0;
	self.window.backgroundColor = [NSColor whiteColor];
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
        self.appCopyright = [[NSAttributedString alloc] initWithString:[bundleDict objectForKey:@"NSHumanReadableCopyright"]];
    }
    
    // Set credits
    if(!self.appCredits) {
		self.appCredits = [[NSAttributedString alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"rtf"] documentAttributes:nil];
    }
	
	// Set EULA
	if(!self.appEULA) {
		self.appEULA = [[NSAttributedString alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"EULA" ofType:@"rtf"] documentAttributes:nil];
	}
	
	[self.textField setAttributedStringValue:self.appCopyright];
	self.creditsButton.title = NSLocalizedString(@"Credits", @"Caption of the 'Credits' button in the about window");
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
	[self.textField setAttributedStringValue:self.appCredits];
	//[[NSWorkspace sharedWorkspace] openFile:self.creditsPath];
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
	[self.textField setAttributedStringValue:self.appEULA];
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
	[self.textField setAttributedStringValue:self.appCopyright];
}

- (IBAction)visitWebsite:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:self.appURL];
}

- (void)showWindow:(id)sender {
    [super showWindow:sender];
}

#pragma mark - Private Methods

@end
