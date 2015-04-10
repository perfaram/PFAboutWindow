//
//  AppDelegate.m
//  PFAboutWindowExample
//
//  Created by Perceval FARAMAZ on 09/04/15.
//  Copyright (c) 2015 faramaz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	self.aboutWindowController = [[PFAboutWindowController alloc] init];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (IBAction)showAboutWindow:(id)sender {
	[self.aboutWindowController setAppURL:[[NSURL alloc] initWithString:@"http://app.faramaz.com"]];
	[self.aboutWindowController setAppName:@"PFAbout"];
	[self.aboutWindowController setAppCopyright:[[NSAttributedString alloc] initWithString:@"boo"
																				attributes:@{
														   NSForegroundColorAttributeName : [NSColor tertiaryLabelColor],
																	 NSFontAttributeName  : [NSFont fontWithName:@"HelveticaNeue" size:11]}]];
	[self.aboutWindowController showWindow:nil];
}

@end
