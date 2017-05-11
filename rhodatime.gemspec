Gem::Specification.new do |s|
  s.name        = 'rhodatime'
  s.version     = '0.0.1'
  s.licenses    = ['MIT']
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.summary     = "A time library for Ruby."
  s.description = "A time library for Ruby."
  s.authors     = ["Andrew Violette"]
  s.email       = 'aviolette@gmail.com'
  s.files       = %w{README.md Rakefile rhodatime.gemspec} + Dir.glob("{lib,test}/**/*")
  s.homepage    = 'https://rubygems.org/gems/rhodatime'
end
