require 'json'
require 'securerandom'

mcdir = "#{ENV['HOME']}/Library/Application Support/minecraft"
profiles = "#{mcdir}/launcher_profiles.json"

name = ARGV[0]
versionId = ARGV[1]
gameDir = ARGV[2]

if !File.exists?(profiles)
    puts('マインクラフトを起動してから、再度実行してください。')
    exit(1)
end

data = JSON.load(File.open(profiles).read)
data['profiles'][SecureRandom.uuid.gsub(/-/, '')] = {
    'name': name,
    'type': 'custom',
    'created': Time.now().strftime('%FT%T.%3NZ'),
    'lastUsed': Time.now().strftime('%FT%T.%3NZ'),
    'lastVersionId': versionId,
    'gameDir': gameDir
}

File.open(profiles, 'w') do |f|
    f.write( JSON.pretty_generate(data))
end
