//
//  ViewController.m
//  LinkDemo-ObjC
//
//  Copyright © 2019 Plaid Inc. All rights reserved.
//

#import "ViewController.h"

#import "ViewController+LinkToken.h"
#import "ViewController+PublicKey.h"
//#import "ViewController+OAuthSupport.h"

@interface ViewController ()
@property IBOutlet UIButton* button;
@property IBOutlet UILabel* label;
@property IBOutlet UIView* buttonContainerView;
@end

@implementation ViewController
@synthesize linkHandler = _linkHandler;

#pragma mark - PublicKey Configuration (Deprecated)
// See `ViewController+PublicKey.m` for usage of `oauthRedirectUri` & `oauthNonce`.

@synthesize oauthRedirectUri = _oauthRedirectUri;
@synthesize oauthNonce = _oauthNonce;

- (NSURL*)oauthRedirectUri {
    #warning Replace <#YOUR_OAUTH_REDIRECT_URI#> below with your oauthRedirectUri, which should be a universal link and must be configured in the Plaid developer dashboard
    return [NSURL URLWithString:@"<#YOUR_OAUTH_REDIRECT_URI#>"];
}

- (NSString*)oauthNonce {
    // To complete the OAuth flows ensure that the same oauthNonce is used per session.
    // This handling of oauthNonce is a simplified example for demonstaration purposes only.
    if (_oauthNonce == nil) {
        _oauthNonce = [[NSUUID UUID] UUIDString];
    }
    return _oauthNonce;
}

#pragma mark - Implementation

- (void)viewDidLoad {
    [super viewDidLoad];

    NSBundle* linkKitBundle = [NSBundle bundleForClass:[PLKPlaid class]];
    NSString* linkName      = [linkKitBundle objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    self.label.text         = [NSString stringWithFormat:@"Objective-C — %@ %@+%@"
                                 , linkName
                                 , [linkKitBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
                                 , [linkKitBundle objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];

    UIColor* shadowColor = [UIColor colorWithRed:3/255.0 green:49/255.0 blue:86/255.0 alpha:0.1];
    self.buttonContainerView.layer.shadowColor   = [shadowColor CGColor];
    self.buttonContainerView.layer.shadowOffset  = CGSizeMake(0, -1);
    self.buttonContainerView.layer.shadowRadius  = 2;
    self.buttonContainerView.layer.shadowOpacity = 1;
}

- (IBAction)didTapButton:(id)sender {
    typedef enum : NSUInteger {
        linkToken,
        linkPublicKey // for compatability with LinkKit v1
    } PlaidLinkSampleFlow;
    #warning Select your desired Plaid Link sample flow
    PlaidLinkSampleFlow sampleFlow = /*@START_MENU_TOKEN@*/linkToken/*[["linkToken","linkPublicKey"],[[[-1,0],[-1,1]]],[0]]@END_MENU_TOKEN@*/;
    switch (sampleFlow) {
        case linkToken:
            [self presentPlaidLinkUsingLinkToken];
            break;
        case linkPublicKey:
            [self presentPlaidLinkUsingPublicKey];
            break;
    }
}

@end
