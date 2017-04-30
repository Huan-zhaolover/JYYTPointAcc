//
//  textOCVC.m
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/30.
//  Copyright © 2017年 shjy. All rights reserved.
//

#import "textOCVC.h"

@interface textOCVC ()

@end

@implementation textOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tetGroupe];
    // Do any additional setup after loading the view.
}

-(void)tetGroupe{

    // 出组合入组相对应，不多不少
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t que = dispatch_get_global_queue(0, 0);
    
    
    dispatch_group_enter(group);  // 入组
    dispatch_async(que, ^{
        NSLog(@"aaaaa%@",[NSThread currentThread]);
        dispatch_group_leave(group); // 出组
    });
    
    dispatch_group_enter(group);
    dispatch_async(que, ^{
        NSLog(@"bbbbb%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(que, ^{
        NSLog(@"ccccccc%@",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, que, ^{
        
        NSLog(@"come herer%@",[NSThread currentThread]);
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
