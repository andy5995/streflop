
_libm = []
foreach conf : streflop_configurations
  _libm += static_library(
    'libm' + conf['suffix'],
    ['e_expf.cpp', 'w_expf.cpp'],
    include_directories: ['headers', incdir],
    cpp_args: ['-DLIBM_COMPILING_FLT32', conf['flags'], conf['defs']],
    pic: true,
  )
endforeach

subdir('flt-32')
subdir('dbl-64')

_ldbl96_lib = []
if fpu_opt != 'sse'
  subdir('ldbl-96')
endif

