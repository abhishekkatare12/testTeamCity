//
//  FCCommenMethods.m
//  FingerControl
//
//  Created by Abhishek sharma on 27/11/12.
//
//

#import "FCCommenMethods.h"
#import "FCBezierPath.h"
#import "Constants.h"

@implementation FCCommenMethods
@synthesize shouldShowAd;
@synthesize player;
@synthesize playBackgroundSound;

@synthesize isEasyMode;
@synthesize numberOfCoins;
@synthesize freezeActivated;

@synthesize firstCharacterSetPurchased;
@synthesize secondCharacterSetPurchased;
@synthesize thirdCharacterSetPurchased;
@synthesize firstColorSetPurchased;
@synthesize secondColorSetPurchased;
@synthesize userSelectedCustomDrawingColor;


@synthesize rightDrawColor,leftDrawColor;
@synthesize leftDrawColorImage;
@synthesize rightDrawColorImage;
@synthesize colorIndexLeft,colorIndexRight;


+(FCCommenMethods* ) sharedInstance {
  static FCCommenMethods *sharedInstance = nil;
  if (!sharedInstance) {
    sharedInstance = [[self alloc] initPrivatly];
  }
  return sharedInstance;
}

-(id) initPrivatly {
  if (self == [super init]) {
    
    [self initiateAVPlayer];
    colorIndexLeft = -1;
    colorIndexRight = -1;
    firstColorSetPurchased = NO;
    secondColorSetPurchased = NO;
    userSelectedCustomDrawingColor = NO;
    
    self.numberOfCoins = 500000;
    //shouldShowAd = YES;
  }
  return self;
}


- (void) initiateAVPlayer {
  NSString *soundFilePath =
  [[NSBundle mainBundle] pathForResource: @"POL-lost-hero-short" ofType: @"wav"];
  NSURL *fileURL =
  [[NSURL alloc] initFileURLWithPath: soundFilePath];
  AVAudioPlayer *newPlayer =
  [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
  // this will show normal fortunes by default
  
  self.player = newPlayer;
  player.numberOfLoops = -1;
  player.currentTime = 0;
  player.volume = 1.0;
  playBackgroundSound = YES;
  
}

//*************************************************************************
//*************************************************************************

#pragma mark SetterGetter methods
//*************************************************************************
//*************************************************************************
- (void) setNumberOfCoins:(NSInteger)numberOfCoins {
  [[NSUserDefaults standardUserDefaults] setInteger:numberOfCoins forKey:@"coins"];
}

- (NSInteger) numberOfCoins {
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
}

- (void) setFirstColorSetPurchased:(BOOL)firstColorSetPurchased {
  [[NSUserDefaults standardUserDefaults] setBool:firstColorSetPurchased forKey:@"firstColorSetPurchased"];
}

- (BOOL) firstColorSetPurchased {

  return [[NSUserDefaults standardUserDefaults] boolForKey:@"firstColorSetPurchased"];
}

- (void) setSecondColorSetPurchased:(BOOL)secondColorSetPurchased {
 [[NSUserDefaults standardUserDefaults] setBool:secondColorSetPurchased forKey:@"secondColorSetPurchased"];
}

- (BOOL) secondColorSetPurchased {
  
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"secondColorSetPurchased"];
}

-(void) setFirstCharacterSetPurchased:(BOOL)firstCharacterSetPurchased {
 [[NSUserDefaults standardUserDefaults] setBool:firstCharacterSetPurchased forKey:@"firstCharacterSetPurchased"];
}

- (BOOL) firstCharacterSetPurchased {
 return [[NSUserDefaults standardUserDefaults] boolForKey:@"firstCharacterSetPurchased"];
}

- (void) setSecondCharacterSetPurchased:(BOOL)secondCharacterSetPurchased {
[[NSUserDefaults standardUserDefaults] setBool:secondCharacterSetPurchased forKey:@"secondCharacterSetPurchased"];
}
- (BOOL) secondCharacterSetPurchased {
return [[NSUserDefaults standardUserDefaults] boolForKey:@"secondCharacterSetPurchased"];
}


- (void) setThirdCharacterSetPurchased:(BOOL)thirdCharacterSetPurchased {

  [[NSUserDefaults standardUserDefaults] setBool:thirdCharacterSetPurchased forKey:@"thirdCharacterSetPurchased"];
}
- (BOOL) thirdCharacterSetPurchased {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"thirdCharacterSetPurchased"];
}


- (void)setUserSelectedCustomDrawingColor:(BOOL)userSelectedCustomDrawingColor {
 [[NSUserDefaults standardUserDefaults] setBool:userSelectedCustomDrawingColor forKey:@"userSelectedCustomDrawingColor"];
}

- (BOOL) userSelectedCustomDrawingColor {
  
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"userSelectedCustomDrawingColor"];
}

- (void) setFreezeActivated:(BOOL)freezeActivated {

  [[NSUserDefaults standardUserDefaults] setBool:freezeActivated forKey:@"freezeActivated"];
}

- (BOOL) freezeActivated {
  
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"freezeActivated"];
}

- (void) setLeftDrawColor:(UIColor *)leftDrawColor {
  NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:leftDrawColor];
  [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"leftDrawColor"];
  
}

- (UIColor* ) leftDrawColor {
 
  //retrieve
  NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"leftDrawColor"];
  return [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
  
}

- (void) setRightDrawColor:(UIColor *)rightDrawColor {

  NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:rightDrawColor];
  [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"rightDrawColor"];
}

- (UIColor* ) rightDrawColor {
  
  NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"rightDrawColor"];
  return [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
}

- (void) setLeftDrawColorImage:(UIImage *)leftDrawColorImage {

  [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(leftDrawColorImage) forKey:@"leftDrawColorImage"];
}

- (UIImage* ) leftDrawColorImage {
  //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"leftDrawColorImage"]);
  return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"leftDrawColorImage"]];
  
}

- (void) setRightDrawColorImage:(UIImage *)rightDrawColorImage {
  [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(rightDrawColorImage) forKey:@"rightDrawColorImage"];
}

- (UIImage* ) rightDrawColorImage {
  
  return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"rightDrawColorImage"]];
  
}

