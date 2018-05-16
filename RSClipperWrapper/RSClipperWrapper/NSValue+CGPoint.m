#import "NSValue+CGPoint.h"
@implementation NSValue (CGPoint)
#if TARGET_OS_MAC
+ (NSValue *)valueWithCGPoint:(CGPoint)point {
    return [NSValue valueWithPoint:point];
}

- (CGPoint)CGPointValue {
    return [self pointValue];
}
#endif
@end
