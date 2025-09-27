namespace xYard.Domain.Entities;

public class Point
{
    public int Id { get; set; }
    public int Xmm { get; set; }
    public int Ymm { get; set; }

    public string? Label { get; set; }

    // Optional: Navigationshilfe
    public List<Route> RoutesFromHere { get; set; } = new();    
}