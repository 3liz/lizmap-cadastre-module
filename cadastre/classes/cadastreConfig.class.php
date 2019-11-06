<?php
/**
* @package   lizmap
* @subpackage cadastre
* @author    Michael Douchin
* @copyright 2019 3liz
* @link      http://3liz.com
* @license    Mozilla Public Licence
*/

class cadastreConfig {

    /**
    * Get the cadastre config
    * @param project Project key
    * @param repository Repository key
    * @return The cadastre config or null
    */
    public static function get($repository, $project) {
        $p = lizmap::getProject($repository.'~'.$project);
        if ($p) {
            $request = new lizmapCadastreRequest(
                $p,
                array(
                    'service'=>'CADASTRE',
                    'request'=>'GetCapabilities'
                )
            );
            $result = $request->process();
            if ($result->code === 200 && $result->mime !== 'text/xml'){
                $data = json_decode($result->data);
                if ($data->status == 'success') {
                    return $data->data;
                }
            }
        }
        return Null;
    }

}
