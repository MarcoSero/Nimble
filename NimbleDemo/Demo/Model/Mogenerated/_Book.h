// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Book.h instead.

#import <CoreData/CoreData.h>


extern const struct BookAttributes {
} BookAttributes;

extern const struct BookRelationships {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *readers;
} BookRelationships;

extern const struct BookFetchedProperties {
} BookFetchedProperties;

@class Author;
@class Reader;


@interface BookID : NSManagedObjectID {}
@end

@interface _Book : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BookID*)objectID;





@property (nonatomic, strong) Author *author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *readers;

- (NSMutableSet*)readersSet;





@end

@interface _Book (CoreDataGeneratedAccessors)

- (void)addReaders:(NSSet*)value_;
- (void)removeReaders:(NSSet*)value_;
- (void)addReadersObject:(Reader*)value_;
- (void)removeReadersObject:(Reader*)value_;

@end

@interface _Book (CoreDataGeneratedPrimitiveAccessors)



- (Author*)primitiveAuthor;
- (void)setPrimitiveAuthor:(Author*)value;



- (NSMutableSet*)primitiveReaders;
- (void)setPrimitiveReaders:(NSMutableSet*)value;


@end
