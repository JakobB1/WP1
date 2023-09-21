using System.Reflection;
using GameStoreWebAPI.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(sgo => { // sgo je instanca klase SwaggerGenOptions
    // èitati https://devintxcontent.blob.core.windows.net/showcontent/Speaker%20Presentations%20Fall%202017/Web%20API%20Best%20Practices.pdf
    var o = new Microsoft.OpenApi.Models.OpenApiInfo()
    {
        Title = "Game API",
        Version = "v1",
        Contact = new Microsoft.OpenApi.Models.OpenApiContact()
        {
            Email = "jakob@gmail.com",
            Name = "Jakob Brkic"
        },
        Description = "Ovo je dokumentacija za Game API",
        License = new Microsoft.OpenApi.Models.OpenApiLicense()
        {
            Name = "Licenca"
        }
    };
    sgo.SwaggerDoc("v1", o);
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    sgo.IncludeXmlComments(xmlPath, includeControllerXmlComments: true);

});

// Dodavanje baze podataka
builder.Services.AddDbContext<GameContext>(o =>
    o.UseSqlServer(
        builder.Configuration.
        GetConnectionString(name: "GameContext")
        )
    );

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger(opcije =>
    {
        opcije.SerializeAsV2 = true;
    });
    app.UseSwaggerUI(opcije =>
    {
        opcije.ConfigObject.
        AdditionalItems.Add("requestSnippetsEnabled", true);
    });
}

app.UseHttpsRedirection();

app.MapControllers();
app.UseStaticFiles();
app.Run();
