module Zealg
  class Boilerplate
    APPLICATION_HELPER_METHODS = <<-EOF
  def client_stylesheet_tag
    [
      "\#{stylesheet_link_tag('/client.css') unless using_node_server?}",
      "\#{stylesheet_link_tag('/vendor.css')}"
    ].join("\\n").html_safe
  end

  def client_javascript_tag
    javascript_include_tag(env_specific_url('client.js'))
  end

  def env_specific_url(resource)
    using_node_server? ? "http://localhost:8080/\#{resource}" : "/\#{resource}"
  end

  def using_node_server?
    %w(test development).include? Rails.env
  end
  EOF
    CLIENT_LAYOUT = <<-EOF
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Zeal Skill Tree</title>
    <%= client_stylesheet_tag %>
    <%= client_javascript_tag %>
    <%= javascript_include_tag :client %>
    <%= csrf_meta_tags %>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
  <body>
    <div id="root">
    </div>
  </body>
</html>
    EOF

    def install
      puts "Cloning boilerplate"
      ::Git.clone('https://github.com/CodingZeal/react-boilerplate.git', 'boilerplate', path: "#{Dir.pwd}/tmp")
      move_boilerplate
      write_to(
        dest("app/helpers/application_helper.rb"),
        after: "module ApplicationHelper",
        text: APPLICATION_HELPER_METHODS
      )
      open(dest('app/views/layouts/client.html.erb'), 'w') do |f|
        f.write(CLIENT_LAYOUT)
      end
      puts "Installing node_modules..."
      %x(npm install)
      cleanup_tmp
    end

    private

    def write_to(file_name, after:, text:)
      open(file_name, 'r+') do |file|
        file.each_line do |line|
          if line.strip == after
            current_position = file.pos
            rest_of_file = file.read
            file.seek current_position
            file.write text
            file.write rest_of_file
          end
        end
      end
    end

    def cleanup_tmp
      puts "Cleaning up after myself"
      FileUtils.rm_r("#{Dir.pwd}/tmp/boilerplate")
    end

    def move_boilerplate
      puts "Moving boilerplate files to rails root"
      Dir[src("*")].each do |file|
        unless File.exist?("#{Dir.pwd}/#{File.basename(file)}")
          if File.directory?(file)
            FileUtils.cp_r(file, Dir.pwd)
          else
            FileUtils.cp(file, Dir.pwd)
          end
        end
      end
    end

    def dest(name)
      "#{Dir.pwd}/#{name}"
    end

    def src(name)
      "#{Dir.pwd}/tmp/boilerplate/#{name}"
    end
  end
end
