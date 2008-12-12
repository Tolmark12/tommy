require 'sprout'
# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'as3'

############################################
# Uncomment and modify any of the following:
Sprout::ProjectModel.setup do |model|
  model.project_name  = 'CafeFlash'
  # Default Values:
  # model.src_dir       = 'src'
  # model.lib_dir       = 'lib'
  # model.swc_dir       = 'lib'
  model.bin_dir       = '.'
  # model.test_dir      = 'test'
  # model.doc_dir       = 'doc'
  model.asset_dir     = 'flash_loads'
  model.language      = 'as3'
  model.output        = "#{model.bin_dir}/CafeFlash.swf"
  model.test_output   = "#{model.bin_dir}/UnitTests.swf"
end

model = Sprout::ProjectModel.instance

############################################
# Set up remote library tasks
# the task name will be converted to a string
# and modified as follows sprout-#{name}-library
# unless you pass t.gem_name = 'full-sprout-name'
# For libraries that contain source code, the
# task name will also be the folder name that 
# will be added to ProjectModel.lib_dir
# For a complete list of available sprout gems:
# http://rubyforge.org/frs/?group_id=3688
# You can also search that list directly from a
# terminal as follows:
# gem search -r sprout-*library

library :asunit3
library :corelib


############################################
# Launch the application using the Flash Player
# NOTE: double-quoted strings in ruby enable
# runtime expression evaluation using the
# following syntax:
# "Some String with: #{variable}"

desc "Compile and run main application"
flashplayer :run => model.output

# Make 'run' the default task
task :default => :run

############################################
# Launch the test suites using the Flash Player

desc "Compile and run test suites"
flashplayer :test => model.test_output

############################################
# Compile your application using mxmlc
# Any library tasks that are set as 
# dependencies will automatically be added
# to the compiler source or swc paths

desc "Compile application"
mxmlc model.output => [:corelib] do |t|
# Uncomment to use the Flex 3 SDK
  t.gem_name                  = 'sprout-flex3sdk-tool'
  t.warnings                  = true
  t.default_background_color  = '#F7EDD9'
  t.default_frame_rate        = 30
  t.default_size              = '790 590'
  t.input                     = "#{model.src_dir}/CafeFlash.as"
  t.source_path               << model.asset_dir
  t.source_path               << "#{model.lib_dir}/"
  t.library_path              << "./CafeFlash.swc"
  t.library_path              << "#{model.lib_dir}/ProgressSwcSrc.swc"
end

############################################
# Compile test harness using mxmlc

desc "Compile test harness"
mxmlc model.test_output => [:asunit3, :corelib] do |t|
# Uncomment to use the Flex 3 SDK
  t.gem_name                  = 'sprout-flex3sdk-tool'
  t.warnings                  = false
  t.default_background_color  = '#FFFFFF'
  t.default_frame_rate        = 24
  t.verbose_stacktraces       = false
  t.default_size              = "800 450"
  t.input                     = "#{model.src_dir}/CafeFlashRunner.as"
  t.source_path               << "#{model.lib_dir}/"
  t.source_path               << model.src_dir
  t.source_path               << model.test_dir
  t.source_path               << model.asset_dir
  t.library_path              << "./CafeFlash.swc"
  
end

############################################
# Build documentation for your application

desc "Create documentation"
asdoc model.doc_dir => model.test_output do |t|
# Uncomment to use the Flex 3 SDK
  t.gem_name                  = 'sprout-flex3sdk-tool'
end
