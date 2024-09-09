# frozen_string_literal: true

require "nokogiri"
require "fileutils"

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
      return
      @site = site

      injected_pages.each do |p|
        from = assets_from(p)
        to = assets_to(p)

        pp from
        pp to

        copy_assets(from, to)
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

    def copy_assets(from, to)
      FileUtils.mkdir_p(to)
      FileUtils.cp_r(Dir.glob(from), to)
    end
  end
end
