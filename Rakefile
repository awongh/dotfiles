require 'rake'
require 'erb'
require 'fileutils'

def install_neovim
  source = File.expand_path('config/nvim', __dir__)
  destination = File.join(ENV.fetch('HOME'), '.config', 'nvim')
  if File.exist?(destination) && File.identical?(source, destination)
    puts "identical #{destination}"
    return
  end
  if File.exist?(destination) || File.symlink?(destination)
    print "back up #{destination} and link Neovim config? [y/N] "
    unless $stdin.gets.to_s.strip.downcase == 'y'
      puts 'skipping Neovim'
      return
    end
    backup = "#{destination}.backup-#{Time.now.strftime('%Y%m%d%H%M%S')}-#{Process.pid}"
    backup += '-1' while File.exist?(backup) || File.symlink?(backup)
    FileUtils.mv(destination, backup)
    puts "backed up to #{backup}"
  end
  FileUtils.mkdir_p(File.dirname(destination))
  FileUtils.ln_s(source, destination)
  puts "linking #{destination}"
end

desc 'install only the Neovim configuration'
task :install_neovim do
  install_neovim
end

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.md LICENSE oh-my-zsh config scripts nvim.log]
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  install_neovim
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