- (void) setColorIndexLeft:(NSInteger)colorIndexLeft {
    [[NSUserDefaults standardUserDefaults] setInteger:colorIndexLeft forKey:@"colorIndexLeft"];
}
- (NSInteger) colorIndexLeft {
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"colorIndexLeft"];
}
- (void) setColorIndexRight:(NSInteger)colorIndexRight {
  [[NSUserDefaults standardUserDefaults] setInteger:colorIndexRight forKey:@"colorIndexRight"];
}
- (NSInteger) colorIndexRight {
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"colorIndexRight"];
}


//*************************************************************************
//*************************************************************************

- (void) playSound {
  if (self.playBackgroundSound) {
    self.player.numberOfLoops = -1;
    self.player.currentTime = 0;
    [self.player play];
  }
  
  
}
- (void) pauseSound {
  [[self player] pause];
}
- (void) stopSound {
  [[self player] stop];
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  [self playSound];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
  
}


@end









int numberOfAlphabet() {
  int number = NUMBEROFALPHABET;
  if ([FCCOMMEN firstCharacterSetPurchased]) {
    number+=4;
  }
  if ([FCCOMMEN secondCharacterSetPurchased]) {
    number+=4;
  }
  if ([FCCOMMEN thirdCharacterSetPurchased]) {
    number+=9;
  }
  return number;
  
}


NSArray* getColorsArray () {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  if (FCCOMMEN.firstColorSetPurchased) {
    [array addObjectsFromArray:[NSArray arrayWithObjects:REDCOLOR,VOILETCOLOR,GREENCOLOR ,nil]];
  }
  if (FCCOMMEN.secondColorSetPurchased) {
    [array addObjectsFromArray:[NSArray arrayWithObjects:PINKCOLOR,YELLOWCOLOR,GREENCOLOR ,nil]];
  }
  
  return array;
}

NSArray* getcolorImages() {

  NSMutableArray *array = [[NSMutableArray alloc] init];
  if (FCCOMMEN.firstColorSetPurchased) {
    [array addObjectsFromArray:[NSArray arrayWithObjects:@"red.png",@"Voilet.png",@"green.png", nil]];
  }
  if (FCCOMMEN.secondColorSetPurchased) {
    [array addObjectsFromArray:[NSArray arrayWithObjects:@"pink.png",@"yellow.png",@"blueLight.png", nil]];
  }
  return array;
}


BOOL isNotFirstTime() {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"FIRSTTIME"];
}

//*********************************************************************
          //Creating Random Dictonary for alphabet
//*********************************************************************

