# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180501222104) do

  create_table "dependentes", force: true do |t|
    t.integer  "participante_id"
    t.integer  "user_id"
    t.string   "codigo",          limit: 40
    t.string   "nome"
    t.integer  "sexo"
    t.date     "data_nascimento"
    t.integer  "parentesco"
    t.boolean  "invalido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dependentes", ["participante_id"], name: "dependentes_participante_id_fk", using: :btree
  add_index "dependentes", ["user_id"], name: "dependentes_user_id_fk", using: :btree

  create_table "empresas", force: true do |t|
    t.string   "cpf_cnpj",            limit: 14
    t.boolean  "pessoa_fisica"
    t.string   "nome",                limit: 100
    t.string   "caminho_certificado"
    t.string   "senha_certificado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados", force: true do |t|
    t.string   "codigo",     limit: 10
    t.string   "descricao"
    t.string   "uf",         limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imagens", force: true do |t|
    t.integer  "participante_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "images_file_name"
    t.string   "images_content_type"
    t.integer  "images_file_size"
    t.datetime "images_updated_at"
  end

  add_index "imagens", ["participante_id"], name: "index_imagens_on_participante_id", using: :btree

  create_table "lotacoes", force: true do |t|
    t.string   "codigo",     limit: 20
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimentos", force: true do |t|
    t.text     "arquivo_origem"
    t.text     "arquivo_retorno"
    t.datetime "data_arquivo_retorno"
    t.integer  "xml_template_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nr_recibo",            limit: 50
    t.string   "nr_recibo_referencia", limit: 50
    t.integer  "empresa_id"
    t.integer  "tipo_ambiente"
  end

  add_index "movimentos", ["empresa_id"], name: "index_movimentos_on_empresa_id", using: :btree
  add_index "movimentos", ["user_id"], name: "index_movimentos_on_user_id", using: :btree
  add_index "movimentos", ["xml_template_id"], name: "index_movimentos_on_xml_template_id", using: :btree

  create_table "participantes", force: true do |t|
    t.integer  "estado_id"
    t.integer  "lotacao_id"
    t.integer  "user_id"
    t.string   "matricula",            limit: 25
    t.string   "nome",                 limit: 60
    t.string   "nome_pai",             limit: 60
    t.string   "nome_mae",             limit: 60
    t.string   "nome_conjugue",        limit: 60
    t.integer  "sexo"
    t.string   "naturalidade",         limit: 40
    t.string   "nacionalidade",        limit: 40
    t.integer  "estado_civil"
    t.date     "data_nascimento"
    t.string   "cpf",                  limit: 11
    t.string   "rg",                   limit: 20
    t.string   "orgao_expedidor",      limit: 20
    t.date     "data_expedicao"
    t.string   "logradouro",           limit: 100
    t.string   "numero",               limit: 10
    t.string   "complemento",          limit: 100
    t.string   "bairro",               limit: 40
    t.string   "cidade",               limit: 40
    t.string   "cep",                  limit: 20
    t.date     "data_posse"
    t.string   "cargo",                limit: 60
    t.string   "telefone_residencial", limit: 20
    t.string   "telefone_celular",     limit: 20
    t.string   "email",                limit: 60
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participantes", ["estado_id"], name: "index_participantes_on_estado_id", using: :btree
  add_index "participantes", ["lotacao_id"], name: "index_participantes_on_lotacao_id", using: :btree
  add_index "participantes", ["user_id"], name: "index_participantes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                   default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "role",                              default: 0
    t.string   "cpf",                    limit: 11
  end

  add_index "users", ["cpf"], name: "index_users_on_cpf", unique: true, using: :btree

  create_table "usuario_empresas", force: true do |t|
    t.integer  "user_id"
    t.integer  "empresa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuario_empresas", ["empresa_id"], name: "index_usuario_empresas_on_empresa_id", using: :btree
  add_index "usuario_empresas", ["user_id"], name: "index_usuario_empresas_on_user_id", using: :btree

  create_table "xml_templates", force: true do |t|
    t.string   "evento"
    t.string   "descricao"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_web_service_pre_producao"
    t.string   "url_web_service_producao"
  end

  add_index "xml_templates", ["user_id"], name: "index_xml_templates_on_user_id", using: :btree

  add_foreign_key "dependentes", "participantes", name: "dependentes_participante_id_fk"
  add_foreign_key "dependentes", "users", name: "dependentes_user_id_fk"

  add_foreign_key "movimentos", "empresas", name: "movimentos_empresa_id_fk"
  add_foreign_key "movimentos", "users", name: "movimentos_user_id_fk"
  add_foreign_key "movimentos", "xml_templates", name: "movimentos_xml_template_id_fk"

  add_foreign_key "participantes", "users", name: "participantes_user_id_fk"

  add_foreign_key "usuario_empresas", "empresas", name: "usuario_empresas_empresa_id_fk"
  add_foreign_key "usuario_empresas", "users", name: "usuario_empresas_user_id_fk"

  add_foreign_key "xml_templates", "users", name: "xml_templates_user_id_fk"

end
