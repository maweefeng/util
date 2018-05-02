//
//  MTLModel+IGDiffable.m
//  HealthChengDuTKT
//
//  Created by walker on 10/01/2017.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "MTLModel+IGDiffable.h"

@implementation MTLModel (IGDiffable)

/**
 Returns a key that uniquely identifies the object.
 
 @return A key that can be used to uniquely identify the object.
 
 @note Two objects may share the same identifier, but are not equal. A common pattern is to use the `NSObject`
 category for automatic conformance. However this means that objects will be identified on their
 pointer value so finding updates becomes impossible.
 
 @warning This value should never be mutated.
 */
- (nonnull id<NSObject>)diffIdentifier{
    return self;
}

/**
 Returns whether the receiver and a given object are equal.
 
 @param object The object to be compared to the receiver.
 
 @return `YES` if the receiver and object are equal, otherwise `NO`.
 */
- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    return [self isEqual:object];
}

@end
