require "tempfile"
require "pathname"
require "fileutils"

class RmarkdownFigure < Jekyll::StaticFile
  def initialize(site, base, dir, tempdir, name, collection = nil)
    @tempdir = tempdir
    super(site, base, dir, name, collection)
  end

  def path
    @tempdir.join(name)
  end
end

module Phb
  class RmarkdownProcessor < Jekyll::Generator

    def generate(site)
      @site = site

      rmds = site.pages.filter do |page|
        page.ext.downcase == ".rmd"
      end

      rmds.each do |page|
        if (check_if_stale(page))
          page.content = knit(page)
        end
      end

    end

    def check_if_stale(page)
      # TODO
      false
    end


    def knit(page)
      # pp page.data
      page_base_name = File.basename(page.name, ".*")
      page_relative_path = Pathname.new(page.dir.sub(/^\//, "")).join(page_base_name)

      # pp page_base_name
      # pp page_relative_path

      rmd_content = page.content

      tempdir_name = Dir.mktmpdir()
      tempdir_path = Pathname.new(tempdir_name)
      File.write(tempdir_path.join(page.name), rmd_content)

      knit_script = <<~EOF
      library(knitr)
      knitr::opts_knit$set(progress = FALSE, verbose = FALSE)
      knitr::opts_chunk$set(fig.path = "#{page_base_name}/", fig.align = "center", fig.retina = 2, fig.width = 8)
      knit("#{page.name}")
      EOF

      File.write(tempdir_path.join("knit.r"), knit_script)

      Dir.chdir(tempdir_path) do
        system("Rscript knit.r")
        system("ls -la")
        system("cat knit.r")
      end

      tempdir_figure_path = tempdir_path.join(page_base_name)

      Dir.children(tempdir_figure_path).each do |f|
        # pp f
        #static_file_dir_path = page_relative_path.join(page_base_name)

        @site.static_files << RmarkdownFigure.new(
          @site,
          @site.source,
          page_relative_path,
          tempdir_figure_path,
          f
        )
      end

      File.read(tempdir_path.join("#{page_base_name}.md"))
    end

  end
end
