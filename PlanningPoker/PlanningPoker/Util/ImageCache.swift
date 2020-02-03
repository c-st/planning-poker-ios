//
//  ImageCache.swift
//  PlanningPoker
//
//  Created by Christian Stangier on 03.02.20.
//  Copyright © 2020 Christian Stangier. All rights reserved.
//

import Foundation
import SDWebImage

class ImageCache: NSObject, SDMemoryCacheProtocol, SDDiskCacheProtocol {
    required init?(cachePath: String, config: SDImageCacheConfig) {}
    
    func containsData(forKey key: String) -> Bool {
        return false
    }
    
    func data(forKey key: String) -> Data? {
        return nil
    }
    
    func setData(_ data: Data?, forKey key: String) {}
    
    func extendedData(forKey key: String) -> Data? {
        return nil
    }
    
    func setExtendedData(_ extendedData: Data?, forKey key: String) {}
    
    func removeData(forKey key: String) {}
    
    func removeAllData() {}
    
    func removeExpiredData() {}
    
    func cachePath(forKey key: String) -> String? {
        return nil
    }
    
    func totalCount() -> UInt {
        return 0
    }
    
    func totalSize() -> UInt {
        return 0
    }
    
    required init(config: SDImageCacheConfig) {}
    
    func object(forKey key: Any) -> Any? {
        return nil
    }
    
    func setObject(_ object: Any?, forKey key: Any) {}
    
    func setObject(_ object: Any?, forKey key: Any, cost: UInt) {}
    
    func removeObject(forKey key: Any) {}
    
    func removeAllObjects() {}
}