#pragma mark alphabetDataForIndex
NSDictionary* alphabetDataForIndex(int x) {
  
   NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  if (x <= NUMBEROFALPHABET) {
   
    
//    [dict setObject:bezierPathArrayForAlphabet9() forKey:BEZIERPATHS];
//    [dict setObject: NINETestBezierPath() forKey:TESTPATH];
//    return dict;
    switch (x) {
      case 1: {
        [dict setObject:bezierPathArrayForAlphabetA() forKey:BEZIERPATHS];
        [dict setObject:ATestBezierPath() forKey:TESTPATH];
        break;
      }
        
      case 2: {
        [dict setObject:bezierPathArrayForAlphabetC() forKey:BEZIERPATHS];
        [dict setObject:CTestBezierPath() forKey:TESTPATH];
        break;
      }
      case 3: {
        [dict setObject:bezierPathArrayForAlphabetD() forKey:BEZIERPATHS];
        [dict setObject:DTestBezierPath() forKey:TESTPATH];
        break;
      }
      case 4: {
        [dict setObject:bezierPathArrayForAlphabetE() forKey:BEZIERPATHS];
        [dict setObject:ETestBezierPath() forKey:TESTPATH];
        break;
      }
      case 5: {
        [dict setObject:bezierPathArrayForAlphabetF() forKey:BEZIERPATHS];
        [dict setObject:FTestBezierPath() forKey:TESTPATH];
        break;
      }
      case 6: {
        [dict setObject:bezierPathArrayForAlphabetG() forKey:BEZIERPATHS];
        [dict setObject:GTestBezierPath() forKey:TESTPATH];
        break;
      }
      case 7: {
        [dict setObject:bezierPathArrayForAlphabetH() forKey:BEZIERPATHS];
        [dict setObject:HTestBezierPath() forKey:TESTPATH];
        
        
        break;
      }
      
      case 8: {
        [dict setObject:bezierPathArrayForAlphabetJ() forKey:BEZIERPATHS];
        [dict setObject:JTestBezierPath() forKey:TESTPATH];
        
        
        break;
      }
      case 9: {
        [dict setObject:bezierPathArrayForAlphabetK() forKey:BEZIERPATHS];
        [dict setObject:KTestBezierPath() forKey:TESTPATH];
        
        break;
      }
     
      case 10: {
        [dict setObject:bezierPathArrayForAlphabetM() forKey:BEZIERPATHS];
        [dict setObject:MTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      
      case 11: {
        [dict setObject:bezierPathArrayForAlphabetN() forKey:BEZIERPATHS];
        [dict setObject:NTestBezierPath() forKey:TESTPATH];
        
        break;
      }
        
      
      case 12: {
        [dict setObject:bezierPathArrayForAlphabetT() forKey:BEZIERPATHS];
        [dict setObject:TTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      case 13: {
        [dict setObject:bezierPathArrayForAlphabetU() forKey:BEZIERPATHS];
        [dict setObject:UTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      case 14: {
        [dict setObject:bezierPathArrayForAlphabetV() forKey:BEZIERPATHS];
        [dict setObject:VTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      case 15: {
        [dict setObject:bezierPathArrayForAlphabetW() forKey:BEZIERPATHS];
        [dict setObject:WTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      case 16: {
        [dict setObject:bezierPathArrayForAlphabetX() forKey:BEZIERPATHS];
        [dict setObject:XTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      case 17: {
        [dict setObject:bezierPathArrayForAlphabetY() forKey:BEZIERPATHS];
        [dict setObject:YTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      case 18: {
        [dict setObject:bezierPathArrayForAlphabetZ() forKey:BEZIERPATHS];
        [dict setObject:ZTestBezierPath() forKey:TESTPATH];
        
        break;
      }
      default:
        break;
    }

  }
  else if (x <= NUMBEROFALPHABET +4  ) {
    if ([FCCOMMEN firstCharacterSetPurchased]) {
      dict = alphabetDataForFirstSetAtIndex(x-NUMBEROFALPHABET);
    }
    else if ([FCCOMMEN secondCharacterSetPurchased]) {
      dict = alphabetDataForSecondSetAtIndex(x-NUMBEROFALPHABET);
    }
    else {
      dict = alphabetDataForThirdSetAtIndex (x-NUMBEROFALPHABET);
    }
  }
  else if(x <= NUMBEROFALPHABET +8 ){
    if ([FCCOMMEN secondCharacterSetPurchased] && [FCCOMMEN firstCharacterSetPurchased]) {
      dict = alphabetDataForSecondSetAtIndex(x-NUMBEROFALPHABET-4);
    }
    else {
      if ([FCCOMMEN secondCharacterSetPurchased] || [FCCOMMEN firstCharacterSetPurchased]) {
        dict = alphabetDataForThirdSetAtIndex (x-NUMBEROFALPHABET-4);
      }
      else
        dict = alphabetDataForThirdSetAtIndex (x-NUMBEROFALPHABET);
    }
  }
  else {
    if ([FCCOMMEN secondCharacterSetPurchased] && [FCCOMMEN firstCharacterSetPurchased]) {
      dict = alphabetDataForThirdSetAtIndex (x-NUMBEROFALPHABET-8);
    }
    else if ([FCCOMMEN secondCharacterSetPurchased] || [FCCOMMEN firstCharacterSetPurchased]) {
      dict = alphabetDataForThirdSetAtIndex (x-NUMBEROFALPHABET-4);
    }
    else
      dict = alphabetDataForThirdSetAtIndex (x-NUMBEROFALPHABET);
  }
  
  return dict;
}


NSMutableDictionary* alphabetDataForFirstSetAtIndex (int x) {
  
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  switch (x) {
    case 1:
      [dict setObject:bezierPathArrayForAlphabetI() forKey:BEZIERPATHS];
      [dict setObject:ITestBezierPath() forKey:TESTPATH];
      break;
    case 2:
      [dict setObject:bezierPathArrayForAlphabetB() forKey:BEZIERPATHS];
      [dict setObject:BTestBezierPath() forKey:TESTPATH];
      break;
    case 3:
      [dict setObject:bezierPathArrayForAlphabetO() forKey:BEZIERPATHS];
      [dict setObject:OTestBezierPath() forKey:TESTPATH];
      break;
    case 4:
      [dict setObject:bezierPathArrayForAlphabetP() forKey:BEZIERPATHS];
      [dict setObject:PTestBezierPath() forKey:TESTPATH];
      break;
      
    default:
      break;
  }
  return dict;
}


NSMutableDictionary* alphabetDataForSecondSetAtIndex (int x) {
  
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  switch (x) {
    case 1:
      [dict setObject:bezierPathArrayForAlphabetL() forKey:BEZIERPATHS];
      [dict setObject:LTestBezierPath() forKey:TESTPATH];
      break;
    case 2:
      [dict setObject:bezierPathArrayForAlphabetQ() forKey:BEZIERPATHS];
      [dict setObject:QTestBezierPath() forKey:TESTPATH];
      break;
    case 3:
      [dict setObject:bezierPathArrayForAlphabetS() forKey:BEZIERPATHS];
      [dict setObject:STestBezierPath() forKey:TESTPATH];
      break;
    case 4:
      [dict setObject:bezierPathArrayForAlphabetR() forKey:BEZIERPATHS];
      [dict setObject:RTestBezierPath() forKey:TESTPATH];
      break;
      
    default:
      break;
  }
  return dict;
}

NSMutableDictionary* alphabetDataForThirdSetAtIndex (int x) {
  
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  switch (x) {
    case 1:
      [dict setObject:bezierPathArrayForAlphabet1() forKey:BEZIERPATHS];
      [dict setObject:ONETestBezierPath() forKey:TESTPATH];
      break;
    case 2:
      [dict setObject:bezierPathArrayForAlphabet2() forKey:BEZIERPATHS];
      [dict setObject:TWOTestBezierPath() forKey:TESTPATH];
      break;
    case 3:
      [dict setObject:bezierPathArrayForAlphabet3() forKey:BEZIERPATHS];
      [dict setObject:THREETestBezierPath() forKey:TESTPATH];
      break;
    case 4:
      [dict setObject:bezierPathArrayForAlphabet4() forKey:BEZIERPATHS];
      [dict setObject:FOURTestBezierPath() forKey:TESTPATH];
      break;
    case 5:
      [dict setObject:bezierPathArrayForAlphabet5() forKey:BEZIERPATHS];
      [dict setObject:FIVEestBezierPath() forKey:TESTPATH];
      break;
    case 6:
      [dict setObject:bezierPathArrayForAlphabet6() forKey:BEZIERPATHS];
      [dict setObject:SIXTestBezierPath() forKey:TESTPATH];
      break;
    case 7:
      [dict setObject:bezierPathArrayForAlphabet7() forKey:BEZIERPATHS];
      [dict setObject:SEVENTestBezierPath() forKey:TESTPATH];
      break;
    case 8:
      [dict setObject:bezierPathArrayForAlphabet8() forKey:BEZIERPATHS];
      [dict setObject:EIGHTTestBezierPath() forKey:TESTPATH];
      break;
    case 9:
      [dict setObject:bezierPathArrayForAlphabet9() forKey:BEZIERPATHS];
      [dict setObject:NINETestBezierPath() forKey:TESTPATH];
      break;
    default:
      break;
  }
  return dict;
}


//*********************************************************************
//Creating Array of bezier paths For alphabets
//*********************************************************************


#pragma mark PathArrays For Alphabets

#pragma mark PathArrays For A
NSArray* bezierPathArrayForAlphabetA() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 7.0, DRAWALPHABET_OFFSET_Y + 150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 57.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 117.0, DRAWALPHABET_OFFSET_Y +120.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 62.0, DRAWALPHABET_OFFSET_Y +120)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  //*********************************************************
  //**********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 77.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 89.0,DRAWALPHABET_OFFSET_Y +50.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 102.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 setLineJoinStyle:kCGLineJoinRound];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];

}

//********************************************************
#pragma mark TestPath For A
//********************************************************
UIBezierPath* ATestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.5,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 73.0,DRAWALPHABET_OFFSET_Y +33.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105.0,DRAWALPHABET_OFFSET_Y +33.0)];
//  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.5, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 142.5,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 131.0,DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 48.0,DRAWALPHABET_OFFSET_Y +100.0)];
//  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102)];
  
  //[aPath3 closePath];
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For B
//*********************************************************

NSArray* bezierPathArrayForAlphabetB() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************

  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];

  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 151.0, DRAWALPHABET_OFFSET_Y +75.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +132)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +56.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +56.0)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102)];

  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +106.0)];

  [aPath3 setLineDash:dashArray count:2 phase:0];
  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  
  FCBezierPath *bezierPath3 = [[FCBezierPath alloc] init];
  [bezierPath3 setBezierPath:aPath3];
  [bezierPath3 setCheckOuter:YES];

  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2,bezierPath3, nil];
  
}
//********************************************************
#pragma mark TestPath For B
//********************************************************
UIBezierPath* BTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102)];
  
  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For C
