breed [greeks greek]
breed [persians persian]
breed [ships ship]

globals [
  turtle-troop-size
  greek-starting-points-right
  greek-starting-points-center
  greek-starting-points-left
  persian-starting-points
  weapon-type-for-center-greeks
  number-of-persian-ships
  persian-ship-starting-points
  persian-soldier-count
  ;persian-retreat-initiated?
  ;persian-retreat-counter
  greek-soldiers-alive
  greek-soldiers-dead
  persian-soldiers-alive
  persian-soldiers-dead
  greek-left-soldiers-dead-count
  greek-center-soldiers-dead-count
  greek-right-soldiers-dead-count
  greek-soldiers-dead-count
  persian-soldiers-dead-count
  greeks-dead-count
  persians-dead-count
  greek-soldiers-alive-count
  persian-soldiers-alive-count
  current-date-time
  ;time-of-day
  minutes-per-tick
]

greeks-own [
  weapon
  armour-type
  base-health
  attack-range
  dead-flag
]

persians-own [
  weapon
  armour-type
  base-health
  attack-range
  dead-flag
]

extensions [time]

; Initialize the simulation environment
to setup
  clear-all
  import-pcolors "BoM_Test_Image.png"
  set current-date-time time:create "1863/07/01 5:30"
  set time-of-day "5:30 AM"
  set minutes-per-tick 1

  set turtle-troop-size 1

  set greek-soldiers-alive 0
  set greek-soldiers-dead 0
  set persian-soldiers-alive 0
  set persian-soldiers-dead 0

  ; Create Greek soldiers on the right
  set greek-starting-points-right patches at-points [
     [11 34] [12 34] [13 34] ;[14 34] ;[15 34] [16 34] [17 34]
    [11 33] [12 33] [13 33] ;[14 33]; [15 33] [16 33] [17 33]
    [11 32] [12 32] [13 32] ;[14 32]; [15 32] [16 32] [17 32]
    [11 31] [12 31] [13 31] ;[14 31] ;[15 31] [16 31] [17 31]
    [11 30] [12 30] [13 30] ;[14 30] ;[15 30] [16 30] [17 30]
    [11 29] [12 29] [13 29] ; [14 29] [15 29] [16 29] [17 29]
   [11 28] [12 28] [13 28] ;[14 28] [15 28] [16 28] [17 28]
  ]


  ; Create Greek soldiers in the center
  set greek-starting-points-center patches at-points [
            [15 29] [16 29]
    [14 29] [15 29] [16 29] [17 29] ;[19 31]
    [14 28] [15 28] [16 28] [17 28]
  ]

  ; Create Greek soldiers on the left
  set greek-starting-points-left patches at-points [
     [18 34] [19 34] [20 34] ;[23 34];[30 34] [31 34]
     [18 33] [19 33] [20 33] ;[23 33]; [30 33] [31 33]
     [18 32] [19 32] [20 32]; [23 32]; [30 32] [31 32]
     [18 31] [19 31] [20 31]; [23 31];[30 31] [31 31]
     [18 30] [19 30] [20 30] ;[23 30];[29 30] [30 30] [31 30]
     [18 29] [19 29] [20 29]
     [18 28] [19 28] [20 28]
  ]

  ; Create Persian soldiers with starting points
  set persian-starting-points patches at-points [
     [11 19] [12 19] [13 19] [14 19] [15 19] [16 19] [17 19] [18 19] [19 19] [20 19] ;[21 19] [22 19] [23 19] [24 19] [25 19] [26 19] [27 19] [28 19] [29 19] [30 19] [31 19]
    [11 20] [12 20] [13 20] [14 20] [15 20] [16 20] [17 20] [18 20] [19 20] [20 20] ;[21 20] [22 20] [23 20] [24 20] [25 20] [26 20] [27 20] [28 20] [29 20] [30 20] [31 20]
    [11 21] [12 21] [13 21] [14 21] [15 21] [16 21] [17 21] [18 21] [19 21] [20 21] ;[21 21] [22 21] [23 21] [24 21] [25 21] [26 21] [27 21] [28 21] [29 21] [30 21] [31 21]
    [11 22] [12 22] [13 22] [14 22] [15 22] [16 22] [17 22] [18 22] [19 22] [20 22] ;[21 22] [22 22] [23 22] [24 22] [25 22] [26 22] [27 22] [28 22] [29 22] [30 22] [31 22]
    [11 23] [12 23] [13 23] [14 23] [15 23] [16 23] [17 23] [18 23] [19 23] [20 23]; [21 23] [22 23] [23 23] [24 23] [25 23] [26 23] [27 23] [28 23] [29 23] [30 23] [31 23]
   [11 24] [12 24] [13 24] [14 24] [15 24] [16 24] [17 24] [18 24] [19 24] [20 24] ;[21 24] [22 24] [23 24] [24 24] [25 24] [26 24] [27 24] [28 24] [29 24] [30 24] [31 24]
    [11 25] [12 25] [13 25] [14 25] [15 25] [16 25] [17 25] [18 25] [19 25] [20 25]
  ]

  ; Create Persian ships with starting points
  set persian-ship-starting-points patches at-points [
    [24 12] [28 12] [32 12] [36 12] [42 12] ; Example ship starting points
    [12 10] [16 10] [20 10] [24 10] [28 10]
  ]

    ; Set the initial number of soldiers directly
  ; Set the number of Greek and Persian soldiers

  set number-of-left-greek-soldiers (number-of-left-greek-soldiers / turtle-troop-size)
  set number-of-center-greek-soldiers (number-of-center-greek-soldiers / turtle-troop-size)
  set number-of-right-greek-soldiers (number-of-right-greek-soldiers / turtle-troop-size)
  set number-of-persian-soldiers (number-of-persian-soldiers / turtle-troop-size)

  create-greeks number-of-left-greek-soldiers [
    set shape "person"
    set weapon one-of ["spear" "sword"]
    set armour-type 7
    set base-health 100 + armour-type
    set color yellow
  ]

  set weapon-type-for-center-greeks "sword"  ; Specify the weapon type for center-Greek soldiers

  create-greeks number-of-center-greek-soldiers [
    set shape "person"
    set weapon weapon-type-for-center-greeks
    ;set weapon one-of ["spear" "sword"]
    set armour-type 7
    set base-health 100 + armour-type
    set color yellow
  ]
    create-greeks number-of-right-greek-soldiers [
    set shape "person"
    set weapon one-of ["spear" "sword"]
    set armour-type 7
    set base-health 100 + armour-type
    set color yellow
  ]

  create-persians number-of-persian-soldiers  [
    set shape "person"
    set weapon one-of ["arrow" "spear" "dagger"]
    set armour-type 4
    set base-health 100 + armour-type
    set color red
  ]

    ; Print the count of greeks and persians
  output-print (word "Initial Persians Line-up: " count persians)
  output-print (word "Initial Greeks Line-up: " count Greeks)

  reset-ticks
  turtle-troop-sizes; Call the set-troop-sizes procedure initially
