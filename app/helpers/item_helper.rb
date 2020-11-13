module ItemHelper

  def fetch_google_profile(client)
    GoogleApiServices::ProfileService.new(client)
  end

end