//*********************************************************

NSArray* bezierPathArrayForAlphabetC() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  

  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32.0, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +20)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60,DRAWALPHABET_OFFSET_Y +46.0)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +56) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +96)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];

  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For C
//********************************************************
UIBezierPath* CTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130.0,DRAWALPHABET_OFFSET_Y +126.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47, DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +26.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 28, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 26, DRAWALPHABET_OFFSET_Y +40)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +26.0)];
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For D
//*********************************************************

NSArray* bezierPathArrayForAlphabetD() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +133)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +6.0)];
  
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +56) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0,DRAWALPHABET_OFFSET_Y +106.0)];
  //[aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +46.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +56)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
  
}
//********************************************************
#pragma mark TestPath For D
//********************************************************
UIBezierPath* DTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +40.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +113)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30, DRAWALPHABET_OFFSET_Y +126.0)];
   [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30, DRAWALPHABET_OFFSET_Y +26.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For E
//*********************************************************
NSArray* bezierPathArrayForAlphabetE() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0, DRAWALPHABET_OFFSET_Y +100)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +100.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +110.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +110.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
    
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For E
//********************************************************
UIBezierPath* ETestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For F
//*********************************************************
NSArray* bezierPathArrayForAlphabetF() {

  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0, DRAWALPHABET_OFFSET_Y +100)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +100.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +150.0)];
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +110.0)];
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
 
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For F
//********************************************************
UIBezierPath* FTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +130.0)];
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For G
//*********************************************************

NSArray* bezierPathArrayForAlphabetG() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32.0, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +20)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60,DRAWALPHABET_OFFSET_Y +46.0)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +56) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +96)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100, DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +146.0)];
  
  
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For G
//********************************************************
UIBezierPath* GTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +126.0)];
  
  //[aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130.0,DRAWALPHABET_OFFSET_Y +126.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47, DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +26.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 28, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 26, DRAWALPHABET_OFFSET_Y +40)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +26.0)];
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For H
//*********************************************************
NSArray* bezierPathArrayForAlphabetH() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +60)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115, DRAWALPHABET_OFFSET_Y +60)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115.0, DRAWALPHABET_OFFSET_Y +10.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +10.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115.0, DRAWALPHABET_OFFSET_Y +150.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115.0, DRAWALPHABET_OFFSET_Y +100.0)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +100.0)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For H
//********************************************************
UIBezierPath* HTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  //[aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 135.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 135.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 135.0,DRAWALPHABET_OFFSET_Y +130.0)];
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For I
//*********************************************************
NSArray* bezierPathArrayForAlphabetI() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 90, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 90, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +150)];
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For I
//********************************************************
UIBezierPath* ITestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  //[aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 70.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 70.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For J
//*********************************************************

NSArray* bezierPathArrayForAlphabetJ() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 52.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +133)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +96.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 51, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +96)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108, DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +46.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 52, DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath closePath];
  //  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +146.0)];
  //  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
  //  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];

  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For J
//********************************************************
UIBezierPath* JTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 72.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 135,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 133, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 133, DRAWALPHABET_OFFSET_Y +113)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 42, DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0, DRAWALPHABET_OFFSET_Y +110.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0, DRAWALPHABET_OFFSET_Y +113)];
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For K
//*********************************************************
NSArray* bezierPathArrayForAlphabetK() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 7.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47, DRAWALPHABET_OFFSET_Y +60)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +10.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 90.0, DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +100.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 7.0, DRAWALPHABET_OFFSET_Y +150.0)];
  //
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For K
//********************************************************
UIBezierPath* KTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 27,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 27.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 27.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  
    [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120,DRAWALPHABET_OFFSET_Y +30.0)];
    [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120,DRAWALPHABET_OFFSET_Y +130.0)];
  //
  //  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +130.0)];
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For L
//*********************************************************
NSArray* bezierPathArrayForAlphabetL() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15, DRAWALPHABET_OFFSET_Y +150.0)];
  
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For L
//********************************************************
UIBezierPath* LTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130,DRAWALPHABET_OFFSET_Y +130.0)];
 
  //  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +130.0)];
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}
//*********************************************************
#pragma mark PathArrays For M
//*********************************************************
NSArray* bezierPathArrayForAlphabetM() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y + 6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +6.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85, DRAWALPHABET_OFFSET_Y +28)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115, DRAWALPHABET_OFFSET_Y +6)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170.0, DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +150.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +46)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85, DRAWALPHABET_OFFSET_Y +73)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +150.0)];
  
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For M
//********************************************************
UIBezierPath* MTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50,DRAWALPHABET_OFFSET_Y +26.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85,DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 126.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For N
//*********************************************************
NSArray* bezierPathArrayForAlphabetN() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 67.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +100)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170.0, DRAWALPHABET_OFFSET_Y +10.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +150.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +60)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15, DRAWALPHABET_OFFSET_Y +150.0)];
  
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For N
//********************************************************
UIBezierPath* NTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 57,DRAWALPHABET_OFFSET_Y +30.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 128.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For O
//*********************************************************

NSArray* bezierPathArrayForAlphabetO() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +133)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32.0, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +20)];
  
  
  
  //  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +146.0)];
  //  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
  //  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +56) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +46.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +56)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
  
}
//********************************************************
#pragma mark TestPath For O
//********************************************************
UIBezierPath* OTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +40.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +113)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47, DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +26.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 28, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 26, DRAWALPHABET_OFFSET_Y +40)];
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For P
//*********************************************************

