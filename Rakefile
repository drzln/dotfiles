require %(json)

desc %(use chef to provision local environment)
task :provision, %w[repo] do |_t, _args|
  repo              = ENV[%(DOTFILE_CHEF_REPO)] || %()
  cookbooks         = ENV[%(DOTFILE_COOKBOOKS)] || %()
  cookbook_config   = File.join(%(chef), %(cookbooks), %(dotfiles), %(.config.json))
  config            = %(.dotfile_provisioning_overrides.json)

  raise ArgumentError, %(must provide a DOTFILE_CHEF_REPO) if repo.empty?

  sh %(sudo rm -rf chef)
  sh %(git clone #{repo} chef) unless Dir.exist?(%(chef))

  if File.exist?(config)
    sh %(rm -rf #{cookbook_config})
    sh %(cp -r #{config} #{cookbook_config})
  else
    File.write(
      cookbook_config,
      {}.to_json
    )
  end

  chef_client_cmd = []
  chef_client_cmd << %(cd chef && sudo chef-client -z -o)
  cbks            = []
  cbks << %(dotfiles)
  cookbooks.split(%(,)).each do |cbk|
    cbks << cbk
  end
  chef_client_cmd << cbks.join(%(,))
  chef_client_cmd << %(-j)
  chef_client_cmd << %(cookbooks/dotfiles/.config.json)
  sh chef_client_cmd.join(%( ))
  sh %(sudo rm -rf chef)
  sh %(sudo rm -rf nodes)
end
