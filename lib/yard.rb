module YARD
  VERSION = "0.2.2"
  ROOT = File.join(File.dirname(__FILE__), 'yard')
  TEMPLATE_ROOT = File.join(File.dirname(__FILE__), '..', 'templates')

  def self.parse(paths = "**/*.rb", level = Logger::INFO)
    old_level, YARD.logger.level = YARD.logger.level, level
    
    if paths.is_a?(Array)
      files = paths.map {|p| Dir[p] }.flatten
    else
      files = Dir[File.join(Dir.pwd, paths)]
    end
    
    files.uniq.each do |file|
      log.debug("Processing #{file}")
      YARD::Parser::SourceParser.parse(file)
    end
    
    YARD.logger.level = old_level
  end
end

$:.unshift(YARD::ROOT)

files  = ['logging', 'autoload']
files += Dir.glob File.join(YARD::ROOT, 'core_ext/*')
files.each {|file| require file.gsub(/\.rb$/, '') }


