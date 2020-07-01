module AdUserServices
  class UserOfficeBinder

    def run_binder
      ad_user_dn_column = AdUser.arel_table([:dn])
      offices = Office.all
      offices.each do |office|
        found_users = AdUser.where(dn.matches(I18n.transliterate(office.name_2)))
        found_users.each do |user|
          user_detail = AdUserDetail.find_or_create_by(id: user.id)
          user_detail.update(office_id: office.id)
        end
      end
    end
  end
end