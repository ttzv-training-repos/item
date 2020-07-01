module OfficesHelper

  def office_params
    params.require(:office)
    .permit(:name,
            :name_2,
            :location,
            :location_2,
            :postalcode,
            :phonenumber,
            :phonenumber_2,
            :opt_info,
            :opt_info_2,
            :fax,
            :fax_2)
  end

end