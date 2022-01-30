using Microsoft.EntityFrameworkCore; // place this line at the beginning of file.
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Connect to PostgreSQL Database
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<LogDb>(options =>
    options.UseNpgsql(connectionString));

builder.Services.AddDatabaseDeveloperPageExceptionFilter();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGet("/", () => "Welcome to Logs API!");

// Create Note
app.MapPost("/logs/", async(Log n, LogDb db)=> {
    db.Logs.Add(n);
    await db.SaveChangesAsync();

    return Results.Created($"/logs/{n.id}", n);
});

// Read Note by id
app.MapGet("/logs/{id:int}", async(int id, LogDb db)=> 
{
    return await db.Logs.FindAsync(id)
            is Log n
                ? Results.Ok(n)
                : Results.NotFound();
});

// Read all Logs
app.MapGet("/logs", async (LogDb db) => await db.Logs.ToListAsync());

// Update a Note by id
app.MapPut("/logs/{id:int}", async(int id, Log n, LogDb db)=>
{
    if (n.id != id)
    {
        return Results.BadRequest();
    }

    var log = await db.Logs.FindAsync(id);
    
    if (log is null) return Results.NotFound();

    //found, so update with incoming log n.
    // log.text = n.text;
    // log.done = n.done;
    await db.SaveChangesAsync();
    return Results.Ok(log);
});

// Delete a Note by id
app.MapDelete("/logs/{id:int}", async(int id, LogDb db)=>{

    var log = await db.Logs.FindAsync(id);
    if (log is not null){
        db.Logs.Remove(log);
        await db.SaveChangesAsync();
    }
    return Results.NoContent();
});

await app.RunAsync();

record Log(int id){
    public string LogId { get; set; }
    public string Source { get; set; }
    public string Message { get; set; }
    public DateTime Logged { get; set; }
}

class LogDb: DbContext {
    public LogDb(DbContextOptions<LogDb> options): base(options) {

    }
    public DbSet<Log> Logs => Set<Log>();
}