/*
* JBoss, Home of Professional Open Source.
* Copyright Red Hat, Inc., and individual contributors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import Foundation

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

public class UntrustedMemoryOAuth2Session: OAuth2Session {
    
    /**
    * The account id.
    */
    public var accountId: String
    
    /**
    * The access token which expires.
    */
    public var accessToken: String?
    
    /**
    * The access token's expiration date.
    */
    public var accessTokenExpirationDate: NSDate?
    
    /**
    * The refresh tokens. This toke does not expire and should be used to renew access token when expired.
    */
    public var refreshToken: String?
    
    /**
    * Check validity of accessToken. return true if still valid, false when expired.
    */
    public func tokenIsNotExpired() -> Bool {
        return self.accessTokenExpirationDate?.timeIntervalSinceDate(NSDate()) > 0
    }
    
    /**
    * Save in memory tokens information. Saving tokens allow you to refresh accesstoken transparently for the user without prompting
    * for grant access.
    */
    public func saveAccessToken(accessToken: String?, refreshToken: String?, expiration: String?) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        let now = NSDate()
        if let inter = expiration?.doubleValue {
            self.accessTokenExpirationDate = now.dateByAddingTimeInterval(inter)
        }
    }
    public func saveAccessToken() {
        self.accessToken = nil
        self.refreshToken = nil
        self.accessTokenExpirationDate = nil
    }
    
    public init(accountId: String, accessToken: String? = nil, accessTokenExpirationDate: NSDate? = nil, refreshToken: String? = nil) {
        self.accessToken = accessToken
        self.accessTokenExpirationDate = accessTokenExpirationDate
        self.refreshToken = refreshToken
        self.accountId = accountId
    }
}
