require 'sinatra'
require 'rufus/scheduler'
require 'json'
require 'yaml'

SCHEDULER = Rufus::Scheduler.new

set :root, Dir.pwd

get '/' do
  "Metrics-in-a-box!"
end

def require_glob(relative_glob)
  Dir[File.join(settings.root, relative_glob)].each do |file|
    require file
  end
end

{}.to_json # Forces your json codec to initialize (in the event that it is lazily loaded). Does this before job threads start.
job_path = ENV["JOB_PATH"] || 'jobs'
require_glob(File.join('lib', '**', '*.rb'))
require_glob(File.join(job_path, '**', '*.rb'))
