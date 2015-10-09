//
//  ThreadSafeMutableArray.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "ThreadSafeMutableArray.h"

@implementation ThreadSafeMutableArray
{
    dispatch_queue_t isolationQueue_;
    NSMutableArray *storage_;
}



/**
 Private common init steps
 */
- (instancetype)initCommon
{
    self = [super init];
    if (self) {
        isolationQueue_ = dispatch_queue_create([@"ThreadSafeMutableArray Isolation Queue" UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)init
{
    self = [self initCommon];
    if (self) {
        storage_ = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [self initCommon];
    if (self) {
        storage_ = [NSMutableArray arrayWithCapacity:numItems];
    }
    return self;
}

- (NSArray *)initWithContentsOfFile:(NSString *)path
{
    self = [self initCommon];
    if (self) {
        storage_ = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self initCommon];
    if (self) {
        storage_ = [[NSMutableArray alloc] initWithCoder:aDecoder];
    }
    return self;
}

- (instancetype)initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    self = [self initCommon];
    if (self)
    {
        //        if (!objects || !keys) {
        //            [NSException raise:NSInvalidArgumentException format:@"objects and keys cannot be nil"];
        //        } else
        //        {
        
        for (NSUInteger i = 0; i < cnt; ++i) {
            //storage_[keys[i]] = objects[i];
            [storage_ addObject:objects[i]];
        }
    }
    
    //    }
    return self;
}

- (NSUInteger)count
{
    __block NSUInteger count;
    dispatch_sync(isolationQueue_, ^{
        count = storage_.count;
    });
    return count;
}
-(id)objectAtIndex:(NSUInteger)index
//- (id)objectForKey:(id)aKey
{
    __block id obj;
    dispatch_sync(isolationQueue_, ^{
        obj = storage_[index];
    });
    return obj;
}

- (NSEnumerator *)keyEnumerator
{
    __block NSEnumerator *enu;
    dispatch_sync(isolationQueue_, ^{
        enu = [storage_ objectEnumerator];
    });
    return enu;
}

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index
//- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    //aKey = [aKey copyWithZone:NULL];
    dispatch_barrier_async(isolationQueue_, ^{
        [storage_ insertObject:anObject atIndex:index];
    });
}

-(void)addObject:(id)anObject;
//- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    //aKey = [aKey copyWithZone:NULL];
    dispatch_barrier_async(isolationQueue_, ^{
        [storage_ addObject:anObject];
    });
}
-(void) removeObjectAtIndex:(NSUInteger)index
//- (void)removeObjectForKey:(id)aKey
{
    dispatch_barrier_async(isolationQueue_, ^{
        [storage_ removeObjectAtIndex:index];
    });
}

-(void) removeLastObject
//- (void)removeObjectForKey:(id)aKey
{
    dispatch_barrier_async(isolationQueue_, ^{
        [storage_ removeLastObject];
    });
}

-(void) replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
//- (void)removeObjectForKey:(id)aKey
{
    dispatch_barrier_async(isolationQueue_, ^{
        [storage_ replaceObjectAtIndex:index withObject:anObject];
    });
}

@end
