/** Domain class that maps to the bill_type table.
 * <p>Note: the bill_type table was created defined for this application.</p> 
 */

class BillType {
    String specialNote
    String name
    String thumbnailFilename
    String imageFilename   
    int minActDigits
    int maxActDigits
    static constraints = {
        thumbnailFilename nullable:true
        imageFilename nullable:true
        specialNote maxSize:512
    }
    String toString() {"$name digits: $minActDigits-$maxActDigits"}
}
