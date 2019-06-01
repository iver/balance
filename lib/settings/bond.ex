defmodule Balance.Bond do
  use Ecto.Schema
  import Ecto.Changeset

  @kinds_names ["team", "individual"]

  schema "bonus_settings" do
    field(:percent, :float, default: 0.5)
    field(:kind, :string, default: "team")
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:percent, :kind])
    |> validate_kind()
  end

  def validate_kind(changeset) do
    kind = get_field(changeset, :kind)

    if kind in @kinds_names do
      changeset
    else
      add_error(changeset, :kind, "invalid kind name")
    end
  end
end
