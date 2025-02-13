i = 0
foreach conf : streflop_configurations
  new_dep = []
  if build_all
    new_dep = streflop_dep[i]
  else
    new_dep = streflop_dep
  endif

  test_execs = [
    #'arithmeticTest',
    'randomTest',
  ]
  foreach test : test_execs
    name = test + conf['suffix']
    exe = executable(name, [test + '.cpp'], dependencies: new_dep)
    test(name, exe, timeout: 120)
  endforeach
  i = i + 1
endforeach
