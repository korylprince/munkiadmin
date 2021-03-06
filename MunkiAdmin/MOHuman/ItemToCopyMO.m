#import "ItemToCopyMO.h"

@implementation ItemToCopyMO

- (NSImage *)image
{
    BOOL hasDestinationItem = (self.munki_destination_item != nil) ? TRUE : FALSE;
    NSString *destinationItem = (hasDestinationItem) ? self.munki_destination_item : self.munki_source_item;
    NSString *fullPath = [self.munki_destination_path stringByAppendingPathComponent:destinationItem];
    NSWorkspace *wp = [NSWorkspace sharedWorkspace];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        return [wp iconForFile:fullPath];
    } else {
        return [wp iconForFileType:[fullPath pathExtension]];
    }
}

- (NSString *)titleDescription
{
    BOOL hasSourceItem;
    hasSourceItem = (self.munki_source_item != nil) ? TRUE : FALSE;
    NSString *sourceItem = (hasSourceItem) ? self.munki_source_item : @"--";
    return sourceItem;
}

- (NSString *)contentsDescription
{
    NSString *descriptionString;
    
    BOOL hasSourceItem, hasDestinationPath, hasDestinationItem, hasUser, hasGroup, hasMode;
    hasSourceItem = (self.munki_source_item != nil) ? TRUE : FALSE;
    NSString *sourceItem = (hasSourceItem) ? self.munki_source_item : @"--";
    
    hasDestinationPath = (self.munki_destination_path != nil) ? TRUE : FALSE;
    NSString *destinationPath = (hasDestinationPath) ? self.munki_destination_path : @"--";
    
    hasDestinationItem = (self.munki_destination_item != nil) ? TRUE : FALSE;
    NSString *destinationItem = (hasDestinationItem) ? self.munki_destination_item : sourceItem;
    
    hasUser = (self.munki_user != nil) ? TRUE : FALSE;
    NSString *user = (hasUser) ? self.munki_user : @"--";
    
    hasGroup = (self.munki_group != nil) ? TRUE : FALSE;
    NSString *group = (hasGroup) ? self.munki_group : @"--";
    
    hasMode = (self.munki_mode != nil) ? TRUE : FALSE;
    NSString *mode = (hasMode) ? self.munki_mode : @"--";
    
    descriptionString = [NSString stringWithFormat:@"%@/%@, %@:%@, %@", destinationPath, destinationItem, user, group, mode];
    return descriptionString;
}

- (NSDictionary *)dictValue
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			self.titleDescription, @"title",
			self.contentsDescription, @"subtitle",
			@"itemtocopy", @"type",
			nil];
}

- (NSDictionary *)dictValueForSave
{
	NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithCapacity:6];
	
	if (self.munki_destination_path != nil) [tmpDict setObject:self.munki_destination_path forKey:@"destination_path"];
    if (self.munki_destination_item != nil) [tmpDict setObject:self.munki_destination_item forKey:@"destination_item"];
	if (self.munki_group != nil) [tmpDict setObject:self.munki_group forKey:@"group"];
	if (self.munki_mode != nil) [tmpDict setObject:self.munki_mode forKey:@"mode"];
	if (self.munki_source_item != nil) [tmpDict setObject:self.munki_source_item forKey:@"source_item"];
	if (self.munki_user != nil) [tmpDict setObject:self.munki_user forKey:@"user"];
	
	NSDictionary *returnDict = [NSDictionary dictionaryWithDictionary:tmpDict];
	return returnDict;
}


@end
