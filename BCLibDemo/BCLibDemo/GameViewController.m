//
//  GameViewController.m
//  BCLibDemo
//
//  Created by Joanne Hoar on 2023-09-26.
//

#import "GameViewController.h"
#import "Renderer.h"

#define MAX_WAIT_SECS 120

@implementation GameViewController
{
    MTKView *_view;

    Renderer *_renderer;

    UITextView *_label;

    BrainCloudWrapper *m_bcWrapper;
    
    // accessible within completion blocks
    __block bool _result;
    __block NSString *_jsonResponse;
    __block NSInteger _statusCode;
    __block NSInteger _reasonCode;
    __block NSString *_statusMessage;

    BCCompletionBlock successBlock;
    BCErrorCompletionBlock failureBlock;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _view = (MTKView *)self.view;
    _label = [self.view viewWithTag:1234];
    
    _view.device = MTLCreateSystemDefaultDevice();
    _view.backgroundColor = UIColor.blackColor;
    
    if(!_view.device)
    {
        NSLog(@"Metal is not supported on this device");
        self.view = [[UIView alloc] initWithFrame:self.view.frame];
        return;
    }
    
    _renderer = [[Renderer alloc] initWithMetalKitView:_view];
    
    [_renderer mtkView:_view drawableSizeWillChange:_view.drawableSize];
    
    _view.delegate = _renderer;
    
    
    // --- Initializing the BrainCloud Wrapper
    m_bcWrapper = [[BrainCloudWrapper alloc] init];
    
    [m_bcWrapper initialize:@"https://api.braincloudservers.com/dispatcherV2"
                  secretKey:@""
                      appId:@""
                 appVersion:@"1.0"
                companyName:@"BitHeads"
                    appName:@"HelloBC"];
    [[m_bcWrapper getBCClient] enableLogging:TRUE];
    
    if([m_bcWrapper getBCClient].isInitialized){
        NSLog(@"\n\nInitialization complete.");
        [_label setText:[_label.text stringByAppendingString: @"\n\nInitialization complete."]];
    }
    else{
        NSLog(@"\n\nFailed to initialize - check server url, app id and secret key.");
        [_label setText:_label.text = [_label.text stringByAppendingString: @"\n\nFailed to initialize - check server url, app id and secret key."]];
        return;
    }
    
    // --- Authenticating BrainCloud User
    successBlock = ^(NSString *serviceName, NSString *serviceOperation, NSString *jsonData,
                     BCCallbackObject cbObject)
    {
        self->_result = true;
        self->_jsonResponse = jsonData;
        NSLog(@"\n\nServer Success received.\n");
        [self->_label setText:[self->_label.text stringByAppendingString: @"\n\nServer Success Response:\n"]];
        [self->_label setText:[self->_label.text stringByAppendingString: self->_jsonResponse]];
    };
    
    failureBlock = ^(NSString *serviceName, NSString *serviceOperation, NSInteger statusCode,
                     NSInteger returnCode, NSString *statusMessage, BCCallbackObject cbObject)
    {
        self->_result = true;
        self->_statusCode = statusCode;
        self->_reasonCode = returnCode;
        self->_statusMessage = statusMessage;
        NSLog(@"\n\nServer Failure received.\n");
        [_label setText:[_label.text stringByAppendingString: @"\n\nServer Failure Message:\n"]];
        [_label setText:[_label.text stringByAppendingString: _statusMessage]];
    };
    
    // this should pass
    [m_bcWrapper authenticateAnonymous:successBlock
                  errorCompletionBlock:failureBlock
                              cbObject:nil];
    
    // this should fail
    /*
    [m_bcWrapper authenticateEmailPassword:@"NOSUCHUSER"
                                  password:@"NOTFOO"
                               forceCreate:false
                           completionBlock:successBlock
                      errorCompletionBlock:failureBlock
                                  cbObject:nil];
     */
}

@end
