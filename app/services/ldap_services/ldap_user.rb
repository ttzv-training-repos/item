module LdapServices
  class LdapUser
    @@attr = [
      :dn,
      :objectclass,
      :cn,
      :sn,
      :givenname,
      :description,
      :distinguishedname,
      :instancetype,
      :whencreated,
      :whenchanged,
      :displayname,
      :usncreated,
      #:memberof, #not needed for now
      :usnchanged,
      :name,
      :objectguid,
      :useraccountcontrol,
      :badpwdcount,
      :codepage,
      :countrycode,
      :badpasswordtime,
      :lastlogoff,
      :lastlogon,
      #:logonhours, #causes encoding issues
      :pwdlastset,
      :primarygroupid,
      :objectsid,
      :admincount,
      :accountexpires,
      :logoncount,
      :samaccountname,
      :samaccounttype,
      :lockouttime,
      :objectcategory,
      :iscriticalsystemobject,
      #:dscorepropagationdata, #is an array
      :lastlogontimestamp,
      :"msds-supportedencryptiontypes",
      :mail,
      :userprincipalname]

      @utc_date_attr = [
        :badpasswordtime, 
        :lastlogoff, 
        :lastlogon, 
        :pwdlastset, 
        :accountexpires, 
        :lockouttime, 
        :lastlogontimestamp]

      @ymd_date_attr = [
        :whencreated,
        :whenchanged]

      @sid_attr = :objectsid

      @guid_attr = :objectguid

    def self.tohash(user)
      hash = Hash.new
      @@attr.each do |key|  

        value = user[key]

        if @utc_date_attr.include?(key)
          value = self.reformat_utc_date!(user[key])
        elsif @ymd_date_attr.include?(key)
          value = self.reformat_ymd_date!(user[key])
        elsif key == @sid_attr
          value = self.reformat_sid!(user)
        elsif key == @guid_attr
          value = self.reformat_guid!(user[key])
        end

        hash[key] = value

      end
      hash 
    end
    
    private

    def self.reformat!(hash)
      reformat_utc_date!(hash)
      reformat_ymd_date!(hash)
      reformat_sid!(hash)
      reformat_guid!(hash)
    end

    def self.reformat_utc_date!(utc_date_string)
      ActiveDirectory::FieldType::Timestamp.decode(utc_date_string)
    end

    def self.reformat_ymd_date!(ymd_date_string)
      ymd_date_string
    end

    def self.reformat_sid!(user)
      user.sid.to_s
    end

    def self.reformat_guid!(sid)
      UUIDTools::UUID.parse_hexdigest(sid).to_s
    end

  end
end