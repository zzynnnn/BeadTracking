function SubmitDetection(hObj,~,f)
%----------------------------------------------------------------------
%----------------------------------------------------------------------
%---             --- Thomas Gautrais                                ---
%---    Author   --- thomas.gautrais@univ-st-etienne.fr             ---
%---             --- Laboratoire Hubert Curien (UMR 5516)           ---
%----------------------------------------------------------------------
%---             --- Callback of the 'RUN' and 'CANCEL' push        ---
%--- Description --- buttons and close figure button in the figure  ---
%---             --- generated by the DetectionGui.m.               ---
%----------------------------------------------------------------------
%---   Version   ---  2019-03-20:                                   ---
%---   History   ---       First version of the file                ---
%----------------------------------------------------------------------
%----------------------------------------------------------------------
%
% Copyright (c) 2019, Hugo Lafaye de Micheaux, Thomas Gautrais, Universit�
% Jean Monnet, CNRS, Irstea
% All rights reserved.
%
% This source code is part of the BeadTracking package
% <https://github.com/hugolafaye/BeadTracking> and it is licensed under the
% BSD-style license found in the LICENSE file in the root directory of this
% source tree.

s=guidata(f);

[outStruct,run,closef]=Submit(hObj,f);

idx_trans_real=strcmp(s.real.mapKeys,s.real.fieldNames.REAL_TRANS_TH);
idx_trans_conf_real=strcmp(s.real.mapKeys,s.real.fieldNames.REAL_TRANS_CONF_TH);

if min(strcmp(get(s.real.hText(idx_trans_real|idx_trans_conf_real),...
        'Enable'),'on'))
    val_trans_conf=outStruct.(s.real.mapKeys{idx_trans_conf_real});
    val_trans=outStruct.(s.real.mapKeys{idx_trans_real});
    if val_trans_conf > val_trans
        set(s.submit.info, 'String', ['Parameter "' ...
                s.real.mapKeys{idx_trans_conf_real} '" ('  ...
                num2str(val_trans_conf)  ') cannot be greater than ' ...
                'parameter "' s.real.mapKeys{idx_trans_real} ...
                '" (' num2str(val_trans) ')']);
        return
    end
end

if closef
    assignin('caller','outStruct',outStruct);
    assignin('caller','run',run);
    set(0,'CurrentFigure',f);
    closereq;
    pause(0.01);
end

end