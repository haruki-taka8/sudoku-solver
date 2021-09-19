unit HiddenTriple;

interface
uses triple, types, auxiliary, io;
procedure RemoveHint (var hint : TStringGrid);


implementation

procedure RemoveHint (var hint : TStringGrid);
var y, x, p, r, s, HiddenTripleCount, SubgridCellID : integer;
    Hints, ThisCombo, ThisCell, ThisLetter : string;
    IsHiddenTriple : array [0..8] of boolean;
begin
    // Row
    y := 0;
    x := 0;
    for y := 0 to 8 do
    begin
        Hints := '';

        // Generate possible triple combination
        for p := 0 to 8 do Hints := Hints + hint[y, p];
        Hints := MergeHint(Hints);

        for ThisCombo in GetThreeCombination(Hints) do
            if ThisCombo <> '' then
            begin
                HiddenTripleCount := 0;

                // If a cell in a house contains ThisCombo, the cell is eligible for hidden triples
                for p := 0 to 8 do
                begin
                    IsHiddenTriple[p] := false;
                    if (pos(ThisCombo[1], hint[y, p]) <> 0) or
                       (pos(ThisCombo[2], hint[y, p]) <> 0) or
                       (pos(ThisCombo[3], hint[y, p]) <> 0) then
                    begin
                        HiddenTripleCount := HiddenTripleCount + 1;
                        IsHiddenTriple[p] := true;
                    end;
                end;

                // Remove other hints in cells where IsHiddenTriple[p] are TRUE
                if HiddenTripleCount = 3 then
                begin
                    for p := 0 to 8 do
                        if IsHiddenTriple[p] then
                        begin
                            ThisCell := '';
                            for ThisLetter in ThisCombo do
                                if pos(ThisLetter, hint[y, p]) <> 0 then ThisCell := ThisCell + ThisLetter;
                            hint[y, p] := ThisCell;                        
                        end;

                    WriteStepHint(fileHandler, y, x, 'Hidden Triple', '-[^'+ThisCombo+'] for row '+SBA_IntToStr(y));
                end;
            end;
    end;

    // Column
    y := 0;
    x := 0;
    for x := 0 to 8 do
    begin
        Hints := '';

        // Generate possible triple combination
        for p := 0 to 8 do Hints := Hints + hint[p, x];
        Hints := MergeHint(Hints);

        for ThisCombo in GetThreeCombination(Hints) do
            if ThisCombo <> '' then
            begin
                HiddenTripleCount := 0;

                // If a cell in a house contains ThisCombo, the cell is eligible for hidden triples
                for p := 0 to 8 do
                begin
                    IsHiddenTriple[p] := false;
                    if (pos(ThisCombo[1], hint[p, x]) <> 0) or
                       (pos(ThisCombo[2], hint[p, x]) <> 0) or
                       (pos(ThisCombo[3], hint[p, x]) <> 0) then
                    begin
                        HiddenTripleCount := HiddenTripleCount + 1;
                        IsHiddenTriple[p] := true;
                    end;
                end;

                // Remove other hints in cells where IsHiddenTriple[p] are TRUE
                if HiddenTripleCount = 3 then
                begin
                    for p := 0 to 8 do
                        if IsHiddenTriple[p] then
                        begin
                            ThisCell := '';
                            for ThisLetter in ThisCombo do
                                if pos(ThisLetter, hint[p, x]) <> 0 then ThisCell := ThisCell + ThisLetter;
                            hint[p, x] := ThisCell;                        
                        end;

                    WriteStepHint(fileHandler, y, x, 'Hidden Triple', '-[^'+ThisCombo+'] for col '+SBA_IntToStr(x));
                end;
            end;
    end;


    // Subgrid
    y := 0;
    x := 0;
    while y < 8 do
    begin
        while x < 8 do
        begin
            Hints := '';

            // Generate possible triple combination
            for r := y to y+2 do
                for s := x to x+2 do
                    Hints := Hints + hint[r, s];
            Hints := MergeHint(Hints);

            for ThisCombo in GetThreeCombination(Hints) do
                if ThisCombo <> '' then
                begin
                    HiddenTripleCount := 0;
                    SubgridCellID := 0;

                    // If a cell in a house contains ThisCombo, the cell is eligible for hidden triples
                    for r := y to y+2 do
                        for s := x to x+2 do
                        begin
                            IsHiddenTriple[SubgridCellID] := false;
                            if (pos(ThisCombo[1], hint[r, s]) <> 0) or
                               (pos(ThisCombo[2], hint[r, s]) <> 0) or
                               (pos(ThisCombo[3], hint[r, s]) <> 0) then
                            begin
                                HiddenTripleCount := HiddenTripleCount + 1;
                                IsHiddenTriple[SubgridCellID] := true;
                            end;
                            SubgridCellID := SubgridCellID + 1;
                        end;

                    // Remove other hints in cells where IsHiddenTriple[p] are TRUE
                    if HiddenTripleCount = 3 then
                    begin
                        SubgridCellID := 0;
                        for r := y to y+2 do
                            for s := x to x+2 do
                            begin
                                if IsHiddenTriple[SubgridCellID] then
                                begin
                                    ThisCell := '';
                                    for ThisLetter in ThisCombo do
                                        if pos(ThisLetter, hint[r, s]) <> 0 then ThisCell := ThisCell + ThisLetter;
                                    hint[r, s] := ThisCell;                        
                                end;
                                SubgridCellID := SubgridCellID + 1;
                            end;

                        WriteStepHint(fileHandler, y, x, 'Hidden Triple', '-[^'+ThisCombo+'] for sub '+SBA_IntToStr((3*(r div 3)+(s div 3))));
                    end;
                end; 
            x := x + 3;
        end;
        y := y + 3;
        x := 0;
    end;
end;

end.
