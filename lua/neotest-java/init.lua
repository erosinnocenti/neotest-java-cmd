-- current dir
local FileChecker = require('neotest-java.core.file_checker')
local RootFinder = require('neotest-java.core.root_finder')
local DirFilter = require('neotest-java.core.dir_filter')
local PositionsDiscoverer = require('neotest-java.core.positions_discoverer')
local SpecBuilder = require('neotest-java.core.spec_builder')

---@class neotest.Adapter
---@field name string
NeotestJavaAdapter = {name = 'neotest-java'}

  ---Find the project root directory given a current directory to work from.
  ---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
  ---@async
  ---@param dir string @Directory to treat as cwd
  ---@return string | nil @Absolute root dir of test suite
  function NeotestJavaAdapter.root(dir)
    return RootFinder.findRoot(dir)
  end

  ---Filter directories when searching for test files
  ---@async
  ---@param name string Name of directory
  ---@param rel_path string Path to directory, relative to root
  ---@param root string Root directory of project
  ---@return boolean
  function NeotestJavaAdapter.filter_dir(name, rel_path, root)
    return DirFilter.filter_dir(name, rel_path, root)
  end

  ---@async
  ---@param file_path string
  ---@return boolean
  function NeotestJavaAdapter.is_test_file(file_path)
    return FileChecker.isTestFile(file_path)
  end

  ---Given a file path, parse all the tests within it.
  ---@async
  ---@param file_path string Absolute file path
  ---@return neotest.Tree | nil
  function NeotestJavaAdapter.discover_positions(file_path)
    return PositionsDiscoverer:discover_positions(file_path)
  end

  ---@param args neotest.RunArgs
  ---@return nil | neotest.RunSpec | neotest.RunSpec[]
  function NeotestJavaAdapter.build_spec(args)
    return SpecBuilder.build_spec(args)
  end

  ---@async
  ---@param spec neotest.RunSpec
  ---@param result neotest.StrategyResult
  ---@param tree neotest.Tree
  ---@return table<string, neotest.Result>
  function NeotestJavaAdapter.results(spec, result, tree) end


return NeotestJavaAdapter
