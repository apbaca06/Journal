//
//  ArticleModel.swift
//  Journal
//
//  Created by cindy on 2017/12/8.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import CoreData





//public protocol PersistenceInitializable {
//    
//    init(_ managedObject: NSManagedObject) throws
//    
//}
//// MARK: - Persistentable
//
//public protocol Persistentable: PersistenceInitializable, PersistenceRepresentable { }
//
//
//// MARK: - PersistentRepresentable
//public protocol PersistenceRepresentable {
//    
//    func makeManagedObject(in context: NSManagedObjectContext) throws -> NSManagedObject
//    
//}
//// MARK: - Save
//
//import CoreData
//
//public extension Persistentable {
//    
//    public func save(in context: NSManagedObjectContext) throws {
//        
//        let object = try makeManagedObject(in: context)
//        
//        context.insert(object)
//        
//        try context.save()
//        
//    }
//    
//}
//public protocol Model: Persistentable { }
//
//
//// MARK: - LikeProduct
//
////public struct LikeProduct {
////
////    // MARK: Schema
////
////    public struct Schema {
////
////        public static let productId = "productId"
////
////    }
////
////    // MARK: Property
////
////    public let productId: ProductID
////
////    // MARK: Init
////
////    // Todo: validate if product exists.
////    public init(productId: ProductID) {
////
////        self.productId = productId
////
////    }
////
////}
//
//// MARK: - Model
//
//import CoreData
//
//extension LikeProduct: Model {
//    
//    public init(_ managedObject: NSManagedObject) throws {
//        
//        guard
//            let likeProductObject = managedObject as? LikeProductEntity
//            else {
//                
//                throw ModelError.invalidEntityType(
//                    type(of: managedObject).self,
//                    expectedType: LikeProductEntity.self
//                )
//                
//        }
//        
//        guard
//            let productIdValue = likeProductObject.productId
//            else { throw ModelError.missingValueForKey(Schema.productId) }
//        
//        self.productId = ProductID(productIdValue)
//        
//    }
//    
//    public func makeManagedObject(in context: NSManagedObjectContext) throws -> NSManagedObject {
//        
//        let likeProduct = LikeProductEntity(context: context)
//        
//        likeProduct.productId = productId.rawValue
//        
//        return likeProduct
//        
//    }
//    
//}

