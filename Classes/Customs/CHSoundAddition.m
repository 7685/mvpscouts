//
//  CHSoundAddition.m
//  CityHypeVenue
//
//  Created by Hemant Kadam on 03/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CHSoundAddition.h"

#import "AudioToolbox/AudioToolbox.h"

@implementation CHSoundAddition

- (void)playSoundWithAudioFile:(NSString*)audioFileName{
    
//    if( ![self isSoundNotificationsEnabled] ) return;
//	
//	if (shouldVibrate) {
//#if TARGET_OS_IPHONE
//		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//#endif
//	}
	
	//Get the filename of the sound file:
	NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], audioFileName];
	
	//declare a system sound id
	SystemSoundID soundID;
	
	//Get a URL for the sound file
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
	
	//Use audio sevices to create the sound
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	
	//Use audio services to play the sound
	AudioServicesPlaySystemSound(soundID);
}

@end
