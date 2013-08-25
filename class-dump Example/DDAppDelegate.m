//
//  DDAppDelegate.m
//  class-dump Example
//
//  Created by Damien DeVille on 8/25/13.
//  Copyright (c) 2013 Damien DeVille. All rights reserved.
//

#import "DDAppDelegate.h"

@interface DDAppDelegate ()

@property (strong, nonatomic) NSOperationQueue *classDumpOperationQueue;

@end

@implementation DDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSOperationQueue *classDumpOpeartionQueue = [[NSOperationQueue alloc] init];
	[self setClassDumpOperationQueue:classDumpOpeartionQueue];
}

- (IBAction)classDump:(id)sender
{
	
}

@end
