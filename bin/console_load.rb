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

    trap("SIGINT") do
      irb.signal_handle
    end

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

# we want to manipulate this in IRB
CachetComponents = CachetComponents.new('9yMHsdioQosnyVK4iCVR', 'https://demo.cachethq.io/api/v1/')
CachetIncidents = CachetIncidents.new('9yMHsdioQosnyVK4iCVR', 'https://demo.cachethq.io/api/v1/')
CachetMetrics = CachetMetrics.new('9yMHsdioQosnyVK4iCVR', 'https://demo.cachethq.io/api/v1/')
options = {}
options['id'] = '1'
options['name'] = 'API'
options['status'] = '1'

IRB.start_session(Kernel.binding)
