#import "ViewController.h"
#import "GlossTest-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *dataUrl = @"http://jsonplaceholder.typicode.com/posts";
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    void (^completion)(NSData *data, NSURLResponse *response, NSError *error) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            Posts *posts = [[Posts alloc] initWithJsonArray:jsonArray];
            for(Post *item in posts.posts) {
                NSLog(@"Item: %@", item.body);
            }
        }
    };
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:completion];
    
    [downloadTask resume];

}

@end
