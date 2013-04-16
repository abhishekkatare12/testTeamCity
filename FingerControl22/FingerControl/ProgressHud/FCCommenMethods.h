//
//  FCCommenMethods.h
//  FingerControl
//
//  Created by Abhishek sharma on 27/11/12.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


#define FCCOMMEN [FCCommenMethods sharedInstance]


// firstColorPack
#define REDCOLOR [UIColor colorWithRed:245.0f/255 green:7.0f/255 blue:25.0f/255 alpha:1]
#define VOILETCOLOR [UIColor colorWithRed:60.0f/255 green:0.0f/255 blue:250.0f/255 alpha:1]
#define GREENCOLOR [UIColor colorWithRed:60.0f/255 green:254.0f/255 blue:2.0f/255 alpha:1]

// secondColorPack
#define PINKCOLOR [UIColor colorWithRed:225.0f/255 green:0.0f/255 blue:251.0f/255 alpha:1]
#define YELLOWCOLOR [UIColor colorWithRed:245.0f/255 green:254.0f/255 blue:20.0f/255 alpha:1]
#define CREAMBLUECOLOR [UIColor colorWithRed:65.0f/255 green:251.0f/255 blue:242.0f/255 alpha:1]


@interface FCCommenMethods : NSObject {

  AVAudioPlayer *player;
  BOOL playBackgroundSound;
  
  BOOL isEasyMode;
  NSInteger numberOfCoins;
  BOOL freezeActivated;
  
  BOOL firstCharacterSetPurchased;
  BOOL secondCharacterSetPurchased;
  BOOL thirdCharacterSetPurchased;
  
  BOOL firstColorSetPurchased;
  BOOL secondColorSetPurchased;
  
  BOOL userSelectedCustomDrawingColor;
  
  UIColor *leftDrawColor;
  UIColor *rightDrawColor;
  
  UIImage *leftDrawColorImage;
  UIImage *rightDrawColorImage;
  
  NSInteger colorIndexLeft;
  NSInteger colorIndexRight;
  BOOL shouldShowAd;
  
 
}
@property (nonatomic,assign) BOOL shouldShowAd;

@property (nonatomic,assign) NSInteger colorIndexLeft;
@property (nonatomic,assign) NSInteger colorIndexRight;


@property (nonatomic,retain) UIColor *leftDrawColor;
@property (nonatomic,retain) UIColor *rightDrawColor;
@property (nonatomic,copy)  UIImage *leftDrawColorImage;
@property (nonatomic,copy) UIImage *rightDrawColorImage;

@property (nonatomic,assign) BOOL playBackgroundSound;
@property (nonatomic,assign) BOOL freezeActivated;

@property (nonatomic,assign) BOOL firstCharacterSetPurchased;
@property (nonatomic,assign) BOOL secondCharacterSetPurchased;
@property (nonatomic,assign) BOOL thirdCharacterSetPurchased;
@property (nonatomic,assign) BOOL firstColorSetPurchased;
@property (nonatomic,assign) BOOL secondColorSetPurchased;

@property (nonatomic,assign) BOOL userSelectedCustomDrawingColor;

@property (nonatomic,assign) BOOL isEasyMode;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic,assign) NSInteger numberOfCoins;
+(FCCommenMethods* ) sharedInstance;

- (void) playSound;
- (void) stopSound;
- (void) pauseSound;
@end




NSArray* getColorsArray ();
NSArray* getcolorImages();
int numberOfAlphabet();


BOOL isNotFirstTime();

#define LINEWIDTH 23.0f//23
#define COMPAREDELTA 11
#define EASYCOMPAREDELTA 1

#define NUMBEROFALPHABET 18

NSDictionary* alphabetDataForIndex(int x) ;
NSMutableDictionary* alphabetDataForFirstSetAtIndex (int x);
NSMutableDictionary* alphabetDataForSecondSetAtIndex (int x);
NSMutableDictionary* alphabetDataForThirdSetAtIndex (int x);


NSArray* bezierPathArrayForAlphabetA();
NSArray* bezierPathArrayForAlphabetB();
NSArray* bezierPathArrayForAlphabetC();
NSArray* bezierPathArrayForAlphabetD();
NSArray* bezierPathArrayForAlphabetE();
NSArray* bezierPathArrayForAlphabetF();
NSArray* bezierPathArrayForAlphabetG();
NSArray* bezierPathArrayForAlphabetH();
NSArray* bezierPathArrayForAlphabetI();
NSArray* bezierPathArrayForAlphabetJ();

NSArray* bezierPathArrayForAlphabetK();
NSArray* bezierPathArrayForAlphabetL();
NSArray* bezierPathArrayForAlphabetM();
NSArray* bezierPathArrayForAlphabetN();
NSArray* bezierPathArrayForAlphabetO();

NSArray* bezierPathArrayForAlphabetP();
NSArray* bezierPathArrayForAlphabetQ();

NSArray* bezierPathArrayForAlphabetR();
NSArray* bezierPathArrayForAlphabetS();
NSArray* bezierPathArrayForAlphabetV();
NSArray* bezierPathArrayForAlphabetT();
NSArray* bezierPathArrayForAlphabetU();
NSArray* bezierPathArrayForAlphabetW();
NSArray* bezierPathArrayForAlphabetX();

NSArray* bezierPathArrayForAlphabetY();
NSArray* bezierPathArrayForAlphabetZ();

// Numbers

NSArray* bezierPathArrayForAlphabet1();
NSArray* bezierPathArrayForAlphabet2();
NSArray* bezierPathArrayForAlphabet3();
NSArray* bezierPathArrayForAlphabet4();
NSArray* bezierPathArrayForAlphabet5();
NSArray* bezierPathArrayForAlphabet6();
NSArray* bezierPathArrayForAlphabet7();
NSArray* bezierPathArrayForAlphabet8();
NSArray* bezierPathArrayForAlphabet9();


UIBezierPath* ATestBezierPath () ;
UIBezierPath* BTestBezierPath () ;
UIBezierPath* CTestBezierPath ();
UIBezierPath* DTestBezierPath ();

UIBezierPath* ETestBezierPath ();
UIBezierPath* FTestBezierPath ();

UIBezierPath* GTestBezierPath ();
UIBezierPath* HTestBezierPath ();
UIBezierPath* ITestBezierPath ();
UIBezierPath* JTestBezierPath ();
UIBezierPath* KTestBezierPath ();
UIBezierPath* LTestBezierPath ();
UIBezierPath* MTestBezierPath ();
UIBezierPath* NTestBezierPath ();
UIBezierPath* OTestBezierPath();
UIBezierPath* PTestBezierPath ();
UIBezierPath* QTestBezierPath ();
UIBezierPath* RTestBezierPath ();

UIBezierPath* STestBezierPath ();
UIBezierPath* TTestBezierPath ();
UIBezierPath* UTestBezierPath ();
UIBezierPath* VTestBezierPath ();
UIBezierPath* WTestBezierPath ();
UIBezierPath* XTestBezierPath ();
UIBezierPath* YTestBezierPath ();
UIBezierPath* ZTestBezierPath ();


//NumberTestPaths

UIBezierPath* ONETestBezierPath ();
UIBezierPath* TWOTestBezierPath ();
UIBezierPath* THREETestBezierPath ();
UIBezierPath* FOURTestBezierPath ();
UIBezierPath* FIVEestBezierPath ();
UIBezierPath* SIXTestBezierPath ();

UIBezierPath* SEVENTestBezierPath ();
UIBezierPath* EIGHTTestBezierPath ();
UIBezierPath* NINETestBezierPath ();


