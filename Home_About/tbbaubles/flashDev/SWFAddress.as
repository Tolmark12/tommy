/**
 * SWFAddress v1.1: Deep linking for Flash - http://www.asual.com/swfaddress/
 * 
 * SWFAddress is (c) 2006 Rostislav Hristov and is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */

import flash.external.*;

class SWFAddress {

    private static var _value:String = '';
    private static var _interval:Number;
    private static var _availability:Boolean = ExternalInterface.available;
    private static var _init = SWFAddress._initialize();

    public static var onChange:Function;
    
    private static function _check():Void {
        if (SWFAddress.onChange) {
            clearInterval(SWFAddress._interval);
            SWFAddress.setValue(SWFAddress.getValue());
        }
    }

    private static function _initialize():Void {
        SWFAddress._interval = setInterval(SWFAddress._check, 10);
        if (_availability) {
            ExternalInterface.addCallback('getSWFAddressValue', SWFAddress, 
                function():String {return this._value});
            ExternalInterface.addCallback('setSWFAddressValue', SWFAddress, 
                SWFAddress.setValue);
        }
    }
    
    public static function getTitle():String {
        var title:String = (_availability) ? 
            String(ExternalInterface.call('SWFAddress.getTitle')) : '';
        if (title == 'undefined' || title == 'null') title = '';
        return title;
    }

    public static function setTitle(title:String):Void {
        if (_availability) ExternalInterface.call('SWFAddress.setTitle', title);
    }
    
    public static function getStatus():String {
        var status:String = (_availability) ? 
            String(ExternalInterface.call('SWFAddress.getStatus')) : '';
        if (status == 'undefined' || status == 'null') status = '';
        return status;
    }

    public static function setStatus(status:String):Void {
        if (_availability) ExternalInterface.call('SWFAddress.setStatus', status);
    }
    
    public static function resetStatus():Void {
        if (_availability) ExternalInterface.call('SWFAddress.resetStatus');
    }
    
    public static function getPath():String {
        var value:String = SWFAddress.getValue();
        if (value.indexOf('?') != 1) {
            return value.split('?')[0];
        } else {
            return value;   
        }
    }

    public static function getQueryString():String {
        var value:String = SWFAddress.getValue();
        var index:Number = value.indexOf('?');
        if (index != -1 && index < value.length) {
            return value.substr(index + 1);
        }
        return '';
    }

    public static function getParameter(param:String):String {
        var value:String = SWFAddress.getValue();
        var index:Number = value.indexOf('?');
        if (index != -1) {
            value = value.substr(index + 1);
            var params:Array = value.split('&');
            var p:Array;
            var i:Number = params.length;
            while(i--) {
                p = params[i].split('=');
                if (p[0] == param) {
                    return p[1];
                }
            }
        }
        return '';
    }

    public static function getParameterNames():Array {
        var value:String = SWFAddress.getValue();
        var index:Number = value.indexOf('?');
        var names:Array = new Array();
        if (index != -1) {
            value = value.substr(index + 1);
            if (value != '' && value.indexOf('=') != -1) {            
                var params:Array = value.split('&');
                var i:Number = 0;
                while(i < params.length) {
                    names.push(params[i].split('=')[0]);
                    i++;
                }
            }
        }
        return names;
    }

    public static function getValue():String {
        var addr:String, id:String = 'null';
        if (_availability) {
            addr = String(ExternalInterface.call('SWFAddress.getValue'));
            id = String(ExternalInterface.call('SWFAddress.getId'));
        }
        if (id == 'null' || !_availability) {
            addr = SWFAddress._value;
        } else {
            if (addr == 'undefined' || addr == 'null') addr = '';        
        }
        return addr;
    }

    public static function setValue(addr:String):Void {
        if (addr == 'undefined' || addr == 'null') addr = '';
        SWFAddress._value = addr;
        if (_availability) ExternalInterface.call('SWFAddress.setValue', addr);
        if (SWFAddress.onChange) SWFAddress.onChange();
    }

}