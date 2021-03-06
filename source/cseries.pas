unit cSeries;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls,
  TASources, TASeries;

type
  TcLineSeries = class(TLineSeries)
  private
    FCalculatedSource: TCalculatedChartSource;
    FNode: TTreeNode;
    function GetAccRange: Integer;
    function GetMovingAverage: Boolean;
    procedure SetAccRange(AValue: Integer);
    procedure SetMovingAverage(AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property AccumulationRange: Integer read GetAccRange write SetAccRange;
    property MovingAverage: Boolean read GetMovingAverage write SetMovingAverage;
    property Node: TTreeNode read FNode write FNode;
  end;

  TcBarSeries = class(TBarSeries)
  private
    FCalculatedSource: TCalculatedChartSource;
    FNode: TTreeNode;
    function GetAccRange: Integer;
    function GetMovingAverage: Boolean;
    procedure SetAccRange(AValue: Integer);
    procedure SetMovingAverage(AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property AccumulationRange: Integer read GetAccRange write SetAccRange;
    property MovingAverage: Boolean read GetMovingAverage write SetMovingAverage;
    property Node: TTreeNode read FNode write FNode;
  end;


implementation

uses
  cGlobal;

{ TcLineSeries }

constructor TcLineSeries.Create(AOwner: TComponent);
begin
  inherited;
  FCalculatedSource := TCalculatedChartSource.Create(self);
  FCalculatedSource.AccumulationRange := ACCUMULATION_RANGE;
  FCalculatedSource.AccumulationMethod := camAverage;
  FCalculatedSource.AccumulationDirection := cadCenter;
  FCalculatedSource.Origin := ListSource;
end;

function TcLineSeries.GetAccRange: Integer;
begin
  Result := Integer(FCalculatedSource.AccumulationRange) * 2 - 1;
end;

function TcLineSeries.GetMovingAverage: Boolean;
begin
  Result := Source = FCalculatedSource;
end;

procedure TcLineSeries.SetAccRange(AValue: Integer);
begin
  if AValue = GetAccRange then
    exit;
  FCalculatedSource.AccumulationRange := (AValue + 1) div 2;
end;

procedure TcLineSeries.SetMovingAverage(AValue: Boolean);
begin
  if AValue = GetMovingAverage then
    exit;
  if AValue then
    Source := FCalculatedSource
  else
    Source := nil;
end;


{ TcBarSeries }

constructor TcBarSeries.Create(AOwner: TComponent);
begin
  inherited;
  FCalculatedSource := TCalculatedChartSource.Create(self);
  FCalculatedSource.AccumulationRange := ACCUMULATION_RANGE;
  FCalculatedSource.AccumulationMethod := camAverage;
  FCalculatedSource.AccumulationDirection := cadCenter;
  FCalculatedSource.Origin := ListSource;
end;

function TcBarSeries.GetAccRange: Integer;
begin
  Result := Integer(FCalculatedSource.AccumulationRange) * 2 - 1;
end;

function TcBarSeries.GetMovingAverage: Boolean;
begin
  Result := Source = FCalculatedSource;
end;

procedure TcBarSeries.SetAccRange(AValue: Integer);
begin
  if AValue = GetAccRange then
    exit;
  FCalculatedSource.AccumulationRange := (AValue + 1) div 2;
end;

procedure TcBarSeries.SetMovingAverage(AValue: Boolean);
begin
  if AValue = GetMovingAverage then
    exit;
  if AValue then
    Source := FCalculatedSource
  else
    Source := nil;
end;

end.

