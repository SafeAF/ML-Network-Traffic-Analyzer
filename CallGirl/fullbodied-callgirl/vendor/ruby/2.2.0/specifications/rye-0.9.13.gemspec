# -*- encoding: utf-8 -*-
# stub: rye 0.9.13 ruby lib

Gem::Specification.new do |s|
  s.name = "rye"
  s.version = "0.9.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Delano Mandelbaum"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDNjCCAh6gAwIBAgIBADANBgkqhkiG9w0BAQUFADBBMQ8wDQYDVQQDDAZkZWxh\nbm8xGTAXBgoJkiaJk/IsZAEZFglzb2x1dGlvdXMxEzARBgoJkiaJk/IsZAEZFgNj\nb20wHhcNMTMxMTA5MjMwMDIxWhcNMTQxMTA5MjMwMDIxWjBBMQ8wDQYDVQQDDAZk\nZWxhbm8xGTAXBgoJkiaJk/IsZAEZFglzb2x1dGlvdXMxEzARBgoJkiaJk/IsZAEZ\nFgNjb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDQi2irQs6LMzrT\nyZr7Z3v7duQ4VUA7TjYVx44fdiX3FsRnpmm5aS8ixCZ/4DNYP63r8SgYpuksfu7n\nwwo9FGwV0NiscMeEvJM/RtUAEOR6n37Te/4R8HAbRYavhT/Y8YtRoylIdsqr7uZP\nw8eJO9FcIEt6e/jayd8+BhbOdL/IRCxTMCtwrZnuLNDnOO88vAIBBznRUiuPYGGT\nBL7IHN8VoW2zuaVVrtMYwbfFbXFUsQywKP0bTWIoLtRA1G0coQTOGkwm0db5CT3C\nCTbLVfYtu5mkKp62/f19otQodJ3CEQqLiIV2tqnuENGAyRE+YxEPSfzsMyy3nsFl\nUkM5196fAgMBAAGjOTA3MAkGA1UdEwQCMAAwHQYDVR0OBBYEFLrhwcL49crZdUx2\nwKZve/TRyM5+MAsGA1UdDwQEAwIEsDANBgkqhkiG9w0BAQUFAAOCAQEAw/rgPKhE\nHCLcqOJlPRwuJ1AMHN1/vyqSCMgL+vEDW7+R1N1lWfK0wJFPMMzw4UbkFheW32lq\niXMy+szSO7LS9Qwj/Z6sXTkoiCuDdPLX/7bfiGKrIQsngI76hr618YD7CG6H1VCp\nddZ/SHJSclG2r1WlNipmMSLwmkRlgorRdzyuMZzHqXfNs/s1yi7ISduTNbqlYqao\nb6zaXOBf3CFE8TP4BsAPrRWMZXQU4AI7LVA51rxFxHLULrbjwPQHRaTUXjvYJe/d\n8C5Zonkck5dB2XKfqg9R74KKmR4h22e74ovj1vtoYvITFOZpCQf46Iuw+WzDA3fz\nm4n8YIJJer0nsg==\n-----END CERTIFICATE-----\n"]
  s.date = "2015-04-15"
  s.description = "Run SSH commands on a bunch of machines at the same time (from Ruby)."
  s.email = "delano@solutious.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README.rdoc"]
  s.files = ["LICENSE.txt", "README.rdoc"]
  s.homepage = "https://github.com/delano/rye"
  s.rubyforge_project = "rye"
  s.rubygems_version = "2.4.6"
  s.summary = "Run SSH commands on a bunch of machines at the same time (from Ruby)."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<annoy>, [">= 0"])
      s.add_runtime_dependency(%q<sysinfo>, [">= 0.8.1"])
      s.add_runtime_dependency(%q<highline>, [">= 1.5.1"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 2.0.13"])
      s.add_runtime_dependency(%q<net-scp>, [">= 1.0.2"])
      s.add_runtime_dependency(%q<docile>, [">= 1.0.1"])
    else
      s.add_dependency(%q<annoy>, [">= 0"])
      s.add_dependency(%q<sysinfo>, [">= 0.8.1"])
      s.add_dependency(%q<highline>, [">= 1.5.1"])
      s.add_dependency(%q<net-ssh>, [">= 2.0.13"])
      s.add_dependency(%q<net-scp>, [">= 1.0.2"])
      s.add_dependency(%q<docile>, [">= 1.0.1"])
    end
  else
    s.add_dependency(%q<annoy>, [">= 0"])
    s.add_dependency(%q<sysinfo>, [">= 0.8.1"])
    s.add_dependency(%q<highline>, [">= 1.5.1"])
    s.add_dependency(%q<net-ssh>, [">= 2.0.13"])
    s.add_dependency(%q<net-scp>, [">= 1.0.2"])
    s.add_dependency(%q<docile>, [">= 1.0.1"])
  end
end
