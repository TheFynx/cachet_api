lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'irb'
require 'cachet.rb'

module IRB
  def self.start_session(binding)
    IRB.setup(nil)

    workspace = WorkSpace.new(binding)

    if @CONF[:SCRIPT]
      irb = Irb.new(workspace, @CONF[:SCRIPT])
    else
      irb = Irb.new(workspace)
    end

    @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
    @CONF[:MAIN_CONTEXT] = irb.context

    trap('SIGINT') do
      irb.signal_handle
    end

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

api = '9yMHsdioQosnyVK4iCVR'
base_url = 'https://demo.cachethq.io/api/v1/'

# we want to manipulate this in IRB
CachetClient = CachetClient.new(api, base_url)
CachetComponents = CachetComponents.new(api, base_url)
CachetIncidents = CachetIncidents.new(api, base_url)
CachetMetrics = CachetMetrics.new(api, base_url)
CachetSubscribers = CachetSubscribers.new(api, base_url)

componentoptions = {}
componentoptions['id']      = '1'
componentoptions['name']    = 'API'
componentoptions['status']  = '1'

incidentoptions = {}
incidentoptions['id']      = '1'
incidentoptions['status']  = '1'

metricoptions = {}
metricoptions['id'] = '1'

subscribecoptions = {}
subscribecoptions['email']  = 'test@test.com'
subscribecoptions['verify'] = '0'

IRB.start_session(Kernel.binding)
