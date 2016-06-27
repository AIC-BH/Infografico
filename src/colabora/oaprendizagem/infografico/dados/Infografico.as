package colabora.oaprendizagem.infografico.dados 
{
	import colabora.oaprendizagem.dados.ObjetoAprendizagem;
	import deng.fzip.FZip;
	import deng.fzip.FZipEvent;
	import deng.fzip.FZipFile;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class Infografico extends EventDispatcher
	{
		// VARIÁVEIS PÚBLICAS
		
		/**
		 * Identificador único deste infográfico.
		 */
		public var id:String;
		
		/**
		 * Título deste infográfico.
		 */
		public var titulo:String;
		
		/**
		 * Tags associadas a este infográfico.
		 */
		public var tags:String;
		
		/**
		 * Páginas do infográfico.
		 */
		public var paginas:Vector.<Pagina>;
		
		/**
		 * Página atual no vetor de páginas.
		 */
		public var paginaAtual:int = 0;
		
		/**
		 * Link para a pasta deste projeto.
		 */
		public var pasta:File;
		
		// VARIÁVEIS PRIVADAS
		
		private var _pastaTemp:File;
		
		public function Infografico()
		{
			// inicializando
			this.paginas = new Vector.<Pagina>();
			this.clear();
		}
		
		// SOMENTE LEITURA
		
		/**
		 * Referência à imagem a ser tratada.
		 */
		public function get refImagem():Imagem
		{
			if (this.paginas.length > this.paginaAtual) {
				return (this.paginas[this.paginaAtual].refImagem);
			} else {
				return (null);
			}
		}
		
		/**
		 * Informações sobre o projeto na forma de um objeto único.
		 */
		public function get dados():Object
		{
			var retorno:Object = new Object();
			retorno.id = this.id;
			retorno.titulo = this.titulo;
			retorno.tags = this.tags;
			retorno.paginaAtual = this.paginaAtual;
			retorno.app = ObjetoAprendizagem.codigo;
			retorno.paginas = new Vector.<Object>();
			for (var i:int = 0; i < this.paginas.length; i++) {
				retorno.paginas.push(this.paginas[i].dados);
			}
			return(retorno);
		}
		
		/**
		 * Referência para a página exibida no momento.
		 */
		public function get pagina():Pagina
		{
			if (this.paginas.length > this.paginaAtual) {
				return (this.paginas[this.paginaAtual]);
			} else {
				return (null);
			}
		}
		
		/**
		 * O projeto está limpo?
		 */
		public function get limpo():Boolean
		{
			var retorno:Boolean = false;
			if (this.paginas.length == 0) {
				// não há nenhuma página?
				retorno = true;
			} else {
				// há alguma imagem adicionada?
				retorno = true;
				for (var i:int = 0; i < this.paginas.length; i++) {
					if (this.paginas[i].imagens.length > 0) {
						retorno = false;
					}
				}
			}
			return (retorno);
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Limpa informações do projeto de infográfico atual.
		 */
		public function clear():void
		{
			this.id = this.geraID();
			this.titulo = '';
			this.tags = '';
			this.paginaAtual = 0;
			this.pasta = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + this.id);
			while (this.paginas.length > 0) {
				this.paginas[0].removeEventListener(Event.COMPLETE, onImComplete);
				this.paginas.shift().dispose();
			}
			// this.adicionaPagina();
		}
		
		/**
		 * Carrega informações de um projeto de infográfico.
		 * @param	id	identificador da narrativa a carregar
		 * @return	TRUE se o infográfico existir na pasta de documentos e seus arquivos estiverem corretos
		 */
		public function carregaProjeto(id:String):Boolean
		{
			// verificando a existência do projeto
			var arquivoProj:File = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + id + '/projeto.json');
			if (arquivoProj.exists) {
				// recuperando texto do arquivo
				var stream:FileStream = new FileStream();
				stream.open(arquivoProj, FileMode.READ);
				var jsonTXT:String = stream.readUTFBytes(stream.bytesAvailable);
				stream.close();
				// fazendo a leitura do arquivo
				var lido:Boolean = false;
				var dados:Object;
				try {
					// recuperando objeto de dados
					dados = JSON.parse(jsonTXT);
					lido = true;
				} catch (e:Error) {
					// o texto não contém um JSON válido
					lido = false;
				}
				// dados recuperados?
				if (lido) {
					if ((dados.id != null) && (dados.paginas != null) && (dados.titulo != null) && (dados.tags != null)) {
						// limpando informações anteriores
						this.clear();
						// atribuindo id, título e tags
						this.id = dados.id;
						this.titulo = dados.titulo;
						this.tags = dados.tags;
						// direcionando pasta de gravação
						this.pasta = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + this.id);
						var pastaImagens:File = this.pasta.resolvePath('imagens');
						// carregando trilhas
						for (var i:int = 0; i < dados.paginas.length; i++) {
							this.paginas.push(new Pagina(i));
							this.paginas[i].carregaDados(dados.paginas[i]);
							this.paginas[i].addEventListener(Event.COMPLETE, onImComplete);
						}
						// projeto carregado
						return (true);
					} else {
						// o objeto recuperado não traz os campos de um projeto
						return (false);
					}
				} else {
					// o arquivo não contém dados de um projeto
					return (false);
				}
			} else {
				// o projeto indicado não existe
				return (false);
			}
		}
		
		/**
		 * Adiciona uma imagem à página atual.
		 * @param	inf	informação (arquivo ou texto)
		 * @param	tp	tipo (tx, bb ou im)
		 * @param	ft	fonte
		 * @param	dd	objeto de inicialização
		 */
		public function adicionaImagem(inf:String, tp:String, ft:String = '', dd:Object = null):void
		{
			// a página atual existe?
			while (this.paginas.length <= this.paginaAtual) {
				this.adicionaPagina();
			}
			// adicionando a imagem
			this.paginas[this.paginaAtual].adicionaImagem(inf, tp, ft, dd);
		}
		
		/**
		 * Adiciona uma página ao projeto.
		 */
		public function adicionaPagina():void
		{
			this.paginas.push(new Pagina(this.paginas.length));
			this.paginas[this.paginas.length - 1].addEventListener(Event.COMPLETE, onImComplete);
		}
		
		/**
		 * Remove a página atual do projeto.
		 */
		public function removePaginaAtual():void
		{
			// guardar valores
			var pgAtual:int = this.paginaAtual;
			var numPaginaAtual:int = this.pagina.numero;
			// remover página
			this.pagina.removeEventListener(Event.COMPLETE, onImComplete);
			this.pagina.dispose();
			this.paginas.splice(pgAtual, 1);
			// há mais páginas?
			if (this.paginas.length == 0) {
				// criar página única
				this.adicionaPagina();
				this.paginaAtual = 0;
			} else {
				// alterar numeração das demais páginas
				for (var i:int = 0; i < this.paginas.length; i++) {
					if (this.paginas[i].numero > numPaginaAtual) this.paginas[i].numero--;
				}
				// definir a página atual
				if (this.paginas.length > pgAtual) {
					this.paginaAtual = pgAtual;
				} else {
					this.paginaAtual = 0;
				}
			}
		}
		
		/**
		 * Seleciona uma página.
		 * @param	num	o número da página escolhida
		 * @return	TRUE se a página existe e foi selecionada como a atual
		 */
		public function selecionaPagina(num:int):Boolean
		{
			if (num < this.paginas.length) {
				var encontrada:int = -1;
				for (var i:int = 0; i < this.paginas.length; i++) {
					if (this.paginas[i].numero == num) encontrada = i;
				}
				if (encontrada >= 0) {
					this.paginaAtual = encontrada;
					return (true);
				} else {
					return (false);
				}
			} else {
				return (false);
			}
		}
		
		/**
		 * Salvando informações sobre o projeto de infográfico.
		 */
		public function salvar():void
		{
			// a pasta de gravação existe?
			if (!this.pasta.isDirectory) this.pasta.createDirectory();
			// a pasta de imagens próprias do projeto existe?
			if (!this.pasta.resolvePath('imagens').isDirectory) this.pasta.resolvePath('imagens').createDirectory();
			// salvando dados do projeto
			var stream:FileStream = new FileStream();
			stream.open(this.pasta.resolvePath('projeto.json'), FileMode.WRITE);
			stream.writeUTFBytes(JSON.stringify(this.dados));
			stream.close();
		}
		
		/**
		 * Exporta o conteúdo do projeto atual na forma de um arquivo binário único compactado.
		 * @return	o nome do arquivo exportado ou string vazia no caso de erro
		 */
		public function exportar():String
		{
			// salvando o projeto atual
			this.salvar();
			// exportando
			return(this.exportarID(this.id));
		}
		
		/**
		 * Exporta o conteúdo do projeto com o ID indicado na forma de um arquivo binário único compactado.
		 * @param	prID	id do projeto a exportar
		 * @return	o nome do arquivo exportado ou string vazia no caso de erro
		 */
		public function exportarID(prID:String):String
		{
			// o projeto existe?
			var pastaProj:File = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + prID);
			if (!pastaProj.isDirectory) {
				// a pasta do projeto indicado não foi encontrada
				return ('');
			} else {
				// verificando se existe o arquivo de informações do projeto
				var arqProj:File = pastaProj.resolvePath('projeto.json');
				if (!arqProj.exists) {
					// o arquivo de projeto não existe
					return ('');
				} else {
					// o arquivo de projeto está completo?
					var ok:Boolean = false;
					var json:Object;
					var stream:FileStream = new FileStream();
					stream.open(arqProj, FileMode.READ);
					var fileData:String = stream.readUTFBytes(stream.bytesAvailable);
					stream.close();
					// recuperando o json
					try {
						json = JSON.parse(fileData);
						ok = true;
					} catch (e:Error) { }
					// json carregado
					if ((json.id == null) || (json.titulo == null) || (json.tags == null) || (json.paginas == null) || (json.app == null)) {
						// não há informações suficientes
						return ('');
					} else {
						// criando zip e arquivos para exportação
						var zip:FZip = new FZip();
						var fileBytes:ByteArray = new ByteArray();
						// adicionando arquivo de projeto
						stream.open(pastaProj.resolvePath('projeto.json'), FileMode.READ);
						fileBytes.clear();
						stream.readBytes(fileBytes);
						stream.close();
						zip.addFile((prID + '/projeto.json'), fileBytes);
						// adicionando arquivos de imagem
						var imFiles:Array = pastaProj.resolvePath('imagens').getDirectoryListing();
						for (var indice:int = 0; indice < imFiles.length; indice++) {
							var arquivoImagem:File = imFiles[indice] as File;
							stream.open(arquivoImagem, FileMode.READ);
							fileBytes.clear();
							stream.readBytes(fileBytes);
							stream.close();
							zip.addFile((prID + '/imagens/' + arquivoImagem.name), fileBytes);
						}
						// finalizando o arquivo zip
						var nomeArquivo:String;
						if (json.titulo == '') {
							var data:Date = new Date();
							nomeArquivo = data.date + '-' + (data.month + 1) + '-' + data.fullYear + '.ifg';
						} else {
							nomeArquivo = json.titulo + '.ifg';
						}
						if (!File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/exportados').isDirectory) File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/exportados').createDirectory();
						stream.open(File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/exportados/' + nomeArquivo), FileMode.WRITE);
						zip.serialize(stream);
						stream.close();
						return (nomeArquivo);
					}
				}
			}
		}
		
		/**
		 * Apaga a pasta de um projeto.
		 * @param	id	o id do projeto a remover
		 * @return	TRUE se o projeto for encontrado e removido
		 */
		public function apagaProjeto(id:String):Boolean
		{
			var pasta:File = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + id);
			if (pasta.isDirectory) {
				pasta.deleteDirectory(true);
				return (true);
			} else {
				return (false);
			}
		}
		
		/**
		 * Define um novo id para o projeto atual.
		 * @param	novoID	o novo id
		 * @param	renomear	renomear a pasta já existente com o id atual para o novo?
		 */
		public function defineID(novoID:String, renomear:Boolean = false):void
		{
			// referência para a pasta com o novo id
			var novaPasta:File = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + novoID);
			// renomear a pasta existente com o novo id?
			if (renomear) {
				this.pasta.moveTo(novaPasta);
			}
			// atribuir o novo id
			this.id = novoID;
			this.pasta = novaPasta;
			// nova pasta? é preciso gravar o projeto
			if (renomear) {
				this.salvar();
			}
		}
		
		/**
		 * Importa o conteúdo de um projeto binário compactado.
		 * @param	origem	link para o local do arquivo binário
		 * @return	TRUE se o arquivo existir e puder ser aberto
		 */
		public function importar(origem:File):Boolean
		{
			// abrindo arquivo de origem
			if (origem.exists) {
				// criando pasta temporária de importação
				this._pastaTemp = File.createTempDirectory();
				// recuperando informações do arquivo
				var stream:FileStream = new FileStream();
				var fileBytes:ByteArray = new ByteArray();
				stream.open(origem, FileMode.READ);
				fileBytes.clear();
				stream.readBytes(fileBytes);
				stream.close();
				// abrindo zip
				var zip:FZip = new FZip();
				zip.addEventListener(FZipEvent.FILE_LOADED, onZipLoaded);
				zip.addEventListener(Event.COMPLETE, onUnzipComplete);
				zip.loadBytes(fileBytes);
				// começando importação
				return (true);
			} else {
				// o arquivo indicado não foi encontrado
				return (false);
			}
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * Um arquivo dentro do zip de importação foi retirado.
		 */
		private function onZipLoaded(evt:FZipEvent):void
		{
			var zipfile:FZipFile = evt.file;
			if (zipfile.sizeUncompressed == 0) {
				// arquivo sem dados: não recriar
			} else {
				// descompactando o arquivo em disco
				var stream:FileStream = new FileStream();
				stream.open(this._pastaTemp.resolvePath(zipfile.filename), FileMode.WRITE);
				stream.writeBytes(zipfile.content);
				stream.close();
			}
		}
		
		/**
		 * Todos os arquivos dentro do zip de importação foram extraídos.
		 */
		private function onUnzipComplete(evt:Event):void
		{
			// liberando arquivo zip
			var zip:FZip = evt.target as FZip;
			zip.removeEventListener(FZipEvent.FILE_LOADED, onZipLoaded);
			zip.removeEventListener(Event.COMPLETE, onUnzipComplete);
			// verificando integridade do projeto
			var pastas:Array = this._pastaTemp.getDirectoryListing();
			if (pastas.length != 1) {
				// o arquivo descompactado não contém uma única pasta: não é uma exportação válida
				this.dispatchEvent(new Event(Event.CANCEL));
			} else {
				// verificando a pasta de projeto encontrada
				var pastaProjeto:File = pastas[0] as File;
				if (!pastaProjeto.isDirectory) {
					// não há uma pasta recuperada de projeto
					this.dispatchEvent(new Event(Event.CANCEL));
				} else {
					// verificando se há um arquivo de projeto
					var arquivoProjeto:File = pastaProjeto.resolvePath('projeto.json');
					if (!arquivoProjeto.exists) {
						// não há um arquivo de projeto
						this.dispatchEvent(new Event(Event.CANCEL));
					} else {
						// o arquivo é um json válido?
						var stream:FileStream = new FileStream();
						stream.open(arquivoProjeto, FileMode.READ);
						var fdata:String = stream.readUTFBytes(stream.bytesAvailable);
						stream.close();
						var ok:Boolean = false;
						var json:Object;
						try {
							json = JSON.parse(fdata);
							ok = true;
						} catch (e:Error) { }
						if (!ok) {
							// o arquivo não traz um json válido
							this.dispatchEvent(new Event(Event.CANCEL));
						} else {
							if ((json.id == null) || (json.titulo == null) || (json.tags == null) || (json.paginas == null) || (json.app == null)) {
								// o arquivo json não traz as informações necessárias
								this.dispatchEvent(new Event(Event.CANCEL));
							} else {
								if (String(json.app) == ObjetoAprendizagem.codigo) {
									// projeto ok: copiar para a pasta de documentos
									pastaProjeto.moveTo(File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/projetos/' + json.id), true);
									this.dispatchEvent(new Event(Event.COMPLETE));
								} else {
									// o arquivo json não traz as um projeto de infográfico
									this.dispatchEvent(new Event(Event.CANCEL));
								}
							}
						}
					}
				}
			}
			// apagando pasta temporária
			this._pastaTemp.deleteDirectory(true);
		}
		
		/**
		 * Gera uma nova id para o projeto de infográfico.
		 * @return	uma id única
		 */
		private function geraID():String
		{
			return(String(new Date().getTime()) + String(int(Math.round(Math.random() * 1000))) + String(int(Math.round(Math.random() * 1000))) + String(int(Math.round(Math.random() * 1000))));
		}
		
		/**
		 * Uma imagem foi carregada em uma página.
		 */
		private function onImComplete(evt:Event):void
		{
			var pagina:Pagina = evt.target as Pagina;
			if (pagina.numero == this.paginaAtual) {
				this.dispatchEvent(new Event(Event.ADDED));
			}
		}

		
	}

}