# frozen_string_literal: true

require "nokogiri"
require "fileutils"
require "pathname"

module Jekyll
  class InjectBodyConverter < Converter
    def output_ext(ext)
      ".html"
    end

    def matches(ext)
      ext =~ /^\.inject_body$/i
    end

    def convert(content)
      @content = content.strip

      #copy_assets(assets_from_path, assets_to_path)

      load_html
      sanitize(body).to_html
    end

    :private

    def body_from_path
      line = @content.split("\n").find {|i| i.strip =~ /^BODY_FROM/ }
      line.split(":").last.strip
    end

    def assets_from_path
      line = @content.split("\n").find {|i| i.strip =~ /^ASSETS_FROM/ }
      line.split(":").last.strip
    end

    def assets_to_path
      line = @content.split("\n").find {|i| i.strip =~ /^ASSETS_TO/ }
      line.split(":").last.strip
    end

    def copy_assets(from, to)
      pp Dir.glob(from)
      pp to
      FileUtils.mkdir_p(to)
      FileUtils.cp_r(Dir.glob(from), to)

      puts "writing test fime"
      File.write("#{to}/test", "TESTTEST")

      pp File.read("#{to}/test")
    end

    def load_html
      html_path = body_from_path
      html_source = File.read(html_path)
      @source_doc = Nokogiri::HTML(html_source)
    end

    def body
      @source_doc.search("body").first
    end

    def sanitize(fragment)
      fragment.search('script').each do |s|
        s.remove
      end

      fragment
    end
  end

  class InjectBodyGenerator < Generator
    def generate(site)
      #return
      @site = site

      injected_pages.each do |p|
        register_files(p)
      end
    end

    :private

    def injected_pages
      @site.pages.filter do |p|
        p.name =~ /inject_body$/
      end
    end

    def assets_from(page)
      line = page.content.split("\n").find {|i| i.strip =~ /^ASSETS_FROM/ }
      line.split(":").last.strip
    end

    def assets_to(page)
      line = page.content.split("\n").find {|i| i.strip =~ /^ASSETS_TO/ }
      line.split(":").last.strip
    end

    def assets_glob(page)
      line = page.content.split("\n").find {|i| i.strip =~ /^ASSETS_GLOB/ }
      line.split(":").last.strip
    end

    def register_files(page)
      to_copy = []
      from = assets_from(page)
      glob = assets_glob(page)
      to = assets_to(page)

      Dir.chdir(from) do
        Dir.glob(glob).each do |i|
          to_copy << i
        end
      end

      source_base_path = Pathname.new(from)
      target_base_path = Pathname.new(to)

      to_copy.each do |i|
        source_path = source_base_path.join(i)
        target_path = target_base_path.join(i)

        matching_known_files = @site.static_files.find do |f|
          f.path[target_path.to_s]
        end

        if matching_known_files.nil?
          if Dir.exist?(source_path)
            FileUtils.mkdir_p(target_path)
          end

          if File.file?(source_path)
            FileUtils.cp(source_path, target_path)

            @site.static_files << StaticFile.new(
              @site,
              Dir.pwd,
              target_path.dirname,
              target_path.basename
            )
          end

        end
      end
    end
  end
end
