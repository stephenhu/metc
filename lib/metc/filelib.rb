module Metc

  module Filelib

    def self.create_directory(name)

      unless name.nil?

        if File.directory?(name)
          puts "directory already exists"
        else
          FileUtils.mkdir_p(name)
          puts "directory #{name} created".green
        end

      end

    end

    def self.create_file( text, filename, dest, overwrite=false )

      filename = File.basename( filename, File.extname(filename) ) + HTMLEXT
      filename = dest + SLASH + filename

      reply   = false
      write   = false

      if File.exists?(filename)

        reply = agree("file #{filename} exists, overwrite?".red) {
          |q| q.default = "n" } unless overwrite

      else
        write = true
      end

      if overwrite or reply or write
 
        f = File.open( filename, "w" )
        f.write(text)
        f.close

        if overwrite or reply
          puts "file #{filename} overwritten".green
        else
          puts "file #{filename} created".green
        end

      end

    end

    def self.get_templates()

      return Dir.glob( Metc::HAML, File::FNM_CASEFOLD )

    end

    def self.get_contents()

      return Dir.glob( Metc::MARKDOWN, File::FNM_CASEFOLD )

    end

  end

end

