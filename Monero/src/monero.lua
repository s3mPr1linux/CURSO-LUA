
require "ext_libs.stringUtils"
require "ext_libs.ioUtils"


function mprint(...)
    local args = {...}
    for i = 1, #args do
        args[i] = "!" .. args[i] .. "!"
    end

    print(unpack(args))
end


function toString(tbMoedas)
    local result = ""
    for i, moeda in ipairs(tbMoedas) do
        result = result .. "Cod moeda: " .. (moeda.codMoeda or "") .. "\n"
        result = result .. "Nome: " .. (moeda.nome or "") .. "\n"
        result = result .. "Simbolo: " .. (moeda.simbolo or "") .. "\n"
        result = result .. "Cod Pais: " .. (moeda.codPais or "") .. "\n"
        result = result .. "Pais: " .. (moeda.pais or "") .. "\n"
        result = result .. "Tipo Moeda: " .. (moeda.tipoMoeda or "") .. "\n"
        result = result .. "Data Exlusao: " .. (moeda.dataExclusao or "") .. "\n"
        result = result .. "\n"



    end
    return result
end


-- Nome da moeda,
-- Simbolo
-- Nome do País
-- "005;AFEGANE AFEGANIST;AFN    ;132;AFEGANISTAO                                       ;A;"


function main(...)
    io.write("Digite o nome do arquivo de entrada: ")
    local nomeArquivoMoedas = io.read()

    local status, conteudo = pcall(readTextFromFile, nomeArquivoMoedas)
    if status == false then -- => ocorreu um erro
        print("O arquivo '" .. nomeArquivoMoedas .. "' nao foi encontrado. Execute novamente com um arquivo valido.")
        os.exit(1)
    end

    local linhas = split(conteudo, "\r?\n")
    table.remove(linhas, 1) -- Removendo linha de cabeçalho

    local resultado = {}
    for i, linha in ipairs(linhas) do

        local tbMoeda = split(linha, ";")
        if tbMoeda[2] ~= nil then
            local moeda =
            {
                codMoeda = trim(tbMoeda[1]),
                nome = trim(tbMoeda[2]),
                simbolo = trim(tbMoeda[3]),
                codPais = trim(tbMoeda[4]),
                pais = trim(tbMoeda[5]),
                tipoMoeda = trim(tbMoeda[6]),
                dataExclusao = trim(tbMoeda[7]),
            }
            table.insert(resultado, moeda)
        end

    end

    local nomeArqResultado = string.gsub(nomeArquivoMoedas, "%.%w+$", ".txt")
    saveTextToFile(toString(resultado), nomeArqResultado)

end


function test()
    local text = readTextFromFile()
    print(text)
end


--test()
main()
