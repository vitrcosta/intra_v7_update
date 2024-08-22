class Intranet::CapaController < Intranet::IntranetController
  before_action :authorize
  protect_from_forgery except: [:update_index]


  def index
    @date_filter = "30_dias"
    @visitors_by_date = nil
    @visitors = nil
    @sessions = nil
    @pageviews =  nil
    @avg_duration = nil
  end

  def update_index


    require 'google/api_client'
    require 'date'

    @date_filter = params[:date]
    service_account_email = 'analytics-intranet@api-project-359628520071.iam.gserviceaccount.com' # Email of service account
    key_file = 'config/API Project-6186e14a5b0a.p12' # File containing your private key
    key_secret = 'notasecret' # Password to unlock private key
    profile = 'ga:18033085' # Analytics profile ID.
    @client_id = 'ga:18033085'
    client = Google::APIClient.new(
      :application_name => 'API Project',
      :application_version => '1.0')

    key = Google::APIClient::KeyUtils.load_from_pkcs12(key_file, key_secret)
    client.authorization = Signet::OAuth2::Client.new(
        :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
        :audience => 'https://accounts.google.com/o/oauth2/token',
        :scope => 'https://www.googleapis.com/auth/analytics.readonly',
        :issuer => service_account_email,
        :signing_key => key)

    client.authorization.fetch_access_token!

    analytics = client.discovered_api('analytics','v3')

    if @date_filter == '30_dias'
      # start_date = Time.now - 1.month
      start_date = Date.today.last_month.strftime("%Y-%m-%d").to_s
      end_date = Date.today.strftime("%Y-%m-%d").to_s
      dimension = "ga:date"
    elsif @date_filter == '7_dias'
      start_date = Date.today.last_week.strftime("%Y-%m-%d").to_s
      end_date = Date.today.strftime("%Y-%m-%d").to_s
      dimension = "ga:date"
    else
      start_date = Date.yesterday.strftime("%Y-%m-%d").to_s
      end_date = Date.yesterday.strftime("%Y-%m-%d").to_s
      dimension = "ga:hour"
    end

    result = client.execute(:api_method => analytics.data.ga.get, :parameters => {
        'ids'        => profile,
        'start-date' => start_date,
        'end-date'   => end_date,
        'metrics'    => 'ga:visitors,ga:sessions,ga:pageviews,ga:avgSessionDuration',
    })
    result2 =  client.execute(:api_method => analytics.data.ga.get, :parameters => {
        'ids'        => profile,
        'start-date' => start_date,
        'end-date'   => end_date,
        'dimensions' => dimension,
        'metrics'    => 'ga:visitors',
    })


    @visitors_by_date = result2.data.rows

    @visitors = result.data.totalsForAllResults["ga:visitors"]
    @sessions = result.data.totalsForAllResults["ga:sessions"]
    @pageviews =  result.data.totalsForAllResults["ga:pageviews"]
    @avg_duration =  Time.at(result.data.totalsForAllResults["ga:avgSessionDuration"].to_f).utc.strftime("%H:%M:%S")

    respond_to do |format|
      format.js
    end

  end

end
