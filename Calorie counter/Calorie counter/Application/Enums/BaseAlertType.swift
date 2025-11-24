import Foundation

enum BaseAlertType: Error, Equatable {
    case raw(title: String, subTitle: String)
    case delete(title: String, subTitle: String)
    
    var title: String {
        switch self {
        case let .raw(title, _): return title
        case let .delete(title, _): return title
        }
    }
    
    var subTitle: String {
        switch self {
        case let .raw(_, subTitle): return subTitle
        case let .delete(_, subTitle): return subTitle
        }
    }
}
