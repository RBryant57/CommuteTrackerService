using Microsoft.EntityFrameworkCore;

using CommuteTrackerService.Models;

namespace CommuteTrackerService.Data
{
    public partial class GeneralContext : DbContext
    {
        public GeneralContext()
        {
        }

        public GeneralContext(DbContextOptions<GeneralContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AverageCommute> AverageCommutes { get; set; }
        public virtual DbSet<Commute> Commutes { get; set; }
        public virtual DbSet<CommuteLeg> CommuteLegs { get; set; }
        public virtual DbSet<CommuteMultiRoute> CommuteMultiRoutes { get; set; }
        public virtual DbSet<CommutesRoute> CommutesRoutes { get; set; }
        public virtual DbSet<DelayReason> DelayReasons { get; set; }
        public virtual DbSet<Destination> Destinations { get; set; }
        public virtual DbSet<FareClass> FareClasses { get; set; }
        public virtual DbSet<PassCondition> PassConditions { get; set; }
        public virtual DbSet<Route> Routes { get; set; }
        public virtual DbSet<RouteType> RouteTypes { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=tcp:commutetracker.database.windows.net,1433;Initial Catalog=General;Persist Security Info=False;User ID=rwb;Password=zMfMBD4^#qPILNWM;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AverageCommute>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("AverageCommute");

                entity.Property(e => e.AverageSeconds).HasColumnName("Average Seconds");

                entity.Property(e => e.Route)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.RouteType)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("Route Type");
            });

            modelBuilder.Entity<Commute>(entity =>
            {
                entity.ToTable("Commute");

                entity.Property(e => e.EndTime).HasColumnType("datetime");

                entity.Property(e => e.StartTime).HasColumnType("datetime");

                entity.HasOne(d => d.DestinationNavigation)
                    .WithMany(p => p.Commutes)
                    .HasForeignKey(d => d.Destination)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Commute_Destination");
            });

            modelBuilder.Entity<CommuteLeg>(entity =>
            {
                entity.ToTable("CommuteLeg");

                entity.Property(e => e.EndTime).HasColumnType("datetime");

                entity.Property(e => e.StartTime).HasColumnType("datetime");

                entity.HasOne(d => d.CommuteNavigation)
                    .WithMany(p => p.CommuteLegs)
                    .HasForeignKey(d => d.Commute)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteLeg_Commute");

                entity.HasOne(d => d.DelayNavigation)
                    .WithMany(p => p.CommuteLegs)
                    .HasForeignKey(d => d.Delay)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteLeg_Delay");

                entity.HasOne(d => d.DestinationNavigation)
                    .WithMany(p => p.CommuteLegs)
                    .HasForeignKey(d => d.Destination)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteLeg_Destination");

                entity.HasOne(d => d.FareClassNavigation)
                    .WithMany(p => p.CommuteLegs)
                    .HasForeignKey(d => d.FareClass)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteLeg_FareClass");

                entity.HasOne(d => d.RouteNavigation)
                    .WithMany(p => p.CommuteLegs)
                    .HasForeignKey(d => d.Route)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteLeg_Route");
            });

            modelBuilder.Entity<CommuteMultiRoute>(entity =>
            {
                entity.ToTable("CommuteMultiRoute");

                entity.Property(e => e.EndTime).HasColumnType("datetime");

                entity.Property(e => e.StartTime).HasColumnType("datetime");

                entity.HasOne(d => d.DelayNavigation)
                    .WithMany(p => p.CommuteMultiRoutes)
                    .HasForeignKey(d => d.Delay)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteMultiRoute_DelayReason");

                entity.HasOne(d => d.DestinationNavigation)
                    .WithMany(p => p.CommuteMultiRoutes)
                    .HasForeignKey(d => d.Destination)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommuteMultiRoute_DestinationType");
            });

            modelBuilder.Entity<CommutesRoute>(entity =>
            {
                entity.HasOne(d => d.Commute)
                    .WithMany(p => p.CommutesRoutes)
                    .HasForeignKey(d => d.CommuteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommutesRoutes_Commute");

                entity.HasOne(d => d.Route)
                    .WithMany(p => p.CommutesRoutes)
                    .HasForeignKey(d => d.RouteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_CommutesRoutes_Route");
            });

            modelBuilder.Entity<DelayReason>(entity =>
            {
                entity.ToTable("DelayReason");

                entity.HasIndex(e => e.Description, "UQ__DelayReason_Description")
                    .IsUnique();

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Destination>(entity =>
            {
                entity.ToTable("Destination");

                entity.HasIndex(e => e.Name, "UQ__Destination_Name")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<FareClass>(entity =>
            {
                entity.ToTable("FareClass");

                entity.HasIndex(e => e.Name, "UQ__FareClass_Name")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<PassCondition>(entity =>
            {
                entity.ToTable("PassCondition");

                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.HasOne(d => d.DelayReason)
                    .WithMany(p => p.PassConditions)
                    .HasForeignKey(d => d.DelayReasonId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PassConditions_DelayReason");

                entity.HasOne(d => d.Route)
                    .WithMany(p => p.PassConditions)
                    .HasForeignKey(d => d.RouteId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PassConditions_Route");
            });

            modelBuilder.Entity<Route>(entity =>
            {
                entity.ToTable("Route");

                entity.HasIndex(e => e.Name, "UQ__Route_Name")
                    .IsUnique();

                entity.HasIndex(e => e.Name, "Unique_Name")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Number)
                    .IsRequired()
                    .HasMaxLength(5);

                entity.HasOne(d => d.RouteType)
                    .WithMany(p => p.Routes)
                    .HasForeignKey(d => d.Type)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Route_RouteType");
            });

            modelBuilder.Entity<RouteType>(entity =>
            {
                entity.ToTable("RouteType");

                entity.HasIndex(e => e.Name, "UQ__RouteType_Name")
                    .IsUnique();

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
