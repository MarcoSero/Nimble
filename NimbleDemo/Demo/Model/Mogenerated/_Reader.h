// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Reader.h instead.

#import <CoreData/CoreData.h>


extern const struct ReaderAttributes {
} ReaderAttributes;

extern const struct ReaderRelationships {
  __unsafe_unretained NSString *books;
} ReaderRelationships;

extern const struct ReaderFetchedProperties {
} ReaderFetchedProperties;

@class Book;


@interface ReaderID : NSManagedObjectID {
}
@end

@interface _Reader : NSManagedObject {
}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;

+ (NSString *)entityName;

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_;

- (ReaderID *)objectID;


@property(nonatomic, strong) NSSet *books;

- (NSMutableSet *)booksSet;


@end

@interface _Reader (CoreDataGeneratedAccessors)

- (void)addBooks:(NSSet *)value_;

- (void)removeBooks:(NSSet *)value_;

- (void)addBooksObject:(Book *)value_;

- (void)removeBooksObject:(Book *)value_;

@end

@interface _Reader (CoreDataGeneratedPrimitiveAccessors)


- (NSMutableSet *)primitiveBooks;

- (void)setPrimitiveBooks:(NSMutableSet *)value;


@end
