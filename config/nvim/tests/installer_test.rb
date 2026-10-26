require 'tmpdir'
require 'fileutils'
require 'open3'
repo = File.expand_path('../../..', __dir__)
Dir.mktmpdir('dotfiles-installer') do |root|
  fixture = File.join(root, 'repo')
  home = File.join(root, 'home')
  FileUtils.mkdir_p([File.join(fixture, 'config/nvim'), File.join(home, '.config/other')])
  FileUtils.cp(File.join(repo, 'Rakefile'), fixture)
  File.write(File.join(fixture, 'config/nvim/init.lua'), '-- test')
  File.write(File.join(fixture, 'vimrc'), 'test')
  File.write(File.join(fixture, 'README.md'), 'test')
  sentinel = File.join(home, '.config/other/settings')
  File.write(sentinel, 'preserve')
  run = ->(task, input = '') do
    out, status = Open3.capture2e({ 'HOME' => home }, 'rake', task, chdir: fixture, stdin_data: input)
    raise out unless status.success?
    out
  end
  run.call('install')
  dest = File.join(home, '.config/nvim')
  raise 'bad nvim link' unless File.identical?(dest, File.join(fixture, 'config/nvim'))
  raise 'config replaced' if File.symlink?(File.join(home, '.config'))
  raise 'readme linked' if File.exist?(File.join(home, '.README.md'))
  raise 'generic mapping changed' unless File.symlink?(File.join(home, '.vimrc'))
  raise 'not idempotent' unless run.call('install').include?('identical')
  File.unlink(dest)
  FileUtils.mkdir_p(dest)
  File.write(File.join(dest, 'original'), 'keep')
  run.call('install_neovim', "n\n")
  raise 'declined backup changed target' unless File.file?(File.join(dest, 'original'))
  run.call('install_neovim', "y\n")
  backup = Dir[dest + '.backup-*'].first
  raise 'backup lost' unless File.read(File.join(backup, 'original')) == 'keep'
  File.unlink(dest)
  File.symlink('/nonexistent/nvim', dest)
  run.call('install_neovim', "y\n")
  raise 'broken link replacement failed' unless File.identical?(dest, File.join(fixture, 'config/nvim'))
  raise 'other settings lost' unless File.read(sentinel) == 'preserve'
  puts 'PASS: full install, targeted install, idempotence, preservation, declined conflict, directory backup, broken link backup'
end
