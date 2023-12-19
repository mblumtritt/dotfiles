# frozen_string_literal: true

module AppProject
  ICON =
    '/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/' \
      'GenericApplicationIcon.icns'

  class << self
    attr_reader :name, :script, :exe_name, :icon_name, :info_name
  end

  base = (ENV['NAME'] || File.basename(Dir.pwd)).freeze

  @name = base.split('-').map!(&:capitalize).join.freeze
  @script = (File.exist?(base) ? base : "#{base}.sh").freeze

  root_dir = "#{@name}.app/Contents".freeze

  @exe_name = "#{root_dir}/MacOS/#{@name}".freeze
  @icon_name = "#{root_dir}/Resources/AppIcon.icns".freeze
  @info_name = "#{root_dir}/Info.plist".freeze
end

desc "Create '#{AppProject.name}.app' from './#{AppProject.script}'"
task app: [AppProject.info_name, AppProject.icon_name]

file_create AppProject.exe_name => AppProject.script do |f|
  dir_for f.name
  cp AppProject.script, f.name
  chmod '+x', f.name
end

file_create AppProject.icon_name => AppProject::ICON do |f|
  dir_for f.name
  cp AppProject::ICON, f.name
end

file_create AppProject.info_name => AppProject.exe_name do |f|
  write f.name, <<~PLIST
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>CFBundleExecutable</key>
        <string>#{AppProject.name}</string>
        <key>CFBundleGetInfoString</key>
        <string>#{AppProject.name}</string>
        <key>CFBundleName</key>
        <string>#{AppProject.name}</string>
        <key>CFBundleIconFile</key>
        <string>AppIcon</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleTypeRole</key>
        <string>Viewer</string>
        <key>CFBundleDocumentTypes</key>
      	<array>
      		<dict>
      			<key>CFBundleTypeExtensions</key>
      			<array>
      				<string>*</string>
      			</array>
      			<key>CFBundleTypeOSTypes</key>
      			<array>
      				<string>****</string>
      			</array>
      			<key>CFBundleTypeRole</key>
      			<string>Viewer</string>
      		</dict>
      	</array>
      </dict>
    </plist>
  PLIST
end