NSArray* bezierPathArrayForAlphabetP() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];
  
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +96.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +83)];
  
  //[aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +132)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +56.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +56.0)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
    
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
  
}
//********************************************************
#pragma mark TestPath For P
//********************************************************
UIBezierPath* PTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +76.0)];
//  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +76.0)];
//  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102)];
//  
//  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For Q
//*********************************************************

NSArray* bezierPathArrayForAlphabetQ() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];
 // [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +133)];
   [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +110.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0,DRAWALPHABET_OFFSET_Y +150.0)];
   [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0,DRAWALPHABET_OFFSET_Y +150.0)];
   [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 134.0,DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +146.0)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
   [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32.0, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +20)];
 
  
  
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +146.0)];
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
//  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +56) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96)];
  
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +46.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +56)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
  
}
//********************************************************
#pragma mark TestPath For Q
//********************************************************
UIBezierPath* QTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +40.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +113)];
  
  

  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0,DRAWALPHABET_OFFSET_Y +126.0)];
   [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 145.0,DRAWALPHABET_OFFSET_Y +136.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0,DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 119.0,DRAWALPHABET_OFFSET_Y +126.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47, DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +26.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 28, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 26, DRAWALPHABET_OFFSET_Y +40)];

  
  
  

  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For R
//*********************************************************

NSArray* bezierPathArrayForAlphabetR() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];
  
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +96.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +83)];
  
  //[aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +132)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108, DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 168.0, DRAWALPHABET_OFFSET_Y +146.0)];
   [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 106.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +96.0)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +56.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +56.0)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
  
}
//********************************************************
#pragma mark TestPath For R
//********************************************************
UIBezierPath* RTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115.0,DRAWALPHABET_OFFSET_Y +126.0)];

  //  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For S
//*********************************************************

NSArray* bezierPathArrayForAlphabetS() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10.0, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0, DRAWALPHABET_OFFSET_Y +150.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +60.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +130.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +90)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +50.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +55.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +55.0)];
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +100.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 0, DRAWALPHABET_OFFSET_Y +30.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 2, DRAWALPHABET_OFFSET_Y +70)];

  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105, DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105.0, DRAWALPHABET_OFFSET_Y +110.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 116.0, DRAWALPHABET_OFFSET_Y +105.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +105.0)];
  
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +110.0)];
  
  [aPath closePath];
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +150.0)];
  
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For S
//********************************************************
UIBezierPath* STestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40, DRAWALPHABET_OFFSET_Y +80.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 25, DRAWALPHABET_OFFSET_Y +45.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 25, DRAWALPHABET_OFFSET_Y +65.0)];
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120, DRAWALPHABET_OFFSET_Y +130.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 135, DRAWALPHABET_OFFSET_Y +95.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 135, DRAWALPHABET_OFFSET_Y +115.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For T
//*********************************************************
NSArray* bezierPathArrayForAlphabetT() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.5, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.5, DRAWALPHABET_OFFSET_Y + 150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 73.5, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 73.5, DRAWALPHABET_OFFSET_Y +50)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y +50.0)];
  //
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For T
//********************************************************
UIBezierPath* TTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 152.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 93.5,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 93.5,DRAWALPHABET_OFFSET_Y +130.0)];
  
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For U
//*********************************************************

NSArray* bezierPathArrayForAlphabetU() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  //[aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 52.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 155.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +133)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 32, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +133)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 51, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +96)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108, DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +96)];

  [aPath closePath];
   // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For U
//********************************************************
UIBezierPath* UTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  //[aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 72.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 135,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 123.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 133, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 133, DRAWALPHABET_OFFSET_Y +113)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 43, DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0, DRAWALPHABET_OFFSET_Y +26.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 26, DRAWALPHABET_OFFSET_Y +113.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 26, DRAWALPHABET_OFFSET_Y +113)];

  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For V
//*********************************************************
NSArray* bezierPathArrayForAlphabetV() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 7.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 53.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 89, DRAWALPHABET_OFFSET_Y +104)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 126, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 172.0, DRAWALPHABET_OFFSET_Y +10.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 57.0, DRAWALPHABET_OFFSET_Y +150)];
  //  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +100.0)];
  //
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For V
//********************************************************
UIBezierPath* VTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 38,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 75.0,DRAWALPHABET_OFFSET_Y +127.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 104.0,DRAWALPHABET_OFFSET_Y +127.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 142.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For W
//*********************************************************
NSArray* bezierPathArrayForAlphabetW() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y + 150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +150.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85, DRAWALPHABET_OFFSET_Y +128)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 115, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +6.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85, DRAWALPHABET_OFFSET_Y +83)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +110.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +6.0)];
  
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For W
//********************************************************
UIBezierPath* WTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50,DRAWALPHABET_OFFSET_Y +130.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85,DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 126.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +26.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For X
//*********************************************************
NSArray* bezierPathArrayForAlphabetX() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y + 6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 63.0, DRAWALPHABET_OFFSET_Y +6.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 88, DRAWALPHABET_OFFSET_Y +32)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108, DRAWALPHABET_OFFSET_Y +6)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 165.0, DRAWALPHABET_OFFSET_Y +6.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 116, DRAWALPHABET_OFFSET_Y + 73)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 88, DRAWALPHABET_OFFSET_Y + 124)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 63, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +73)];
  
  
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For X
//********************************************************
UIBezierPath* XTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 53,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 88.0,DRAWALPHABET_OFFSET_Y +74.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 88.0,DRAWALPHABET_OFFSET_Y +74.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 48.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For Y
//*********************************************************
NSArray* bezierPathArrayForAlphabetY() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y + 6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 63.0, DRAWALPHABET_OFFSET_Y +6.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 88, DRAWALPHABET_OFFSET_Y +32)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108, DRAWALPHABET_OFFSET_Y +6)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 165.0, DRAWALPHABET_OFFSET_Y +6.0)];
 
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 63, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +73)];


  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For Y
//********************************************************
UIBezierPath* YTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 53,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 92.0,DRAWALPHABET_OFFSET_Y +68.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 48.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For Z
//*********************************************************
NSArray* bezierPathArrayForAlphabetZ() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +67)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +110.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +150.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +93)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +50.0)];
  
  
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For Z
//********************************************************
UIBezierPath* ZTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130,DRAWALPHABET_OFFSET_Y +57.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30,DRAWALPHABET_OFFSET_Y +103.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//********************************************************
#pragma mark NumberSet
//********************************************************



