module LdapServices
  class LdapHeaderSync
    #this functionality will be moved to db/seeds.rb file later. It is used to define default translation tabel for all User LDAP values.
    def initialize
      @translation_en_hash = {
        dn: "Distinguished Name",
        objectclass: "Object Class",
        cn: "Common Name",
        sn: "Last name",
        givenname: "First name",
        displayname: "Display name",
        description: "Description",
        distinguishedname: "Distinguished Name",
        instancetype: "Instance Type",
        whencreated: "When Created",
        whenchanged: "When Changed",
        usncreated: "USN Created",
        memberof: "Groups membership",
        usnchanged: "USN Changed",
        name: "Name",
        objectguid: "GUID",
        useraccountcontrol: "UAC",
        badpwdcount: "Bad password count",
        codepage: "Code Page",
        countrycode: "Country Code",
        badpasswordtime: "Bad password time",
        lastlogoff: "Last Logoff",
        lastlogon: "Last Logon",
        logonhours: "Logon hours",
        pwdlastset: "Password last set",
        primarygroupid: "Primary Group ID",
        objectsid: "SID",
        admincount: "Admin Count",
        accountexpires: "Account Expiration Date",
        logoncount: "Logon Count",
        samaccountname: "Login",
        samaccounttype: "Account type",
        lockouttime: "Lockout time",
        objectcategory: "Object Category",
        iscriticalsystemobject: "",
        dscorepropagationdata: "",
        lastlogontimestamp: "",
        "msds-supportedencryptiontypes" =>  "",
        mail: "Mail",
        userprincipalname: "Principal name"
      }
  
      @header_orig_name = :name
      @header_en_name = :name_en
    end

    def sync(localized_header_data)
      AdUserHeader.destroy_all
      localized_header_data.each { |entry| AdUserHeader.create(entry)}
    end

    def localized_en_headers
      data = Array.new
      @translation_en_hash.each do |tr_k, tr_v|
        data << {name: tr_k, name_en: tr_v}
      end
      data
    end

  end
end