classdef Specimen < handle
    properties (SetAccess = private)
        % immutables properties of each specimen
        m_specimenName;
        m_dxa;
        m_opStatus;
        m_dataAvailable;
        % these are bools to say if the data is available
    end
    methods
        function SP = Specimen(name,dxa,op,data)
            % The constructor takes the name, DXA values the osteoporosis
            % status and the available data as inputs.
            % name is a string
            % dxa is a structure with fields:
            %      'neck','troch','inter','total','wards'
            % op is one of:
            %      'normal','osteopenia','osteoporosis'
            % data is a structure of bools indicating what data with 
            % is available. It is comprised of the fields:
            %      'InstronDAQ','InstronDIC','DropTowerDAQ','DropTowerDisplacement','DropTowerDIC'
            %
            % Sp = Specimen([SpecimenName],[DXAValues],[OPStatus])
            SP.SetSpecimenName(name);
            SP.SetDxa(dxa);
            SP.SetOp(op);
            SP.SetData(data);
        end
        
        function SetSpecimenName(SP,name)
            if ~ischar(name)
                sprintf('No specimen name given. Aborting. Type Crtl+c to continue.')
                keyboard;
            else
                SP.m_specimenName = name;
            end
        end
        
        function SetDxa(SP,dxa)
            if (~isfield(dxa,'neck') || ~isfield(dxa,'troch') || ~isfield(dxa,'inter') || ~isfield(dxa,'total') || ~isfield(dxa,'wards') )
                error('Specimen:dxaFault','Malformed DXA structure. Please check the DXA data for %s and retry. Aborting.\n',SP.m_specimenName);
            end
                SP.m_dxa = dxa;
        end
        
        function SetOp(SP,op)
            if (~strcmp(op,'normal') && ~strcmp(op,'osteopenia') && ~strcmp(op,'osteoporosis') )
                error('Specimen:opFault','Invalid osteoporosis state specified. Please check the value for %s and retry. Aborting.\n',SP.m_specimenName);
            end
                SP.m_opStatus = op;
        end
        
        function SetData(SP,data)
            if ( ~isfield(data,'InstronDAQ') || ~isfield(data,'InstronDIC') || ~isfield(data,'DropTowerDAQ') || ~isfield(data,'DropTowerDisplacement') || ~isfield(data,'DropTowerDIC') )
                error('Specimen:dataFault','Malformed data available structure. Please check the values for %s and retry.\n',SP.m_specimenName);
            end
                SP.m_dataAvailable  = data;
        end
        
        % get functions for each property
        function o = GetSpecimenName(SP)
            o = SP.m_specimenName;
        end
        function o = GetDXA(SP)
            o = SP.m_dxa;
        end
        function o = GetOpStatus(SP)
            o = SP.m_opStatus;
        end
        function o = GetDataAvailable(SP)
            o = [SP.m_instronDAQ, SP.m_instronDIC, SP.m_dtDAQ, SP.m_dtDisplacement, SP.m_dtDIC];
        end
    end
end