//
//  YummyVM.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-10-28.
//

import SwiftUI
import Foundation
import KeychainSwift


struct YummyVM: View {
    
    let keychain = KeychainSwift()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


class JournalVM: ObservableObject {
    
//    let api = Api()
//    
//    let keychain = KeychainSwift()
//    
//    @Published var journals: [JournalEntry] = []
//    @Published var token: String?

    
//    init() {
//        self.token = keychain.get("token")
//    }
    
//    func loginApi(requestData: LoginRequest) async throws -> AuthResponse {
//        
//        do {
//            let response: AuthResponse = try await api.post(endpoint: "\(api.endpoint)/login", requestData: requestData, token: nil)
//            
//            DispatchQueue.main.async {
//                self.token = response.token
//            }
//            
//            
//            keychain.set(response.token, forKey: "token")
//            
//            return response
//        } catch {
//            throw error
//        }
//        
//    }
    
//    func registerApi(requestData: RegisterRequest) async throws -> AuthResponse {
//        
//        do {
//            let response: AuthResponse = try await api.post(endpoint: "\(api.endpoint)/register", requestData: requestData, token: nil)
//            
//            self.token = response.token
//            keychain.set(response.token, forKey: "token")
//            
//            
//            return response
//        } catch {
//            throw error
//        }
//        
//    }
    
//    func getEntries() async throws {
//        
//        if let token = token {
//            
//            do {
//                let response: [JournalEntry] = try await api.get(endpoint: "\(api.endpoint)/journals", token: token)
//                
//                DispatchQueue.main.async {
//                    self.journals = response
//
//                }
//                
//            } catch {
//                throw error
//            }
//            
//        } else {
//            throw APIErrors.invalidRequestData
//        }
//    }
    
//    func saveEntry(entry: JournalEntry) async throws {
//        
//        if let token = token {
//            
//            do {
//                let response: JournalEntry = try await api.post(endpoint: "\(api.endpoint)/journal", requestData: entry, token: token)
//                
//                
//                DispatchQueue.main.async {
//                    self.journals.append(response)
//                }
//
//            } catch {
//                throw error
//            }
//            
//        } else {
//            throw APIErrors.invalidRequestData
//        }
//        
//    }
    
}

#Preview {
    YummyVM()
}