end

to turtle-troop-sizes
  ; Move turtles to their starting points
  ask greeks [
    if member? self greeks-left [
      move-to one-of greek-starting-points-left
    ]
    if member? self greeks-center [
      move-to one-of greek-starting-points-center
    ]
    if member? self greeks-right [
      move-to one-of greek-starting-points-right
    ]
  ]

  ask persians [
    move-to one-of persian-starting-points
  ]


end


to-report greeks-left
  report n-of (min list number-of-left-greek-soldiers count greeks) greeks
end

to-report greeks-center
  report n-of (min list number-of-center-greek-soldiers count greeks) greeks
end

to-report greeks-right
  report n-of (min list number-of-right-greek-soldiers count greeks) greeks
end

; run the simulation
to go
  ; Move Greeks and let them attack

  ask greeks [
    let target min-one-of persians [distance myself]
    if target != nobody [
      face target
      forward 1
      ; Check hit probability
      if random 100 < 80 [  ; Greeks have a 70% chance to hit
        attack self target
      ]
    ]

    ; Check for nearby enemy Greeks and attack
    let nearby-enemies other greeks in-radius 1
    if any? nearby-enemies [
      let enemy min-one-of nearby-enemies [distance myself]
      ; Check hit probability
      if random 100 < 20 [  ; Greeks have a 80% chance to hit
        attack self enemy
      ]
    ]

    ; Greek center soldiers move backward
    if member? self greeks-center [
      set ycor ycor - 1  ; Move backward by decrementing the y-coordinate
    ]
  ]
  ; Move Persians and let them attack
  ask persians [
    let target min-one-of greeks [distance myself]
    if target != nobody [
      face target
      forward 1
      ; Check hit probability
      if random 100 < 50 [  ; Persians have a 50% chance to hit
        attack self target
      ]
    ]

    ; Check for nearby enemy Persians and attack
    let nearby-enemies other persians in-radius 1
    if any? nearby-enemies [
      let enemy min-one-of nearby-enemies [distance myself]
      ; Check hit probability
      if random 100 < 50 [  ; Persians have a 50% chance to hit
        attack self enemy
      ]
    ]
  ]
  ; Move the enemies towards each other
  ask greeks [
    let nearest-persian min-one-of persians [distance myself]
    if nearest-persian != nobody [
      face nearest-persian
      forward 1
    ]
  ]
  ask persians [
    let nearest-greek min-one-of greeks [distance myself]
    if nearest-greek != nobody [
      face nearest-greek
      forward 1
    ]
  ]

  turtle-troop-sizes  ; Call the set-troop-sizes procedure in each tick
  ; Print the number of soldiers for Persians and Greeks left after each tick
  output-print (word "Persians left: " count persians)
  output-print (word "Greeks left: " count greeks)
  set greek-soldiers-dead-count ((number-of-left-greek-soldiers + number-of-center-greek-soldiers + number-of-right-greek-soldiers) - count greeks-alive )
  set persian-soldiers-dead-count (number-of-persian-soldiers - count persians-alive)

  ; Print the counts
  output-print (word "Greek Soldiers Alive: " greek-soldiers-alive)
  output-print (word "Greek Soldiers Dead: " greek-soldiers-dead-count)
  output-print (word "Persian Soldiers Alive: " persian-soldiers-alive)
  output-print (word "Persian Soldiers Dead: " persian-soldiers-dead-count)

  ; Update the counters for alive and dead soldiers
  set greek-soldiers-alive count greeks with [base-health > 0]
  set greek-soldiers-dead count greeks with [dead-flag = true]
  set greek-soldiers-alive-count greek-soldiers-alive
  
  set persian-soldiers-alive count persians with [base-health > 0]
  set persian-soldiers-dead count persians with [dead-flag = true]
  set persian-soldiers-alive-count persian-soldiers-alive
  
  set current-date-time time:plus current-date-time minutes-per-tick "minutes"
  set time-of-day time:show current-date-time "hh:mm a"
  
  tick
  ; Check if the battle has reached the time limit (3 hours)
  if ticks >= 180 [
    stop
    output-print print-winner
  ]
