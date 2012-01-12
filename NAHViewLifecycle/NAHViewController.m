//
//  NAHViewController.m
//  NAHViewLifecycle
//
//  Created by David Wagner on 12/01/2012.
//  Copyright (c) 2012 Noise & Heat. All rights reserved.
//

#import "NAHViewController.h"

#define LOG_FUNCTION_CALL [self log:__FUNCTION__]

static int uniqueish = 0;

@interface NAHViewController()

@property (nonatomic, strong) IBOutlet UILabel *identifierLabel;
@property (nonatomic, strong) NSString *identifier;

@end

@implementation NAHViewController

@synthesize identifier;
@synthesize identifierLabel;

- (void)log:(const char [])__function__
{
    NSString *function = [NSString stringWithCString:__function__ encoding:NSUTF8StringEncoding];
    NSError *error = NULL;
    NSRange range = {0, function.length};
    NSRegularExpression *nameGrabber = [NSRegularExpression regularExpressionWithPattern:@".*NAHViewController (.*)]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [nameGrabber firstMatchInString:function options:0 range:range];
    if (result.numberOfRanges > 1)
    {
        NSLog(@"[%@ %@]", self.title, [function substringWithRange:[result rangeAtIndex:1]]);
    }
    else
    {
        NSLog(@"[%@] -> %s", self.title, __function__);
    }
}

- (void)dealloc {
    LOG_FUNCTION_CALL;
}

- (void)didReceiveMemoryWarning
{
    LOG_FUNCTION_CALL;
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = [NSString stringWithFormat:@"%02d %@", uniqueish++, self.title];
    self.navigationItem.title = self.title;

    LOG_FUNCTION_CALL;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDate *now = [NSDate date];
    self.identifier = [NSDateFormatter localizedStringFromDate:now dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    if (self.identifierLabel)
    {
        self.identifierLabel.text = self.identifier;
    }
}

- (void)viewDidUnload
{
    LOG_FUNCTION_CALL;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    LOG_FUNCTION_CALL;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    LOG_FUNCTION_CALL;
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    LOG_FUNCTION_CALL;
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    LOG_FUNCTION_CALL;
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)dismissMe:(id)sender
{
    LOG_FUNCTION_CALL;
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)setNewRoot:(id)sender
{
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateInitialViewController];
}

@end
