stdout_lock = Mutex.new
STDOUT.sync = true


TracePoint.trace(:thread_begin) do |tp|
  puts [tp.lineno]
end.enable


class MyThreadError < StandardError; end

# Simply 
class LoggingThread < Thread
  def initialize(id = 0)
    @id = id
    @creation_time = Time.now
    super
  end

  def to_s
    self.inspect
  end

  def inspect
    "\#<#{self.class}:#{@id} (#{status})>"
  end
end

def test
  start_time = Time.now
  thread_count = 0
  
  # Two simple lambdas to help log output.
  t_diff = -> { "#{(Time.now - start_time) * 1000.0}ms" }

  log = -> (msg, lno) {
    stdout_lock.synchronize {
      str = "#{msg}\n#{'-' * 20}\n#{__FILE__}:#{lno}\n#{'-' * 20}\nElapsed Time: #{t_diff.call}\n"
      str << "#{LoggingThread.list.map(&:inspect).join("\n")}\n\n"
      puts str
    }
  }

  LoggingThread.abort_on_exception = false

  log.call("Created thread 1", __LINE__)
  t1 = LoggingThread.new(LoggingThread.list.size) do
    log.call("Now waiting #{1}s in #{LoggingThread.current}.", __LINE__)
    sleep 1
    log.call("Calling raise from #{LoggingThread.current}.", __LINE__)
    raise MyThreadError, "Raise from #{LoggingThread.current}."
  end
  log.call("Creating a second thread...", __LINE__)
  t2 = LoggingThread.new(LoggingThread.list.size) do
    log.call("Now waiting #{1}s in thread #{LoggingThread.current}.", __LINE__)
    sleep 1
    log.call("Now exiting #{LoggingThread.current}.", __LINE__)
  end
  log.call("Now joining #{t1}, then #{t2}...", __LINE__)
  [t1, t2].map(&:join)
  log.call("Now waiting 5s after joining threads.", __LINE__)
  sleep 5
  log.call("Exiting.", __LINE__)
rescue MyThreadError => e
  log.call("In rescue.\n#{e.class}:#{e.message}", __LINE__)
end

test
