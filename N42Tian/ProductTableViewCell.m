//
//  ProductTableViewCell.m
//  N42Tian
//
//  Created by apple on 11/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductTableViewCell.h"
#import <AudioToolBox/AudioServices.h>

@implementation ProductTableViewCell {
    SystemSoundID _soundID;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadSoundEffect];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(IBAction)addToCartButton:(id)sender {
    NSIndexPath *indexPath = [self.delegate getButtonIndexPath:sender];
    [self.delegate addToCart:self atIndexPath:indexPath];
    [self playSoundEffect];
}

#pragma mark - Sound Effect
- (void)loadSoundEffect {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sound.caf" ofType:nil];
//    NSLog(@"Soud File Path is %@",path);
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil for path: %@", path);
        return;
    }
    
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundID);
    if (error != kAudioServicesNoError) {
        NSLog(@"Error code %ld loading sound at path: %@", error, path);
              return;
    }
}

- (void)unloadSoundEffect {
    AudioServicesDisposeSystemSoundID(_soundID);
    _soundID = 0;
}

- (void)playSoundEffect {
    AudioServicesPlaySystemSound(_soundID);
}




@end
