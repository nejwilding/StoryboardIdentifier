
import UIKit

/*:
# Storyboard Identifier Protocol
Storyboard identifier protocol for typesafe storyboard identities
*/

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

/*:
Storyboard Extension, we create an instantiate function to use with a view controller
*/

extension UIStoryboard {
    
    enum Storyboard: String {
        case Main
    }
    
    convenience init(storyboard: Storyboard, bundle: NSBundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>(_: T.Type) -> T {
        
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T else {
            fatalError("Could not instantiate viewcontroller with Storyboard Identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
        
    }
    
}

/*:
Example usage of Storyboard Identifier Protocol and instantiate extension
*/

class TestViewController: UIViewController { }

let identifier = TestViewController.storyboardIdentifier

class OpenViewContoller: UIViewController {
    
    func open() {
        
        let storyboard = UIStoryboard(storyboard: .Main)
        let viewController = storyboard.instantiateViewController(TestViewController.self)
        self.presentViewController(viewController, animated: true, completion: nil)
    }

}







