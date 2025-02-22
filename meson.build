project(
  'streflop-ng',
  ['cpp'],
  default_options: ['cpp_std=c++11', 'warning_level=2', 'b_staticpic=true'],
  version: '0.3.1',
  meson_version: '>= 0.64.0',
)
# The current required meson version of 0.63.0 is to prevent this error:
#
#../meson.build:163:2: ERROR: List item must be one of <class 'str'>, not <class 'list'>
# when using a list as the kwarg for compile_args in declare dependency()

host_sys = host_machine.system()
host_arch = host_machine.cpu_family()

cxx = meson.get_compiler('cpp')

extra_flags = [
  '-frounding-math',
  '-fsignaling-nans',
  '-fno-strict-aliasing',
  '-pipe',
]
if host_arch != 'aarch64'
  extra_flags += '-mieee-fp'
endif
# These are used for all the libraries but not for the tests
# and they're not added as cflags to the dependency object or
# .pc files
extra_flags = cxx.get_supported_arguments(extra_flags)

fpu_opt = get_option('fpu')
denormals = get_option('denormals')

no_denormals_def = ['-DSTREFLOP_NO_DENORMALS']
soft_defs = ['-DSTREFLOP_SOFT']
sse_defs = ['-DSTREFLOP_SSE']
x87_defs = ['-DSTREFLOP_X87']

h_subdir = meson.project_name()

streflop_configurations = [
  {
    'fpu': 'soft',
    'denormals': true,
    'suffix': '-' + 'soft',
    'flags': [],
    'defs': soft_defs,
  },
]

sse_flags = cxx.get_supported_arguments(['-msse', '-msse2', '-mfpmath=sse'])
if sse_flags != []
  streflop_configurations += [
    {
      'fpu': 'sse',
      'denormals': true,
      'suffix': '-' + 'sse',
      'flags': sse_flags,
      'defs': sse_defs,
    },
    {
      'fpu': 'sse',
      'denormals': false,
      'suffix': '-' + 'sse-nd',
      'flags': sse_flags,
      'defs': [sse_defs, no_denormals_def],
    },
  ]
endif

x87_flags = cxx.get_supported_arguments('-mfpmath=387')
if x87_flags != []
  streflop_configurations += [
    {
      'fpu': 'x87',
      'denormals': true,
      'suffix': '-' + 'x87',
      'flags': x87_flags,
      'defs': x87_defs,
    },
    {
      'fpu': 'x87',
      'denormals': false,
      'suffix': '-' + 'x87-nd',
      'flags': x87_flags,
      'defs': [x87_defs, no_denormals_def],
    },
  ]
endif

if fpu_opt != 'all'
  if (fpu_opt == 'none')
    error('You must choose an fpu option')
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
  if conf['fpu'] != fpu_opt
    error('Requested fpu/denormals combination not available')
  endif
endif

inc_dirs = include_directories('libm/headers')

subdir('libm/flt-32')
subdir('libm/dbl-64')
subdir('libm/ldbl-96')

streflop_ng = []
i = 0
ldbl96_i = 0
foreach conf : streflop_configurations
  # This was in the original streflop Makefile:
  #
  # ifndef STREFLOP_SSE
  # TARGETS += libm/ldbl-target
  # LIBM_OBJECTS += $(ldbl-96-objects)
  # endif
  ldbl96_lib = []
  if conf['fpu'] != 'sse'
    ldbl96_lib = _ldbl96_lib[ldbl96_i]
    ldbl96_i = ldbl96_i + 1
  endif

  _soft_src = []
  _softwrapper_static_libs = []
  if conf['fpu'] == 'soft'
    _soft_src += 'softfloat/softfloat.cpp'
    soft_configurations = [
      {'defs': ['-DN_SPECIALIZED=32'], 'name': 'SoftFloatWrapperSimple'},
      {'defs': ['-DN_SPECIALIZED=64'], 'name': 'SoftFloatWrapperDouble'},
      {'defs': ['-DN_SPECIALIZED=96'], 'name': 'SoftFloatWrapperExtended'},
    ]
    foreach softconf : soft_configurations
      _softwrapper_static_libs += static_library(
        softconf['name'],
        ['SoftFloatWrapper.cpp'],
        cpp_args: [extra_flags, softconf['defs'], conf['defs'], conf['flags']],
      )
    endforeach
  endif

  streflop_ng += library(
    meson.project_name() + conf['suffix'],
    ['SMath.cpp', 'Random.cpp', _soft_src],
    #version: meson.project_version(),
    cpp_args: [extra_flags, conf['flags'], conf['defs']],
    link_whole: [
      _flt32_lib[i],
      _dbl64_lib[i],
      ldbl96_lib,
      _softwrapper_static_libs,
    ],
    install: not meson.is_subproject(),
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
    include_directories: include_directories('.'),
    compile_args: [conf['defs']],
  )
  i = i + 1
endforeach

if fpu_opt != 'all'
  streflop_dep = streflop_dep[0]
endif

is_subproject = meson.is_subproject()
if not is_subproject
  subdir('tests')

  i = 0
  foreach conf : streflop_configurations
    denorm_state = conf['denormals'] ? 'denormals' : 'no denormals'
    desc = 'STREFLOP library [' + conf['fpu'] + '] [' + denorm_state + ']'
    pkg = import('pkgconfig')
    pkg.generate(
      streflop_ng[i],
      description: desc,
      subdirs: h_subdir,
      url: 'https://github.com/andy5995/streflop-ng',
      extra_cflags: conf['defs'],
    )
    i = i + 1
  endforeach
endif

if not meson.is_subproject()
  install_headers(
    ['FPUSettings.h', 'SMath.h', 'Random.h', 'SoftFloatWrapper.h', 'streflop.h'],
    subdir: h_subdir,
  )
endif

install_data(
  [
    'LICENSE',
    'README.md',
    'libm/README.txt',
    'libm/README.txt',
    'softfloat/README.txt',
    'softfloat/SoftFloat-history.txt',
    'softfloat/SoftFloat.txt',
    'softfloat/SoftFloat-source.txt',
    'softfloat/SoftFloat-README.txt',
    'ChangeLog',
  ],
  preserve_path: true,
  install_dir: get_option('docdir'),
)
