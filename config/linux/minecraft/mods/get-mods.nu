#!/usr/bin/env nu

def main [mc_version: string, ...mods: string] {
    let api_url = "https://api.modrinth.com/v2";
    let data_file = "modrinth-mods.json";
    let mc_versions = [
        $mc_version
    ];
    let loader = "fabric";

    let query = {
        loaders: ([$loader] | to json -r)
        game_versions: ($mc_versions | to json -r)
    } | url build-query;

    let mod_versions = $mods
        | each {
            let url = $"($api_url)/project/($in)/version?($query)";
            print $"Fetching project ($in)";
            http get $url
        }
        | wrap versions;
    let mod_data = $mods | wrap name | merge $mod_versions;

    let data = open $data_file;

    let new = $mc_versions
        | each {|ver|
            print $"Updating entries for ($ver)"
            let new = $mod_data | filter-versions $ver;
            {version: $ver, mods: ($data | get -o $ver | default {} | merge $new)}
        }
        | transpose -rd;

    $data
        | merge $new
        | collect
        | save -f $data_file;
}

def filter-versions [target: string] {
    $in | each {|mod|
            #| sort-by -r {$in.version_type == "release"}
            #| sort-by -r version_number
        let found = $mod.versions
            | filter {$target in $in.game_versions}
            | get 0?.files.0;
        if $found != null {
            let v = {url: $found.url, sha512: $found.hashes.sha512};
            {name: $mod.name, version: $v}
        } else {
            print $"Version for ($mod.name)/($target) not found";
        }
    } | transpose -rd
}
