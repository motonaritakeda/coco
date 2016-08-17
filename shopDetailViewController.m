//
//  shopDetailViewController.m
//  coco
//
//  Created by yuki on 2013/04/02.
//  Copyright (c) 2013年 Yuki Moriya. All rights reserved.
//
#import "AppDelegate.h"
#import "shopDetailViewController.h"
#import "PopinfoDetailViewController.h"
#import "PopinfoListViewController.h"
//#import "GAI.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@interface shopDetailViewController ()
{
    PopinfoReceiver *popinfoReceiver;
}
@end

@implementation shopDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)toTop{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:@"messageID"];
    [userDefaults synchronize];
    
    /*ViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Top"];
    ViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:ViewController animated:YES];*/
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad
{
    NSLog(@"ここきてる??");
    [super viewDidLoad];
    
    NSLog(@"ふろむぽっぷいんふぉ");
    [[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:@"FromPopinfo"];
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createAppView] build]];
    
	// Do any additional setup after loading the view.
    screenSize = [[UIScreen mainScreen] bounds].size;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]];
    [[self view] addSubview:headerView];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int messageId = (int)[userDefaults integerForKey:@"messageID"];
    
    NSArray *osarray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    osVerdion = [[osarray objectAtIndex:0] intValue];
    
   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        if (screenSize.height == 568.0f) {
            detailView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 548.0f)];
            [[self view] addSubview:detailView];
        }
        else{
            detailView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 460.0f)];
            [[self view] addSubview:detailView];
        }
    }
    else{
        if (screenSize.height == 568.0f) {
            detailView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -20.0f, 320.0f, 548.0f)];
            [[self view] addSubview:detailView];
        }
        else{
            detailView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -20.0f, 320.0f, 460.0f)];
            [[self view] addSubview:detailView];
        }
    }
    
    
    
    
    PopinfoListViewController *listVC = [[PopinfoListViewController alloc] initWithNibName:@"PopinfoListViewController" bundle:[NSBundle mainBundle]];
    navigationController = [[UINavigationController alloc] initWithRootViewController:listVC];
    navigationController.navigationBarHidden = NO;
    //navigationController.title = @"お知らせ";
    [self.navigationController.navigationBar setDelegate:self];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [detailView addSubview:navigationController.view];
    [popinfoReceiver updateMessages];
    
    PopinfoDetailViewController *detailVC =[[PopinfoDetailViewController alloc]
                                             initWithNibName:@"PopinfoDetailViewController"
                                             bundle:nil];
    detailVC.messageId = messageId;
    //detailVC.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgnormal.png"]];
    [navigationController pushViewController:detailVC animated:YES];
    
    
   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        modoruButton = [[UIButton alloc] initWithFrame:CGRectMake(5.0f, 6.0f, 64.0f, 32.0f)];
        NSString *open_path = [[NSString alloc] init];
        open_path = [[NSBundle mainBundle] pathForResource:@"closedetail" ofType:@"png"];
        [modoruButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:open_path] forState:UIControlStateNormal];
        [modoruButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
        [navigationController.view addSubview:modoruButton];
    }
    else{
        modoruButton = [[UIButton alloc] initWithFrame:CGRectMake(5.0f, 26.0f, 64.0f, 32.0f)];
        NSString *open_path = [[NSString alloc] init];
        open_path = [[NSBundle mainBundle] pathForResource:@"closedetail" ofType:@"png"];
        [modoruButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:open_path] forState:UIControlStateNormal];
        [modoruButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
        [navigationController.view addSubview:modoruButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
