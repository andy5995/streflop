i = 0
foreach conf : streflop_configurations
  test_execs = [
    # 'arithmeticTest',
    'randomTest',
  ]
  foreach test : test_execs
    name = test + conf['suffix']
    exe = executable(name, [test + '.cpp'], dependencies: streflop_dep[i])
    test(name, exe, timeout: 120)
  endforeach
  i = i + 1
endforeach
