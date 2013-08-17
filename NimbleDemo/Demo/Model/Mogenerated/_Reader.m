// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Reader.m instead.

#import "_Reader.h"

const struct ReaderAttributes ReaderAttributes = {
};

const struct ReaderRelationships ReaderRelationships = {
  .books = @"books",
};

const struct ReaderFetchedProperties ReaderFetchedProperties = {
};

@implementation ReaderID
@end

@implementation _Reader

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_
{
  NSParameterAssert(moc_);
  return [NSEntityDescription insertNewObjectForEntityForName:@"Reader" inManagedObjectContext:moc_];
}

+ (NSString *)entityName
{
  return @"Reader";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_
{
  NSParameterAssert(moc_);
  return [NSEntityDescription entityForName:@"Reader" inManagedObjectContext:moc_];
}

- (ReaderID *)objectID
{
  return (ReaderID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
  NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];


  return keyPaths;
}


@dynamic books;


- (NSMutableSet *)booksSet
{
  [self willAccessValueForKey:@"books"];

  NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"books"];

  [self didAccessValueForKey:@"books"];
  return result;
}


@end
