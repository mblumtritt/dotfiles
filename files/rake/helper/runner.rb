module Helper
  module Runner
    protected def run(*cmd, stdin_data: nil, status: false, chdir: nil)
      opts = { err: %i[child out] }
      opts[:chdir] = chdir if chdir
      ret =
        if stdin_data
          __run(cmd, opts, stdin_data)
        else
          IO.popen(*cmd, opts, &:read)
        end
      status ? [Process.last_status, ret] : ret
    rescue Errno::ENOENT
      nil
    end

    private def __run_(cmd, opts, stdin_data)
      IO.pipe do |in_read, in_write|
        opts[:in] = in_read
        IO.popen(*cmd, opts) do |out|
          in_write.sync = true
          if stdin_data.respond_to?(:readpartial)
            IO.copy_stream(stdin_data, in_write)
          else
            in_write.write(stdin_data)
          end
          in_write.close
          return out.read
        end
      end
    end
  end
end
