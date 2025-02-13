project(
  'streflop-ng',
  ['cpp'],
  default_options: ['cpp_std=c++11', 'warning_level=2'],
  version: '0.3.05',
)

cxx = meson.get_compiler('cpp')

extra_flags = [
  '-frounding-math',
  '-fsignaling-nans',
  '-fno-strict-aliasing',
  '-mieee-fp',
]

#add_project_arguments(, language: 'cpp')
lib_args = cxx.get_supported_arguments(extra_flags)

sources = []

sse_flags = ['-msse', '-msse2', '-mfpmath=sse']
sse_defs = ['-DSTREFLOP_SSE']
x87_flags = ['-mfpmath=387']
x87_defs = ['-DSTREFLOP_X87']
soft_defs = ['-DSTREFLOP_SOFT']
no_denormals_def = ['-DSTREFLOP_NO_DENORMALS']
flags = []
fpu_def = []
fpu_opt = get_option('fpu')
if fpu_opt == 'x87'
  fpu_def = x87_defs
  flags += x87_flags
endif
if fpu_opt == 'sse'
  fpu_def = sse_defs
  flags += sse_flags
endif
if fpu_opt == 'soft'
  fpu_def = soft_defs
endif
denormals = get_option('denormals')
if denormals
  no_denormals_def = []
endif
lib_args += cxx.get_supported_arguments([flags])
lib_args += [fpu_def, no_denormals_def]

streflop_configurations = [
  {
    'fpu': 'sse',
    'denormals': true,
    'suffix': '_' + 'sse',
    'flags': sse_flags,
    'defs': sse_defs,
  },
  {
    'fpu': 'sse',
    'denormals': false,
    'suffix': '_' + 'sse_nd',
    'flags': sse_flags,
    'defs': [sse_defs, no_denormals_def],
  },
  {
    'fpu': 'x87',
    'denormals': true,
    'suffix': '_' + 'x87',
    'flags': x87_flags,
    'defs': x87_defs,
  },
  {
    'fpu': 'x87',
    'denormals': false,
    'suffix': '_' + 'x87_nd',
    'flags': x87_flags,
    'defs': [x87_defs, no_denormals_def],
  },
  {
    'fpu': 'soft',
    'denormals': true,
    'suffix': '_' + 'soft',
    'flags': [],
    'defs': soft_defs,
  },
]

build_all = get_option('build_all')

if not build_all
  if (fpu_opt == 'none')
    error('You must choose an fpu or set build_all to true')
  endif
  foreach conf : streflop_configurations
    if conf['fpu'] == fpu_opt and conf['denormals'] == denormals
      streflop_configurations = [
        {
          'fpu': conf['fpu'],
          'denormals': conf['denormals'],
          'suffix': conf['suffix'],
          'flags': conf['flags'],
          'defs': conf['defs'],
        },
      ]
      break
    endif
  endforeach
else
  if fpu_opt != 'none'
    message('fpu option ignored, build_all is true')
  endif
endif

_softwrapper_static_libs = []
foreach conf : streflop_configurations
  if conf['fpu'] == 'soft'
    configurations = [
      {'defs': ['-DN_SPECIALIZED=32'], 'name': 'SoftFloatWrapperSimple'},
      {'defs': ['-DN_SPECIALIZED=64'], 'name': 'SoftFloatWrapperDouble'},
      {'defs': ['-DN_SPECIALIZED=96'], 'name': 'SoftFloatWrapperExtended'},
    ]
    foreach softconf : configurations
      _softwrapper_static_libs += static_library(
        softconf['name'],
        ['SoftFloatWrapper.cpp', 'softfloat/softfloat.cpp'],
        # include_directories: '.',
        cpp_args: [softconf['defs'], conf['defs'], conf['flags']],
      )
    endforeach
  else
    _softwrapper_static_libs = []
  endif
endforeach

incdir = include_directories('libm')

sources += ['Math.cpp', 'Random.cpp']

_internal_libs = [0,0,0,0,0]

subdir('libm')

streflop_ng = []
i = 0
ldbl96_i = 0
foreach conf : streflop_configurations
  ldbl96_lib = []
  if conf['fpu'] != 'sse'
    ldbl96_lib = _ldbl96_lib[ldbl96_i]
    ldbl96_i = ldbl96_i + 1
  endif
  streflop_ng += library(
    meson.project_name() + conf['suffix'],
    [sources],
    version: meson.project_version(),
    include_directories: incdir,
    cpp_args: [conf['flags'], conf['defs']],
    link_with: [
      _flt32_lib[i],
      _dbl64_lib[i],
      ldbl96_lib,
      _libm[i],
      _softwrapper_static_libs,
    ],
    # install: not meson.is_subproject(),
    install: false,
    pic: true,
  )
  i = i + 1
endforeach

streflop_dep = []
i = 0
foreach conf : streflop_configurations
  # How to use in a superproject and other info
  # https://mesonbuild.com/Subprojects.html
  streflop_dep += declare_dependency(
    link_with: streflop_ng[i],
    include_directories: '.',
    compile_args: [conf['defs']],
  )
  i = i + 1
endforeach

if not build_all
  streflop_dep = streflop_dep[0]
endif

is_subproject = meson.is_subproject()
if not is_subproject
  subdir('tests')

  i = 0
  foreach conf : streflop_configurations
    if denormals
      denorm_state = 'denormals'
    else
      denorm_state = 'no denormals'
    endif
    desc = 'STREFLOP library [' + conf['fpu'] + '] [' + denorm_state + ']'
    pkg = import('pkgconfig')
    pkg.generate(
      streflop_ng[i],
      description: desc,
      url: 'https://github.com/andy5995/streflop-ng',
      extra_cflags: [conf['defs'], no_denormals_def],
    )
    i = i + 1
  endforeach
endif

# TODO: Installation of libraries, headers and docs
#
#headers = [
#  'FPUSettings.h',
#  'IntegerTypes.h',
#  'Math.h',
#  'Random.h',
#  'SoftFloatWrapper.h',
#  'streflop.h',
#  'System.h',
#  'X87DenormalSquasher.h',
#]

#if not meson.is_subproject()
#  install_headers(
#    ['FPUSettings.h', 'Math.h', 'Random.h', 'SoftFloatWrapper.h', 'streflop.h'],
#    subdir: 'streflop',
#  )
#endif
