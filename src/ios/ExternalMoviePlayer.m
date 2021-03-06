//
//  ExternalMoviePlayer.m
//  MobileRemote
//
//  Created by Bryan Wood on 3/25/14.
//
//

#import "ExternalMoviePlayer.h"

@implementation ExternalMoviePlayer

NSString* SCREEN_NOTIFICATION_HANDLERS_OK =@"External screen notification handlers initialized";

//used to determine if an external screen is available
- (void) checkExternalScreenAvailable:(CDVInvokedUrlCommand*)command
{
    NSString        *callbackId = command.callbackId;
    
    NSString* result = nil;
    if ([[UIScreen screens] count] > 1) {
        result = @"YES";
    }
    else
    {
        result = @"NO";
    }
    //[result retain];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: result];
    [self writeJavascript: [pluginResult toSuccessCallbackString:callbackId]];
    //[result release];
}

//used to initialize monitoring of external screen
- (void)setupScreenConnectionNotificationHandlers:(CDVInvokedUrlCommand*)command
{
    NSString *callbackId = command.callbackId;
    
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleScreenConnectNotification:) name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDisconnectNotification:) name:UIScreenDidDisconnectNotification object:nil];
    
    [self attemptSecondScreenView];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: SCREEN_NOTIFICATION_HANDLERS_OK];
    
    [self writeJavascript: [pluginResult toSuccessCallbackString:callbackId]];
}

//invoked when an additional screen is connected to iOS device (VGA or Airplay)
- (void)handleScreenConnectNotification:(NSNotification*)aNotification
{
    if (!externalWindow)
    {
        [self attemptSecondScreenView];
    }
}

//invoked when an additional screen is disconnected
- (void)handleScreenDisconnectNotification:(NSNotification*)aNotification
{
    if (externalWindow)
    {
        externalWindow.hidden = YES;
        externalWindow = nil;    }
    
    if (movieView)
    {
        movieView = nil;
    }
    
}

- (void) attemptSecondScreenView
{
    NSURL *path = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:@"videos/movie" ofType:@"mp4"]];
    if ([[UIScreen screens] count] > 1) {
        
		// Internal display is 0, external is 1.
		externalScreen = [[UIScreen screens] objectAtIndex:1];
        
        CGRect screenBounds = externalScreen.bounds;
        
        externalWindow = [[UIWindow alloc] initWithFrame:screenBounds];
        externalWindow.screen = externalScreen;
        
        externalWindow.frame = screenBounds;
        externalWindow.clipsToBounds = YES;
        
        movieView = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"videos/TestVideo.mp4"]];
        MPMoviePlayerController *player = [movieView moviePlayer];
        [player setControlStyle:MPMovieControlStyleNone];
        [player setFullscreen:TRUE];
        
        [externalWindow addSubview:movieView.view];
        [externalWindow makeKeyAndVisible];
        externalWindow.hidden = NO;
    }
    else
    {
        externalWindow.hidden = YES;
    }
}

@end
