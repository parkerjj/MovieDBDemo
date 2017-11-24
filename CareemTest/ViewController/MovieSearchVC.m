//
//  ViewController.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/24.
//

#import "MovieSearchVC.h"
#import "MovieSearchResultVC.h"

@interface MovieSearchVC (){
    IBOutlet UITextField *_textField;
}

@end

@implementation MovieSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)searchButtonClicked:(id)sender{
    if (_textField.text == nil || _textField.text.length == 0) {
        // No input
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Needs keywork to search" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        return;
    }
    [self performSegueWithIdentifier:@"Main2Result" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *dVC = segue.destinationViewController;
    
    if ([dVC isMemberOfClass:[MovieSearchResultVC class]]) {
        [(MovieSearchResultVC*)dVC setQuery:_textField.text];
    }
}



@end
