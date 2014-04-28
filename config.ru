$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'app/api/v1'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'app/services'))

require 'survival_pack'

run Workr::V1::SurvivalPack