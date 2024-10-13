Config = {
    framework = 'lxr-core',  -- Default framework, can be changed to 'qbr-core' or 'rsg-core'

    escape = {
        active = true,
        lotonumb = {5, 6, 20},  -- List of numbers between 0-5000 that when matched will remove a player's blindfold
        button = 0x760A9C6F,    -- Button to attempt to escape
        lang = {
            escape = 'Attempt to Break Blindfold',
            button = 'G'
        }
    },

    lang = {
        noplayers = "No players nearby",
        noitem = "You are out of blindfolds"
    },

    blindfoldcommand = true,
    blindfoldselfcommand = true,
    blindfolditem = true
}
