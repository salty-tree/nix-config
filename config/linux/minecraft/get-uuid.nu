#!/usr/bin/env nu

def main [...usernames: string] {
    $usernames
    | each {|name|
        let resp = http get $"https://playerdb.co/api/player/minecraft/($name)" -e;
        if $resp.success {
            print $"($name) : ($resp.data.player.id)"
            {name: $name, uuid: $resp.data.player.id}
        } else {
            print $"($name) not found"
        }
    } | collect | save whitelist.json -f
}
