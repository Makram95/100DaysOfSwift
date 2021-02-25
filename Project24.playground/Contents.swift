import UIKit

var string = "This is a test string"

let attributes: [NSAttributedString.Key: Any] = [
    
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)


