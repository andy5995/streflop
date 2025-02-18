i = 0
foreach conf : streflop_configurations
  new_dep = fpu_opt.contains('all') ? streflop_dep[i] : streflop_dep
  test_execs = [
    'arithmeticTest',
]
  if conf['fpu'] != 'soft'
  #  test_execs += 'randomTest'
  endif
  foreach test : test_execs
    name = test + conf['suffix']
    exe = executable(name, [test + '.cpp'], dependencies: new_dep)
    test(name, exe, args: name, timeout: 180)
  endforeach
  i = i + 1
endforeach
