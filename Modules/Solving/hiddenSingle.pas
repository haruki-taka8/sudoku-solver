unit hiddenSingle;

interface
uses types, auxiliary, io;
procedure SolveCell (var grid : TIntegerGrid; InputHint : TStringGrid);


implementation

procedure SolveCell (var grid : TIntegerGrid; InputHint : TStringGrid);
var x, y, p, q, r, s, ThisX, ThisY : integer;
    ThisHint : string;
    IsHiddenSingle : boolean;
begin
    for y := 0 to 8 do
        for x := 0 to 8 do
            if grid[y, x] = 0 then
                for p := 1 to length(InputHint[y, x]) do
                begin
                    ThisHint := InputHint[y, x][p];
                    IsHiddenSingle := true;
                
                    // ELIMINATION: Column
                    for q := 0 to 8 do
                        if ((pos(ThisHint, InputHint[q, x]) <> 0) and (q <> y)) then
                        begin
                            IsHiddenSingle := false;
                            break;
                        end;
                        
                    if IsHiddenSingle then
                    begin
                        grid[y, x] := SBA_StrToInt(ThisHint);
                        WriteStepCell(y, x, grid[y, x], 'Hidden Single', '(column)');
                        break;
                    end;
                    IsHiddenSingle := true;
                        
                    // ELIMINATION: Row
                    for q := 0 to 8 do
                        if ((pos(ThisHint, InputHint[y, q]) <> 0) and (q <> x)) then
                        begin
                            IsHiddenSingle := false;
                            break;
                        end;
                        
                    if IsHiddenSingle then
                    begin
                        grid[y, x] := SBA_StrToInt(ThisHint);
                        WriteStepCell(y, x, grid[y, x], 'Hidden Single', '(row)');
                        break;
                    end;
                    IsHiddenSingle := true;
                        
                    // ELIMINATION: Subgrid
                    for r := 0 to 2 do
                        for s := 0 to 2 do
                        begin
                            ThisY := 3 * (y div 3) + r;
                            ThisX := 3 * (x div 3) + s;
                            
                            if ((pos(ThisHint, InputHint[ThisY, ThisX]) <> 0) and ((ThisY <> y) or (ThisX <> x))) then
                            begin
                                IsHiddenSingle := false;
                                break;
                            end;
                        end;
                    
                    if IsHiddenSingle then
                    begin
                        grid[y, x] := SBA_StrToInt(ThisHint);
                        WriteStepCell(y, x, grid[y, x], 'Hidden Single', '(subgrid)');
                        break;
                    end;
                end;
end;

end.