module AdUserServices
  class UserOfficeBinder

    def initialize
      @ad_user_dn_column = AdUser.arel_table[:dn]
      @offices = Office.all
    end

    def run
      bind_users_to_office(:name)
      bind_users_to_office(:name_2)
    end

    private

    def bind_users_to_office(office_col)
      @offices.each do |office|
        found_users = AdUser.where( @ad_user_dn_column.matches("%#{I18n.transliterate(office[office_col])}%") )
        update_users_with_office(found_users, office)
      end
    end

    def update_users_with_office(found_users, office)
      found_users.each do |user|
        user_detail = AdUserDetail.find_or_create_by(ad_user_id: user.id)
        user_detail.update(office_id: office.id) if user_detail.office_id.nil?
      end
    end

  end
end