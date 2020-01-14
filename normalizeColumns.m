function [normalizeValues,result_table,deleted] = normalizeColumns(result_table)
normalizeValues = zeros([17 2]);
toDelete = zeros([1 1]);
[nr, nc] = size(result_table);
    for i=1:nc
        max_value = max(result_table(:,i));
        min_value = min(result_table(:,i));
        
        normalizeValues(i,1)=min_value;
        normalizeValues(i,2)=max_value;
        
        if max_value ~= min_value
            for j=1:nr
                value = result_table(j,i);
                    result_table(j,i) = (value - min_value)/(max_value - min_value);
            end
        end
    end
    
    for l=1:nc
        if ~any(result_table(:,l))
            toDelete = [toDelete;l];
        end
    end
    deleted=toDelete;
    if length(toDelete)>1
        toDelete=toDelete(2:length(toDelete));
        result_table(:,toDelete)=[];
        normalizeValues(toDelete,:)=[];
    end
end

