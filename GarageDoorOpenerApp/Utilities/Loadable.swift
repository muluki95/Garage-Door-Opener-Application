//
//  Loadable.swift
//  GarageDoorOpenerApp
//
//  Created by Esther Nzomo on 5/9/25.
//

enum Loadable <Value> {
    case loading
    case error(Error)
    case loaded (Value)
}
//this extension adds functionality to Loadable when the data type `Value`
// is a RangeReplaceableCollection (like Array, String)

extension Loadable where Value: RangeReplaceableCollection{
    static var empty:Loadable<Value> {
        .loaded(Value()) // Creates an empty instance of the collection and wraps it in .loaded
    
    }
    
}
extension Loadable {
    var value: Value? {
        // Getter: If the current case is `.loaded`, extract and return the value
        
        get{
            if case let .loaded(value) = self {
                return value
            }
            return nil
        }
        // Setter: Allows updating the value if a new one is provided
        
        set {
            guard let newValue = newValue else {return}
            self = .loaded(newValue)  // Update the enum case to `.loaded` with the new value
            
        }
    }
}
