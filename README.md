# Quake Champions: Doom Edition Server in Docker

![Quake Champions: Doom Edition](https://raw.githubusercontent.com/LacledesLAN/gamesvr-qcde/refs/heads/main/Documentation/media/qcde.png)

[QC:DE](https://qcde.net/) is a mod that brings the weapons from the latest Quake game, into Doom, with delicious
pixelated flavor. More than just weapons, it also brings the “Champions” mechanic -- different player classes, each one
with unique status, speed, active and passive abilities.

This repository is maintained by [Laclede's LAN](https://lacledeslan.com). Its contents are intended to be bare-bones
and used as a stock server. For an example of building a customized server from this Docker image browse the related
child-project [gamesvr-qcde-freeplay](https://github.com/LacledesLAN/gamesvr-qcde-freeplay). If any documentation is
unclear or it has any issues please see [CONTRIBUTING.md](./CONTRIBUTING.md

## Links

* [Official Quake Champions: Doom Edition Website](https://qcde.net)
  * [QC:DE Manual](https://qcde.net/files/public/QCDE_Manual.pdf)
* QCDE is powered by [Q-Zandronum](https://qzandronum.com/) a modification of the Doom 2 engine that has Quake style
  movement.
  * *Q-Zandronum* is a fork of *Zandronum*; the [Zandronum Wiki](https://wiki.zandronum.com/Main_Page) is a good
    resource for configuration and troubleshooting.
* This server does not contain any closed-licensed assets made by *ID Software*, It uses the [Freedoom
wads](https://freedoom.github.io/download.html) that comes with the installation of *Q-Zandronum*.

## Linux

[![linux/amd64](https://github.com/LacledesLAN/gamesvr-qcde/actions/workflows/build-linux-x64.yml/badge.svg)](https://github.com/LacledesLAN/gamesvr-qcde/actions/workflows/build-linux-x64.yml)

### Run Self Tests

> TODO!

### Run Example Server

This command is case sensitive on the file names.

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec test.cfg +exec LAN.cfg;
```

### Running Game Servers

This server includes multiple configurations files. By executing these configuration, you can change the behavior and
game mode of your server:

* One for each of QC:DE'S different game modes.
* One for each networking mode:
  * `LAN.cfg` for LAN servers.
  * `INTERNET.cfg` for Internet servers.

#### Capture the Flag

In Capture The Flag (CTF), you and your team must pick up the flag from the other team's base, and carry the flag back
to your team's flag to gain a point. Not only that, but you still have to defend your team's flag, and make sure that
your flag carrier safely scores a point for the team. If the carrier dies while holding the flag, the flag will be
dropped allowing enemies to pick it up and allies to return it back to base.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-ctf.cfg +exec LAN.cfg;
```

#### Deathmatch

The classic game mode: simply shoot as many players as you see. The game ends when a player hits the frag limit, or the
time limit is reached.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-dm.cfg +exec LAN.cfg;
```

#### Domination

In Domination, there are various domination points around the map, indicated by a giant beam of light, for your teams to
capture. If nobody is controlling the point, then the light is white. To take control of the point simply walk over it
and it's yours! Every 3 seconds, your team receives 1 point for each point under your control.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-dom.cfg +exec LAN.cfg;
```

#### Duel

Duel is effectively one-on-one Deathmatch. Two players fight against each other, while other players wait in line to
play the winner. To win in a duel game, you must frag the other player until you reach the frag limit.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-duel.cfg +exec LAN.cfg;
```

#### InstaGib Deathmatch

Deathmatch where everyone spawns with a railgun, with no other items spawning. The railgun is powerful enough that in
one hit, it will instantly kill you with so much damage that you are gibbed (hence "instagib".)

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-instagib-dm.cfg +exec LAN.cfg;
```

#### Invasion

A co-operative game mode in which there are multiple increasingly difficult waves of monsters to fight.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-invasion.cfg +exec LAN.cfg;
```

#### Last Man Standing

Last Man Standing (LMS) is similar to Deathmatch, but you have a limited amount of lives, and the goal is to be the last
player alive. You receive all the weapons available, minus the BFG. In LMS, you gain points for being the last player
alive for each round.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-lms.cfg +exec LAN.cfg;
```

#### Survival Cooperative

A twist on co-operative in which each player has a set amount of lives. If you run out of lives, you can't respawn until
the next map. If everyone runs out of lives, you lose and have to start again.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-survival.cfg +exec LAN.cfg;
```

#### Team Deathmatch

Team Deathmatch takes Deathmatch and splits players into teams.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-tdm.cfg +exec LAN.cfg;
```

#### Team Last Man Standing

Team Last Man Standing (TLMS) takes the rules of Last Man Standing and applies it to a team-based gamemode: the last
team standing wins a point.

```shell
docker run -it --net=host lacledeslan/gamesvr-qcde ./q-zandronum-server -iwad freedoom2.wad -file QCDEv3.0.pk3 QCDEmaps3.0.pk3 -optfile QCDEmus3.0.pk3 +exec qcde-tlms.cfg +exec LAN.cfg;
```

## Other Consideration

### Network Port

By default, this server uses port 10666 (UDP). It can be changed by adding the `-port #####` argument to the server at
startup. But, using Docker's port mapping would be the better solution.

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-
sufficient containers. For a crash course on running Dockerized game servers check out [Using Docker for Game
Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks,
and recommended tools for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our
Game Server Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can
also browse all of our other Dockerized game servers: [Laclede's LAN Game Servers
Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
