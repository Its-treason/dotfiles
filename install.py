import os

home = os.path.expanduser("~") + '/'
workDir = os.path.dirname(os.path.realpath(__file__)) + '/'

# all the files that need to be copied, first is the source second is the destination
files = [
    [
        workDir + 'config/compton.conf',
        home + '.config/compton.conf'
    ],
    [
        workDir + 'config/i3/config',
        home + '.config/i3/config'
    ],
    [
        workDir + 'config/polybar/cal.sh',
        home + '.config/polybar/cal.sh'
    ],
    [
        workDir + 'config/polybar/config',
        home + '.config/polybar/config'
    ],
    [
        workDir + 'config/polybar/launch.sh',
        home + '.config/polybar/launch.sh'
    ],
    [
        workDir + 'config/polybar/power_menu.sh',
        home + '.config/polybar/power_menu.sh'
    ],
    [
        workDir + 'config/terminator/config',
        home + '.config/terminator/config'
    ],
    [
        workDir + 'config/terminator/config',
        home + '.config/terminator/config'
    ],
    [
        workDir + 'config/wal/templates/dunstrc',
        home + '.config/wal/templates/dunstrc'
    ],
    [
        workDir + 'config/wal/templates/power.rasi',
        home + '.config/wal/templates/power.rasi'
    ],
    [
        workDir + 'config/wal/templates/run.rasi',
        home + '.config/wal/templates/run.rasi'
    ],
    [
        workDir + 'config/wal/templates/theme.conf',
        home + '.config/wal/templates/theme.conf'
    ],
]

for file in files:
    # if path to file does not exists create it, this splitty thing just remove the file name at the end

    if not os.path.exists('/'.join(file[1].split('/')[:-1])):
        os.makedirs('/'.join(file[1].split('/')[:-1]))

    if os.path.exists(file[1]):
        os.remove(file[1])

    os.symlink(file[0], file[1])