//*********************************************************
#pragma mark PathArrays For 1
//*********************************************************
NSArray* bezierPathArrayForAlphabet1() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0, DRAWALPHABET_OFFSET_Y + 20)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0, DRAWALPHABET_OFFSET_Y +110.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +150.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30, DRAWALPHABET_OFFSET_Y +60.0)];
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}



//********************************************************
#pragma mark TestPath For 1
//********************************************************
UIBezierPath* ONETestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50,DRAWALPHABET_OFFSET_Y +40.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 80,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 80,DRAWALPHABET_OFFSET_Y +130.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +130.0)];
//  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For 2
//*********************************************************
NSArray* bezierPathArrayForAlphabet2() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +30.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +20.0)];

  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +60)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +80.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +70.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +70.0)];

  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +105.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +110.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +110)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +83.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +55.0)];
   [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113, DRAWALPHABET_OFFSET_Y +50.0)];
   [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +50.0)];
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}



//********************************************************
#pragma mark TestPath For 2
//********************************************************
UIBezierPath* TWOTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +65.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +40.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +55.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30,DRAWALPHABET_OFFSET_Y +95.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}

//*********************************************************
#pragma mark PathArrays For 3
//*********************************************************

NSArray* bezierPathArrayForAlphabet3() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];
  
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 151.0, DRAWALPHABET_OFFSET_Y +75.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +132)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +146.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +96.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0, DRAWALPHABET_OFFSET_Y +56.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +56.0)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +46.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
    
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For 3
//********************************************************
UIBezierPath* THREETestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  //[aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 26.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 66.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102)];
   [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+26.0,DRAWALPHABET_OFFSET_Y +126.0)];
  
  //[aPath3 closePath];
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For 4
//*********************************************************

NSArray* bezierPathArrayForAlphabet4() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100.0,DRAWALPHABET_OFFSET_Y +10.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0,DRAWALPHABET_OFFSET_Y +10.0)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170.0, DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 170.0, DRAWALPHABET_OFFSET_Y +120.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +120.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +150.0)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0, DRAWALPHABET_OFFSET_Y +150.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0, DRAWALPHABET_OFFSET_Y +120.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10.0, DRAWALPHABET_OFFSET_Y +120.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 100.0, DRAWALPHABET_OFFSET_Y +10.0)];
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +150.0)];
  
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0,DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 90.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
    
  
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
  
}
//********************************************************
#pragma mark TestPath For 4
//********************************************************
UIBezierPath* FOURTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0,DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 153.0,DRAWALPHABET_OFFSET_Y +100.0)];
 
  aPath3.lineWidth = 2.0;
  return aPath3;
}





//*********************************************************
#pragma mark PathArrays For 5
//*********************************************************

NSArray* bezierPathArrayForAlphabet5() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10.0, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0, DRAWALPHABET_OFFSET_Y +150.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +60.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +130.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +90)];
  
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +100)];
//  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +60.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +90.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 155, DRAWALPHABET_OFFSET_Y +90.0)];
  
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +105.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +50.0)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105, DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105.0, DRAWALPHABET_OFFSET_Y +110.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 116.0, DRAWALPHABET_OFFSET_Y +105.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +105.0)];
  
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +110.0)];
  
  [aPath closePath];
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150.0, DRAWALPHABET_OFFSET_Y +150.0)];
  
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}
//********************************************************
#pragma mark TestPath For 5
//********************************************************
UIBezierPath* FIVEestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +80.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +80.0)];
   [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120, DRAWALPHABET_OFFSET_Y +130.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 135, DRAWALPHABET_OFFSET_Y +95.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 135, DRAWALPHABET_OFFSET_Y +115.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}





//*********************************************************
#pragma mark PathArrays For 6
//*********************************************************

NSArray* bezierPathArrayForAlphabet6() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash

  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20.0, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0, DRAWALPHABET_OFFSET_Y +150.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +60.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +130.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +90)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55, DRAWALPHABET_OFFSET_Y +60.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 55.0, DRAWALPHABET_OFFSET_Y +50.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +55.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 50.0, DRAWALPHABET_OFFSET_Y +55.0)];
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 150, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +10)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +150.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 0, DRAWALPHABET_OFFSET_Y +30.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 2, DRAWALPHABET_OFFSET_Y +135)];
  
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +106.0)];
  
  [aPath3 setLineDash:dashArray count:2 phase:0];
  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  
  FCBezierPath *bezierPath3 = [[FCBezierPath alloc] init];
  [bezierPath3 setBezierPath:aPath3];
  [bezierPath3 setCheckOuter:YES];
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath3, nil];
  
}
//********************************************************
#pragma mark TestPath For 6
//********************************************************
UIBezierPath* SIXTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
    
  
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 125.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 125, DRAWALPHABET_OFFSET_Y +130.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +95.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +115.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40, DRAWALPHABET_OFFSET_Y +30.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 25, DRAWALPHABET_OFFSET_Y +115.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 25, DRAWALPHABET_OFFSET_Y +45.0)];
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 130.0,DRAWALPHABET_OFFSET_Y +30.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For 7
//*********************************************************
NSArray* bezierPathArrayForAlphabet7() {
  
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6.0, DRAWALPHABET_OFFSET_Y + 6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 165.0, DRAWALPHABET_OFFSET_Y +6.0)];
  // Set the starting point of the shape.
  // Draw the lines.
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 88, DRAWALPHABET_OFFSET_Y +32)];
//  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108, DRAWALPHABET_OFFSET_Y +6)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 165.0, DRAWALPHABET_OFFSET_Y +6.0)];
  
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 63, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y + 150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 85, DRAWALPHABET_OFFSET_Y +46)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +46)];
  
  [aPath closePath];
  [aPath setLineJoinStyle:kCGLineCapRound];
  aPath.lineWidth = 2.0;
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  return [NSArray arrayWithObjects:bezierPath1, nil];
  
}


