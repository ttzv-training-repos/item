module AdUsersHelper

    def ad_user_params
        params.require(:ad_user).permit(:objectguid,
                                        :objectsid,
                                        :givenname,
                                        :sn,
                                        :name,
                                        :samaccountname,
                                        :distinguishedname,
                                        :mail)
    end

end
