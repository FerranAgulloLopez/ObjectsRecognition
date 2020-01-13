function [normalizeValues,result_table] = normalizeColumns(result_table)
normalizeValues = zeros([17 2]);
[nr, nc] = size(result_table);
    for i=1:nc
        max_value = max(result_table(:,i));
        min_value = min(result_table(:,i));
        
        normalizeValues(i,1)=min_value;
        normalizeValues(i,2)=max_value;
        
        for j=1:nr
            value = result_table(j,i);
            result_table(j,i) = (value - min_value)/(max_value - min_value);
        end
    end
end

