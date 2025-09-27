namespace xYard.Domain.Entities;

public enum TransportType
{
    Taxi,
    Bus,
    Underground
}

public class Route
{
    public int Id { get; set; }

    public int FromPointId { get; set; }
    public Point FromPoint { get; set; } = null!;

    public int ToPointId { get; set; }
    public Point ToPoint { get; set; } = null!;

    public TransportType Type { get; set; }
}