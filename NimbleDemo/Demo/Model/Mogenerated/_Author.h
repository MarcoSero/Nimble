// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Author.h instead.

#import <CoreData/CoreData.h>


extern const struct AuthorAttributes {
} AuthorAttributes;

extern const struct AuthorRelationships {
	__unsafe_unretained NSString *books;
} AuthorRelationships;

extern const struct AuthorFetchedProperties {
} AuthorFetchedProperties;

@class Book;


@interface AuthorID : NSManagedObjectID {}
@end

@interface _Author : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AuthorID*)objectID;





@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;





@end

@interface _Author (CoreDataGeneratedAccessors)

- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(Book*)value_;
- (void)removeBooksObject:(Book*)value_;

@end

@interface _Author (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;


@end
