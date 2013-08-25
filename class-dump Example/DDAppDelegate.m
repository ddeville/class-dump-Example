//
//  DDAppDelegate.m
//  class-dump Example
//
//  Created by Damien DeVille on 8/25/13.
//  Copyright (c) 2013 Damien DeVille. All rights reserved.
//

#import "DDAppDelegate.h"

#import "ClassDump/ClassDump.h"

@interface DDAppDelegate ()

@property (strong, nonatomic) NSOperationQueue *classDumpOperationQueue;

@end

@implementation DDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	NSOperationQueue *classDumpOpeartionQueue = [[NSOperationQueue alloc] init];
	[self setClassDumpOperationQueue:classDumpOpeartionQueue];
}

- (IBAction)classDump:(id)sender
{
	NSURL *executableLocation = [[NSBundle mainBundle] executableURL];
	
	NSURL *exportDirectoryLocation = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[[NSUUID UUID] UUIDString]];
	[[NSFileManager defaultManager] createDirectoryAtURL:exportDirectoryLocation withIntermediateDirectories:YES attributes:nil error:NULL];
	
	[self setLoading:YES];
	
	CDClassDumpOperation *classDumpOperation = [[CDClassDumpOperation alloc] initWithBundleOrExecutableLocation:executableLocation exportDirectoryLocation:exportDirectoryLocation];
	[[self classDumpOperationQueue] addOperation:classDumpOperation];
	
	NSOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^ {
		[self setLoading:NO];
		
		NSError *exportError = nil;
		NSURL *exportLocation = [classDumpOperation completionProvider](&exportError);
		if (exportLocation == nil) {
			[[NSApplication sharedApplication] presentError:exportError];
			return;
		}
		
		[[NSWorkspace sharedWorkspace] openURL:exportLocation];
	}];
	[completionOperation addDependency:classDumpOperation];
	[[NSOperationQueue mainQueue] addOperation:completionOperation];
}

@end
