globals [
  greek-soldiers
  persian-main-soldiers
  persian-archers
  greek-spear-soldiers
  greek-sword-soldiers
  greek-armour-type
  persian-armour-type
  hit-probability
  greek-spear-weapon
  greek-sword-weapon
  persian-spear-weapon
  persian-dagger-weapon
  persian-archer-weapon
]

breed [greeks greek]
breed [persian-main-soldiers persian-main]
breed [persian-archers persian-archer]
breed [custom-turtles custom-turtle]

greeks-own [
  armour_type
  base_health
  health
  weapon
]

persian-main-own [
  armour_type
  base_health
  health
  weapon
]

persian-archer-own [
  armour_type
  base_health
  health
  weapon
]

to setup
  clear-all
  set greek-soldiers 100
  set persian-main-soldiers 450
  set persian-archers 50
  set greek-spear-soldiers 50
  set greek-sword-soldiers 50
  set greek-armour-type 5
  set persian-armour-type 2
  set hit-probability 0.5
  
  ; Define weapon types
  set greek-spear-weapon "Spear"
  set greek-sword-weapon "Sword"
  set persian-spear-weapon "Spear"
  set persian-dagger-weapon "Dagger"
  set persian-archer-weapon "Arrow"
  
  import-pcolors "netlogo_patch.png"
  create-soldiers
  create-turtles-based-on-colors yellow 35
  create-turtles-based-on-colors red 450
  create-turtles-based-on-colors red 50
  create-turtles-based-on-colors yellow 35
  create-turtles-based-on-colors yellow 30
  reset-ticks
end

to create-soldiers
  create-greeks greek-soldiers [
    setxy random-xcor random-ycor
    set armour_type greek-armour-type
    set base_health 100 + armour_type
    set health base_health
    set weapon one-of [greek-spear-weapon greek-sword-weapon]
  ]
  
  create-persian-main-soldiers persian-main-soldiers [
    setxy random-xcor random-ycor
    set armour_type persian-armour-type
    set base_health 100 + armour_type
    set health base_health
    set weapon one-of [persian-spear-weapon persian-dagger-weapon]
  ]
  
  create-persian-archers persian-archers [
    setxy random-xcor random-ycor
    set armour_type persian-armour-type
    set base_health 100 + armour_type
    set health base_health
    set weapon persian-archer-weapon
  ]
  
  create-greek-spear-soldiers greek-spear-soldiers [
    setxy random-xcor random-ycor
    set armour_type greek-armour-type
    set base_health 100 + armour_type
    set health base_health
    set weapon greek-spear-weapon
  ]
  
  create-greek-sword-soldiers greek-sword-soldiers [
    setxy random-xcor random-ycor
    set armour_type greek-armour-type
    set base_health 100 + armour_type
    set health base_health
    set weapon greek-sword-weapon
  ]
end

to attack
  if ticks = 10 [
    ask greeks [
      set heading 90
      fd 1
    ]
    ask persianmainsoldiers [
      set heading 270
      fd 1
    ]
  ]
  
  ask greeks [
    ifelse random-float 1.0 < hit-probability [
      let damage-inflicted 0
      ifelse (weapon = "Spear") [
        set damage-inflicted 15
      ] [
        set damage-inflicted 20
      ]
      let target-persian one-of (persianmainsoldiers with [health > 0]) in-cone 1 180
      if target-persian != nobody [
        ask target-persian [
          set health (health - damage-inflicted)
        ]
      ]
    ] [
      ; Optional: Add code here for what to do if the Greek misses
    ]
    if health <= 0 [
      die
    ]
  ]
  
  ask persianmainsoldiers [
    ifelse random-float 1.0 < 0.2 [
      let damage-inflicted 0
      ifelse (weapon = "Spear") [
        set damage-inflicted 15
      ] [
        set damage-inflicted 10
      ]
      let target-greek one-of (greeks with [health > 0]) in-cone 1 180
      if target-greek != nobody [
        ask target-greek [
          set health (health - damage-inflicted)
        ]
      ]
    ] [
      ; Optional: Add code here for what to do if the Persian misses
    ]
    if health <= 0 [
      die
    ]
  ]
  
  ask persianarchers [
    ifelse random-float 1.0 < 0.3 [
      let target-greek one-of (greeks with [health > 0]) in-cone 1 180
      if target-greek != nobody [
        ask target-greek [
          set health (health - 10)
        ]
      ]
    ] [
      ; Optional: Add code here for what to do if the Persian archer misses
    ]
    if health <= 0 [
      die
    ]
  ]
  
  ask greek-spear-soldiers [
    ifelse random-float 1.0 < hit-probability [
      let target-persian one-of (persianmainsoldiers with [health > 0]) in-cone 1 180
      if target-persian != nobody [
        ask target-persian [
          set health (health - 15)
        ]
      ]
    ] [
      ; Optional: Add code here for what to do if the Greek spear soldier misses
    ]
  ]
  
  ask greek-sword-soldiers [
    ifelse random-float 1.0 < hit-probability [
      let target-persian one-of (persianmainsoldiers with [health > 0]) in-cone 1 180
      if target-persian != nobody [
        ask target-persian [
          set health (health - 20)
        ]
      ]
    ] [
      ; Optional: Add code here for what to do if the Greek sword soldier misses
    ]
  ]
  
  if (count greeks = 0 or count persianmainsoldiers = 0) and (count persianarchers = 0) [
    stop
  ]
  
  tick
end
