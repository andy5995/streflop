libm_src = files('e_expf.cpp', 'w_expf.cpp')
_libm_static_libs = []

foreach conf : streflop_configurations
  _libm_static_libs += static_library(
    'libm' + conf['suffix'],
    ['e_expf.cpp', 'w_expf.cpp'],
    include_directories: [inc_dirs],
    cpp_args: ['-DLIBM_COMPILING_FLT32', conf['flags'], conf['defs']],
    pic: true,
  )
endforeach

#foreach conf : streflop_configurations
#  libm_configurations = [
#    {'defs': ['-DLIBM_COMPILING_FLT32'], 'name': 'libmflt32'},
#    {'defs': ['-DLIBM_COMPILING_DBL64'], 'name': 'libmdbl64'},
#  ]
#  if conf['fpu'] != 'sse'
#    libm_configurations += [
#      {'defs': ['-DLIBM_COMPILING_LDBL96'], 'name': 'libmldbl96'},
#    ]
#  endif
#  _libm_objects = []
#  foreach libmconf : libm_configurations
#    _libm_objects += static_library(
#      libmconf['name'] + conf['suffix'],
#      libm_src,
#      cpp_args: [libmconf['defs'], conf['defs'], conf['flags']],
#      include_directories: [inc_dirs, 'headers'],
#    )
#  endforeach
#  _libm_static_libs += _libm_objects
#endforeach

subdir('flt-32')
subdir('dbl-64')
subdir('ldbl-96')
