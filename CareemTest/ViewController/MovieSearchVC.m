//
//  ViewController.m
//  CareemTest
//
//  Created by Peigen.Liu on 2017/11/24.
//

#import "MovieSearchVC.h"
#import "MovieSearchResultVC.h"

@interface MovieSearchVC () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    IBOutlet UITextField *_textField;
    IBOutlet UITableView *_historyTableView;
    IBOutlet UIView      *_backViewofTableView;
    IBOutlet UIButton    *_searchButton;

}

@end

@implementation MovieSearchVC

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setTitle:@"Search"];
    
    [self registerNotification];
    [self setupSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupSubviews{
    // Add mask to tableview
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.frame = _backViewofTableView.bounds;
    maskLayer.colors = @[(id)[[UIColor blackColor] CGColor],
                         (id)[[UIColor blackColor] CGColor],
                         (id)[[[UIColor blackColor] colorWithAlphaComponent:0.0f] CGColor]
                         ];
    maskLayer.startPoint = CGPointMake(0, 0);
    maskLayer.endPoint = CGPointMake(0, 1);
    _backViewofTableView.layer.mask = maskLayer;
    
    
    // Setup Search Button
    [_searchButton.layer setCornerRadius:_searchButton.frame.size.height/2.0f];
    [_searchButton.layer setBorderWidth:1.0f];
    [_searchButton.layer setBorderColor:[_searchButton.tintColor CGColor]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}



- (IBAction)searchButtonClicked:(id)sender{
    [self prepareForSearch];
}

- (void)prepareForSearch{
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
    
    [NetworkManager getMovieResultWithQuery:_textField.text WithPage:1 OnGetResultBack:^(NSInteger returnCode, SearchResult * _Nullable result) {
        __weak MovieSearchVC *weakSelf = self;

        if (returnCode == 200) {
            
            //Resign Responder
            [_textField resignFirstResponder];
            
            if (result.results.count == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nothing Found" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:okAction];
                
                [weakSelf presentViewController:alert animated:YES completion:^{
                    
                }];
                return;
            }
            
            [HistoryManager addToHistoryOfSearchWithQuery:_textField.text];
            [weakSelf performSegueWithIdentifier:@"Main2Result" sender:weakSelf];
        }else{
            // Handle Error Here
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Something wrong. Please try again." message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:okAction];
            
            [weakSelf presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *dVC = segue.destinationViewController;
    
    if ([dVC isMemberOfClass:[MovieSearchResultVC class]]) {
        [(MovieSearchResultVC*)dVC setQuery:_textField.text];
    }
}

- (IBAction)aboutMeClicked:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank You" message:@"Hi, My name is Parker. This is only a easy demo for a movie searching application. Feel free to send me an email if you have any question. \n Email : Parkerlpg@gmail.com" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

#pragma mark - TableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [HistoryManager historyOfSearch].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *history = [HistoryManager historyOfSearch];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryOfSearchTableViewCell"];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryOfSearchTableViewCell"];
    
    if (cell) {
        [cell.textLabel setText:[history objectAtIndex:indexPath.row]];
    }
    
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *history = [HistoryManager historyOfSearch];
    
    NSString *query = [history objectAtIndex:indexPath.row];
    [_textField setText:query];
    [_textField resignFirstResponder];
    [self prepareForSearch];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_historyTableView setHidden:NO];
    [_historyTableView reloadData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_historyTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

    [_historyTableView setHidden:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self prepareForSearch];
   
    //Resign Responder
    [_textField resignFirstResponder];
    return YES;
}


#pragma mark - Keyboard Notification
-(void)keyboardWillShow:(NSNotification *)note{
    NSDictionary *info = [note userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    CGRect frame = _searchButton.frame;
    int y = frame.origin.y + frame.size.height - (self.view.frame.size.height - keyboardSize.height);
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView animateWithDuration:animationDuration animations:^{
        if (y > 0) {
            _searchButton.transform = CGAffineTransformMakeTranslation(0, -y);
        }
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)note{
    NSTimeInterval animationDuration = 0.30f;

    [UIView animateWithDuration:animationDuration animations:^{
        _searchButton.transform = CGAffineTransformIdentity;

    }];
}

@end
