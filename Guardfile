# More info at https://github.com/guard/guard#readme

guard :minitest do
  watch(%r{^test/test_(.*)\.rb$})
  watch(%r{^lib/raindrop_io/(.*)\.rb$}) { |m| "test/test_raindrop_#{m[1]}.rb" }
  watch(%r{^test/test_helper\.rb$})
  watch(%r{^test/test_helper\.rb$}) { "test" }
end

guard :standardrb, fix: true, all_on_start: true do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.?[^/]+$}) { |m| File.dirname(m[0]) }
end

guard :yard, server: false, stdout: "log/yard.log", stderr: "log/yard.log", cli: "--quiet" do
  watch(%r{^lib/.+\.rb$})
  watch("README.md")
end
