#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSValue (CGPoint)
#if TARGET_OS_MAC
+ (NSValue *)valueWithCGPoint:(CGPoint)point;
@property(nonatomic,readonly) CGPoint CGPointValue;
#endif
@end

