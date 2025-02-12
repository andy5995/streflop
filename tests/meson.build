i = 0
foreach conf : streflop_configurations
  test_execs = [
    # 'arithmeticTest',
    'randomTest',
  ]
  foreach test : test_execs
    name = test + conf['suffix']
    exe = executable(
      name,
      test + '.cpp',
      link_with: streflop_ng[i],
      include_directories: '..',
      cpp_args: [conf['defs']],
    )
    test(name, exe, timeout: 90)
  endforeach
  i = i + 1
endforeach