//********************************************************
#pragma mark TestPath For 7
//********************************************************
UIBezierPath* SEVENTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
//  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 53,DRAWALPHABET_OFFSET_Y +30.0)];
//  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 92.0,DRAWALPHABET_OFFSET_Y +68.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 48.0,DRAWALPHABET_OFFSET_Y +130.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +27.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +27.0)];
  
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}



//*********************************************************
#pragma mark PathArrays For 8
//*********************************************************

NSArray* bezierPathArrayForAlphabet8() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  //*******************************************************
  //*********************First Path************************
  
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45.0,DRAWALPHABET_OFFSET_Y +6.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +7.0)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 151.0, DRAWALPHABET_OFFSET_Y +75.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +20.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +146.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 168, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 162, DRAWALPHABET_OFFSET_Y +132)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45.0, DRAWALPHABET_OFFSET_Y +146.0)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 23.0, DRAWALPHABET_OFFSET_Y +75.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +132) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +102)];
  
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45, DRAWALPHABET_OFFSET_Y +6.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +50.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 6, DRAWALPHABET_OFFSET_Y +20)];
  
  [aPath closePath];
  // count is number of values in array
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 46.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +46.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +56.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +50)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 56.0,DRAWALPHABET_OFFSET_Y +56.0)];
  [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 56.0, DRAWALPHABET_OFFSET_Y +46.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +50)];
  [aPath2 setLineDash:dashArray count:2 phase:0];
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];
  //*******************************************************
  //*********************Second Path************************
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 56.0,DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0,DRAWALPHABET_OFFSET_Y +96.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 113.0, DRAWALPHABET_OFFSET_Y +106.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 123, DRAWALPHABET_OFFSET_Y +102)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 56.0,DRAWALPHABET_OFFSET_Y +106.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 56.0, DRAWALPHABET_OFFSET_Y +96.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 46, DRAWALPHABET_OFFSET_Y +102)];
  
  [aPath3 setLineDash:dashArray count:2 phase:0];
  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  
  FCBezierPath *bezierPath3 = [[FCBezierPath alloc] init];
  [bezierPath3 setBezierPath:aPath3];
  [bezierPath3 setCheckOuter:YES];
  
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath2,bezierPath3, nil];
  
}
//********************************************************
#pragma mark TestPath For 8
//********************************************************
UIBezierPath* EIGHTTestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45.0,DRAWALPHABET_OFFSET_Y +126.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45.0, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 31, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 31, DRAWALPHABET_OFFSET_Y +102)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45.0, DRAWALPHABET_OFFSET_Y +26.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 31, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 31, DRAWALPHABET_OFFSET_Y +50)];

  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +26.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +76.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +50)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 45.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0,DRAWALPHABET_OFFSET_Y +76.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 129.0, DRAWALPHABET_OFFSET_Y +126.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +102)];
  
  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  return aPath3;
}


//*********************************************************
#pragma mark PathArrays For 9
//*********************************************************

NSArray* bezierPathArrayForAlphabet9() {
  CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
  dashArray[0] = 9;//length of one dash
  dashArray[1] = 2;//gap b/w two dash
  
  
  //*******************************************************
  //*********************First Path************************
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140.0, DRAWALPHABET_OFFSET_Y + 10)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20.0, DRAWALPHABET_OFFSET_Y +10.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +100.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 0, DRAWALPHABET_OFFSET_Y +30.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 0, DRAWALPHABET_OFFSET_Y +70)];
  
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105, DRAWALPHABET_OFFSET_Y +100.0)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 105.0, DRAWALPHABET_OFFSET_Y +110.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0, DRAWALPHABET_OFFSET_Y +105.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 110.0, DRAWALPHABET_OFFSET_Y +105.0)];
  //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 50, DRAWALPHABET_OFFSET_Y +50.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +110.0)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 10, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +150)];
  [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 140, DRAWALPHABET_OFFSET_Y +10.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 160, DRAWALPHABET_OFFSET_Y +130.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 158, DRAWALPHABET_OFFSET_Y +25)];
  
  [aPath setLineDash:dashArray count:2 phase:0];
  aPath.lineWidth = 2.0;
  
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 114.0,DRAWALPHABET_OFFSET_Y +64.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0,DRAWALPHABET_OFFSET_Y +64.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 47.0, DRAWALPHABET_OFFSET_Y +54.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 37, DRAWALPHABET_OFFSET_Y +58) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 37, DRAWALPHABET_OFFSET_Y +58)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 114.0,DRAWALPHABET_OFFSET_Y +54.0)];
  
  [aPath3 setLineDash:dashArray count:2 phase:0];
  [aPath3 closePath];
  aPath3.lineWidth = 2.0;
  
  FCBezierPath *bezierPath3 = [[FCBezierPath alloc] init];
  [bezierPath3 setBezierPath:aPath3];
  [bezierPath3 setCheckOuter:YES];
  
  return [NSArray arrayWithObjects:bezierPath1,bezierPath3, nil];
  
}
//********************************************************
#pragma mark TestPath For 9
//********************************************************
UIBezierPath* NINETestBezierPath () {
  UIBezierPath *aPath3 = [UIBezierPath bezierPath];
  
  
  //[aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35.0,DRAWALPHABET_OFFSET_Y +80.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 35, DRAWALPHABET_OFFSET_Y +30.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +65.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 20, DRAWALPHABET_OFFSET_Y +45.0)];
  
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120.0,DRAWALPHABET_OFFSET_Y +30.0)];
  [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 120, DRAWALPHABET_OFFSET_Y +130.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 135, DRAWALPHABET_OFFSET_Y +45.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 135, DRAWALPHABET_OFFSET_Y +115.0)];
  [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 30.0,DRAWALPHABET_OFFSET_Y +130.0)];
  
  aPath3.lineWidth = 2.0;
  return aPath3;
}











