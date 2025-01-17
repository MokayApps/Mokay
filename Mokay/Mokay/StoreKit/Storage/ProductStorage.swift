//
//  ProductStorage.swift
//  Mokay
//
//  Created by Дмитрий Бондаренко on 07.12.24.
//

import Combine
import Foundation
import StoreKit

public actor ProductStorage {
    
    // MARK: - Private properties
    
    private let productStatusKey = "com.Mokay.Products"
    
    private let userDefaults: UserDefaults
    private let productIds: [String]
    
    private let productsSubject: CurrentValueSubject<[Product], Never> = .init([])
    
    // MARK: - Init
    
    public init(
        appGroupId: String,
        productIds: [String]
    ) {
        guard let userDefaults = UserDefaults(suiteName: appGroupId) else {
            fatalError("Failed to init UserDefaults with app group id: \(appGroupId)")
        }
        
        self.userDefaults = userDefaults
        self.productIds = productIds
    }
    
    // MARK: - Internal methods
    
    func getProductIds() -> [String] {
        return productIds
    }
    
    func getProduct(with productId: String) -> StoredProductModel? {
        let products = loadProducts()
        return products.first { $0.id == productId }
    }
    
    func saveProduct(_ product: StoredProductModel) {
        var storedProducts = loadProducts()
        
        if let productCopyIndex = storedProducts.firstIndex(where: { $0.id == product.id }) {
            storedProducts[productCopyIndex] = product
        } else {
            storedProducts.append(product)
        }
        
        userDefaults.set(storedProducts, forKey: productStatusKey)
    }
    
    func setProductList(_ products: [Product]) {
        productsSubject.send(products)
    }
    
    func productStream() -> ProductStream {
        ProductStream { continuation in
            Task {
                for await products in productsSubject.values {
                    continuation.yield(products)
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func loadProducts() -> [StoredProductModel] {
        return userDefaults.array(forKey: productStatusKey) as? [StoredProductModel] ?? []
    }
    
}
