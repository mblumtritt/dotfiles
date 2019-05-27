# frozen_string_literal: true

desc 'create a new Ruby repository'
task :ruby, [:name] do |_, args|
  name = args[:name] or fail 'name expected'
  basename = File.basename(name, '.*')
  want :git, name
  want "#{name}/lib/#{basename}.rb"
  want "#{name}/lib/#{basename}/version.rb"
  want "#{name}/gems.rb"
end

rule '.rb' do |r|
  file_name = File.expand_path(r.name)
  write file_name, Ruby.file_content(file_name)
end

module Ruby
  def self.file_content(file_name)
    content(find_module_name(file_name), find_class_name(file_name))
  end

  def self.content(module_name, class_name)
    return class_file(class_name) unless module_name
    return module_file(module_name) if class_name == module_name
    return version_file(module_name) if class_name == 'Version'
    mod_class_file(module_name, class_name)
  end

  def self.version_file(module_name)
    <<~VERSION_FILE
      # frozen_string_literal: true

      module #{module_name}
        VERSION = '0.0.1'
      end
    VERSION_FILE
  end

  def self.class_file(class_name)
    <<~CLASS_FILE
      # frozen_string_literal: true

      class #{class_name}
        # TODO class body
      end
    CLASS_FILE
  end

  def self.module_file(module_name)
    <<~MODULE_FILE
      # frozen_string_literal: true

      module #{module_name}
        # TODO module body
      end
    MODULE_FILE
  end

  def self.mod_class_file(module_name, class_name)
    <<~MOD_CLASS_FILE
      # frozen_string_literal: true

      module #{module_name}
        class #{class_name}
          # TODO class body
        end
      end
    MOD_CLASS_FILE
  end

  def self.find_class_name(file_name)
    const_name(File.basename(file_name, '.rb'))
  end

  def self.find_module_name(file_name)
    re = %r((\w+)/lib/(.*/)?#{Regexp.escape(File.basename(file_name))})
    match = file_name.match(re) or return nil
    const_name(match[1])
  end

  def self.const_name(str)
    str.split(%r([-_])).map!(&:capitalize).join
  end
end
