//
//  ExternalMoviePlayer.h
//  MobileRemote
//
//  Created by Bryan Wood on 3/25/14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Cordova/CDVPlugin.h>

@interface ExternalMoviePlayer : CDVPlugin {
	UIWindow* externalWindow;
	UIScreen* externalScreen;
    MPMoviePlayerViewController* movieView;
    NSString *baseURLAddress;
    NSURL *baseURL;
    
    IBOutlet UIImageView *movieBackgroundImageView;
    IBOutlet UIView *backgroundView;
}

@property (nonatomic, retain) IBOutlet UIImageView *movieBackgroundImageView;
@property (nonatomic, retain) IBOutlet UIView *backgroundView;

//Public Instance Method (visible in phonegap API)
- (void) setupScreenConnectionNotificationHandlers:(CDVInvokedUrlCommand*)command;
- (void) playLocalMovie:(CDVInvokedUrlCommand*)command;
- (void) stopLocalMovie:(CDVInvokedUrlCommand*)command;
- (void) checkExternalScreenAvailable:(CDVInvokedUrlCommand*)command;


//Instance Method
- (void) attemptSecondScreenView;
- (void) handleScreenConnectNotification:(NSNotification*)aNotification;
- (void) handleScreenDisconnectNotification:(NSNotification*)aNotification;
@end
