class LdapSetting < ApplicationRecord
    def self.default
        ldap_default = LdapSetting.find_by(default: true)
        if ldap_default.nil?
            raise "Default LDAP configuration not set."
        else
            return ldap_default
        end
    end
end