end
; Define the attack procedure
to attack [attacker target]
  ; Perform attack only if the target is within attack range
  let attacker-range [attack-range] of attacker  ; Save the attacker's range in a local variable
  if distance target <= attacker-range [  ; Use the local variable for the distance check
    let damage-inflicted (weapon-strength [weapon] of attacker) - ([armour-type] of target)
    if damage-inflicted > 0 [
    ask target [
      set base-health base-health - damage-inflicted
      if base-health <= 0 [
        set base-health 0 ; Ensure health is not negative
        set dead-flag true ; Set the dead flag
        die ; Remove the soldier from the environment
        if breed = greeks [
          set greeks-dead-count greeks-dead-count + 1
        ]
        if breed = persians [
          set persians-dead-count persians-dead-count + 1
        ]
      ]
    ]
  ]
  ]
     
end

to-report print-winner
  ; Determine the winner based on the number of casualties
  ; If 70% of the initial Greek soldiers are dead, Persians win
  ; If 70% of the initial Persian soldiers are dead, Greeks win
  ; Returns the winner's name or "Draw" if both sides have casualties below the threshold
  let greek-casualties round(0.7 * number-of-left-greek-soldiers)
  let persian-casualties round(0.4 * number-of-left-greek-soldiers)

  if (greek-soldiers-dead-count >= greek-casualties) [
    output-print "Persians win the battle!"
    report "Persians"
  ] if (persian-soldiers-dead-count >= persian-casualties) [
    output-print "Greeks win the battle!"
    report "Greeks"
  ] if ( greek-casualties = persian-casualties)[
    output-print "The battle ends in a draw!"
    report "Draw"
  ]
end

to-report greeks-dead
  report count greeks with [dead-flag = true]
end

to-report persians-dead
  report count persians with [dead-flag = true]
end

to-report greeks-alive
  report greeks with [base-health > 0]
end

to-report persians-alive
  report persians with [base-health > 0]
end

; Calculate the strength of the weapon based on its type and the breed
to-report weapon-strength [weapon-type]
  ifelse breed = greeks [
    ifelse weapon-type = "spear" [
      report 10
    ] [
      ifelse weapon-type = "sword" [
        report 8
      ] [
        report 0  ; default case if no match for Greeks
      ]
    ]
  ] [
    ifelse weapon-type = "arrow" [
      report 6
    ] [
      ifelse weapon-type = "spear" [
        report 8
      ] [
        ifelse weapon-type = "dagger" [
          report 7
        ] [
          report 0  ; default case if no match for Persians
        ]
      ]
    ]
  ]
end