//************** b with 25 width
/*
 NSArray* bezierPathArrayForAlphabetB() {
 CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
 dashArray[0] = 9;//length of one dash
 dashArray[1] = 2;//gap b/w two dash
 
 
 //*******************************************************
 //*********************First Path************************
 
 UIBezierPath *aPath = [UIBezierPath bezierPath];
 
 [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0,DRAWALPHABET_OFFSET_Y +20.0)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122.0,DRAWALPHABET_OFFSET_Y +20.0)];
 
 
 [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 124.0, DRAWALPHABET_OFFSET_Y +75.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 137, DRAWALPHABET_OFFSET_Y +31.0) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +54)];
 
 [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122.0, DRAWALPHABET_OFFSET_Y +130.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 143, DRAWALPHABET_OFFSET_Y +96) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 137, DRAWALPHABET_OFFSET_Y +119)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 15.0, DRAWALPHABET_OFFSET_Y +130.0)];
 [aPath closePath];
 // count is number of values in array
 [aPath setLineDash:dashArray count:2 phase:0];
 aPath.lineWidth = 2.0;
 
 FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
 [bezierPath1 setBezierPath:aPath];
 [bezierPath1 setCheckOuter:NO];
 //*******************************************************
 //*********************Second Path************************
 UIBezierPath *aPath2 = [UIBezierPath bezierPath];
 [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40.0,DRAWALPHABET_OFFSET_Y +45.0)];
 [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 107.0,DRAWALPHABET_OFFSET_Y +45.0)];
 [aPath2 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 101.0, DRAWALPHABET_OFFSET_Y +63.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 110, DRAWALPHABET_OFFSET_Y +55) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 110, DRAWALPHABET_OFFSET_Y +55)];
 [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40.0,DRAWALPHABET_OFFSET_Y +63.0)];
 [aPath2 setLineDash:dashArray count:2 phase:0];
 [aPath2 closePath];
 aPath2.lineWidth = 2.0;
 
 FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
 [bezierPath2 setBezierPath:aPath2];
 [bezierPath2 setCheckOuter:YES];
 //*******************************************************
 //*********************Second Path************************
 UIBezierPath *aPath3 = [UIBezierPath bezierPath];
 [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40.0,DRAWALPHABET_OFFSET_Y +88.0)];
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 101.0,DRAWALPHABET_OFFSET_Y +88.0)];
 [aPath3 addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 107.0, DRAWALPHABET_OFFSET_Y +105.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 110, DRAWALPHABET_OFFSET_Y +95) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 110, DRAWALPHABET_OFFSET_Y +95)];
 
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 40.0,DRAWALPHABET_OFFSET_Y +105.0)];
 
 [aPath3 setLineDash:dashArray count:2 phase:0];
 [aPath3 closePath];
 aPath3.lineWidth = 2.0;
 
 FCBezierPath *bezierPath3 = [[FCBezierPath alloc] init];
 [bezierPath3 setBezierPath:aPath3];
 [bezierPath3 setCheckOuter:YES];
 
 
 return [NSArray arrayWithObjects:bezierPath1,bezierPath2,bezierPath3, nil];
 
 }
*/

/*
 NSArray* bezierPathArrayForAlphabetB() {
 CGFloat dashArray[2];//pattern like which line should draw e.g 5-2-3-2 lenght of line then gap
 dashArray[0] = 9;//length of one dash
 dashArray[1] = 2;//gap b/w two dash
 
 
 //*******************************************************
 //*********************First Path************************
 
 UIBezierPath *aPath = [UIBezierPath bezierPath];
 
 [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 16.0, DRAWALPHABET_OFFSET_Y + 130.0)];
 
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 16.0, DRAWALPHABET_OFFSET_Y +20.0)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122, DRAWALPHABET_OFFSET_Y +20)];
 
 [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 143.0, DRAWALPHABET_OFFSET_Y +38.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 139, DRAWALPHABET_OFFSET_Y +25) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 139, DRAWALPHABET_OFFSET_Y +25)];
 
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 143.0, DRAWALPHABET_OFFSET_Y +59.0)];
 
 [aPath addCurveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122.0, DRAWALPHABET_OFFSET_Y +77.0) controlPoint1:CGPointMake(DRAWALPHABET_OFFSET_X+ 137, DRAWALPHABET_OFFSET_Y +71) controlPoint2:CGPointMake(DRAWALPHABET_OFFSET_X+ 137, DRAWALPHABET_OFFSET_Y +71)];
 
 
 //[aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 131.0, DRAWALPHABET_OFFSET_Y +77)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 143.0, DRAWALPHABET_OFFSET_Y +90.0)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 143.0, DRAWALPHABET_OFFSET_Y +108.0)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 139.0, DRAWALPHABET_OFFSET_Y +124)];
 [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 122.0, DRAWALPHABET_OFFSET_Y +130.0)];
 [aPath closePath];
 // count is number of values in array
 [aPath setLineDash:dashArray count:2 phase:0];
 aPath.lineWidth = 2.0;
 
 FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
 [bezierPath1 setBezierPath:aPath];
 [bezierPath1 setCheckOuter:NO];
 //*******************************************************
 //*********************Second Path************************
 UIBezierPath *aPath2 = [UIBezierPath bezierPath];
 [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 41.0,DRAWALPHABET_OFFSET_Y +40.0)];
 [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 102.0,DRAWALPHABET_OFFSET_Y +40.0)];
 [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 112.0,DRAWALPHABET_OFFSET_Y +48.0)];
 [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 102.0,DRAWALPHABET_OFFSET_Y +57.0)];
 [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 41.0,DRAWALPHABET_OFFSET_Y +57.0)];
 [aPath2 setLineDash:dashArray count:2 phase:0];
 [aPath2 closePath];
 aPath2.lineWidth = 2.0;
 
 FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
 [bezierPath2 setBezierPath:aPath2];
 [bezierPath2 setCheckOuter:YES];
 //*******************************************************
 //*********************Second Path************************
 UIBezierPath *aPath3 = [UIBezierPath bezierPath];
 [aPath3 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 41.0,DRAWALPHABET_OFFSET_Y +93.0)];
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 102.0,DRAWALPHABET_OFFSET_Y +93.0)];
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 112.0,DRAWALPHABET_OFFSET_Y +101.0)];
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 102.0,DRAWALPHABET_OFFSET_Y +110.0)];
 [aPath3 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 41.0,DRAWALPHABET_OFFSET_Y +110.0)];
 
 [aPath3 setLineDash:dashArray count:2 phase:0];
 [aPath3 closePath];
 aPath3.lineWidth = 2.0;
 
 FCBezierPath *bezierPath3 = [[FCBezierPath alloc] init];
 [bezierPath3 setBezierPath:aPath3];
 [bezierPath3 setCheckOuter:YES];
 
 
 return [NSArray arrayWithObjects:bezierPath1,bezierPath2,bezierPath3, nil];
 
 }

 */


