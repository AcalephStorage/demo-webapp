require 'sinatra'
require 'logger'
require 'erb'
require 'tilt'
require 'faraday'
require 'json'

if %w{development test}.include?(ENV['RACK_ENV'])
  K8S_URL   = 'nyahahaha'
  K8S_TOKEN = 'heheheheh'
else
  K8S_URL   = ENV['KUBERNETES_API_URL']
  K8S_TOKEN = ENV['KUBERNETES_API_TOKEN']
end

class DemoMan < Sinatra::Base
  set :root, File.dirname(__FILE__)

  # http://spin.atomicobject.com/2013/11/12/production-logging-sinatra/
  Logger.class_eval { alias :write :'<<' }
  access_log        = File.join(settings.root, 'log', 'access.log')
  access_logger     = Logger.new(access_log)
  error_logger      = File.new(File.join(settings.root, 'log', 'error.log'), 'a+')
  error_logger.sync = true

  configure do
    use Rack::CommonLogger, access_logger
  end

  before {
    env["rack.errors"] =  error_logger
  }

  get '/' do
    @image      = 'hunter_nield.jpg'
    @name       = 'Hunter'
    @occupation = 'Docker Lord'
    # @image        = 'alistair_israel.jpg'
    # @name         = 'Alistair'
    # @occupation   = 'Spreadsheet Engineer'
    pods          = get_pods
    @total_pods   = pods.length
    @running_pods = running_pods(pods).length
    @rc_count     = get_rcs.length

    erb :index
  end

  get '/k8s' do
    content_type :json

    pods = get_pods

    {
      pods: {
        running: running_pods(pods).length,
        total: pods.length
      },
      rcs: {
        total: get_rcs.length
      }
    }.to_json
  end

  def kube_request(url)
    conn = Faraday.new(url: K8S_URL, ssl: { verify: false })
    res = conn.get do |req|
      req.headers['Authorization'] = "Bearer #{K8S_TOKEN}"
      req.url url
    end

  rescue StandardError
    Faraday::Response.new
  end

  def get_list(url)
    req = kube_request(url)
    req.success? ? JSON.parse(req.body)['items'] : []
  end

  def get_pods
    get_list('/api/v1/pods')
  end

  def get_rcs
    get_list('/api/v1/replicationcontrollers')
  end

  def running_pods(pods = [])
    pods = pods.empty? ? get_pods : pods
    pods.select { |pod| pod['status']['phase'] == 'Running' }
  end
end
