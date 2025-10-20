class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :title, null: false
      t.string :description
      t.string :url, null: false
      t.string :icon, null: false
      t.integer :position, null: false
      t.boolean :enabled, default: true, null: false

      t.timestamps
    end

    add_index :links, :position, unique: true
    add_index :links, :enabled

    # Insert default links that are currently hardcoded
    reversible do |dir|
      dir.up do
        Link.create!([
          {
            title: "Google Business",
            description: "Our Google business page",
            url: "https://share.google/GP8egtl6lmS6GvkIC",
            icon: "🏢",
            position: 1,
            enabled: true
          },
          {
            title: "Our Website",
            description: "Full website with all services",
            url: "https://gtcarpets.uk/",
            icon: "🏠",
            position: 2,
            enabled: true
          },
          {
            title: "Photo Gallery",
            description: "See our recent work",
            url: "https://gtcarpets.uk/gallery",
            icon: "📸",
            position: 3,
            enabled: true
          },
          {
            title: "Price Calculator",
            description: "Get an instant quote",
            url: "https://gtcarpets.uk/#calculator",
            icon: "💰",
            position: 4,
            enabled: true
          },
          {
            title: "Contact Form",
            description: "Send us a message",
            url: "https://gtcarpets.uk/#contact",
            icon: "📧",
            position: 5,
            enabled: true
          },
          {
            title: "Call Us Now",
            description: "07494 789381",
            url: "tel:+447494789381",
            icon: "📞",
            position: 6,
            enabled: true
          },
          {
            title: "WhatsApp",
            description: "Chat with us instantly",
            url: "https://wa.me/447494789381",
            icon: "💬",
            position: 7,
            enabled: true
          },
          {
            title: "Email Us",
            description: "gareth@gtcarpets.uk",
            url: "mailto:gareth@gtcarpets.uk",
            icon: "📧",
            position: 8,
            enabled: true
          }
        ])
      end
    end
  end
end