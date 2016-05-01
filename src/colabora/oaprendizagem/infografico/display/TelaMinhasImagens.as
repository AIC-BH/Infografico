package colabora.oaprendizagem.infografico.display 
{
	import colabora.oaprendizagem.servidor.Listagem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MediaEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.CameraRoll;
	import flash.net.FileFilter;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class TelaMinhasImagens extends TelaListaImagens
	{
		
		// VARIÁVEIS PRIVADAS
		
		private var _btabrir:Sprite;
		private var _htmlIni:String;
		private var _htmlFim:String;
		private var _navegador:File;
		private var _roll:CameraRoll;
		
		public function TelaMinhasImagens() 
		{
			// preparando botões
			this._btabrir = Main.graficos.getSPGR('BTAbrirMp3');
			this._btabrir.addEventListener(MouseEvent.CLICK, onAbrir);
			this.addChild(this._btabrir);
			
			// recuperando textos html
			var stream:FileStream = new FileStream();
			stream.open(File.applicationDirectory.resolvePath('listaImagensInicio.html'), FileMode.READ);
			this._htmlIni = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			stream.open(File.applicationDirectory.resolvePath('listaImagensFim.html'), FileMode.READ);
			this._htmlFim = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			
			// navegador de arquivos
			this._navegador = File.documentsDirectory;
			this._navegador.addEventListener(Event.SELECT, onNavegadorSelect);
			this._navegador.addEventListener(Event.CANCEL, onNavegadorFim);
			this._navegador.addEventListener(IOErrorEvent.IO_ERROR, onNavegadorFim);
			
			// camera roll
			if (CameraRoll.supportsBrowseForImage) {
				this._roll = new CameraRoll();
				this._roll.addEventListener(MediaEvent.SELECT, onRollSelect);
				this._roll.addEventListener(Event.CANCEL, onRollCancel);
			}
		}
		
		// GET/SET
		
		/**
		 * A pasta de gravação de arquivos.
		 */
		public function get pasta():File
		{
			return (this._pasta);
		}
		public function set pasta(to:File):void
		{
			this._pasta = to;
		}
		
		// VALORES SOMENTE LEITURA
		
		/**
		 * Listagem de arquivos de imagem deste projeto.
		 */
		public function get conteudoHtml():String 
		{
			// iniciando html
			var retorno:String = this._htmlIni;
			
			// conferindo arquivos na pasta de projto
			var total:int = 0;
			var lista:Array = this._pasta.getDirectoryListing();
			for (var i:int = 0; i < lista.length; i++) {
				var arquivo:File = lista[i] as File;
				if ((arquivo.extension.toLowerCase() == 'jpg') || (arquivo.extension.toLowerCase() == 'png')) {
					total++;
					retorno += '<div class="listaitem"><div class="unselect" name="item" id="' + arquivo.name + '" onClick="onSelect(\'' + arquivo.name + '\', \'' + arquivo.name.split('.')[0] + '\');"><img src="' + arquivo.name + '" class="imglistada" /><br />' + arquivo.name.split('.')[0] + '</div></div>';
				}
			}
			
			// não há arquivos?
			if (total == 0) {
				retorno += 'Não foram encontrados arquivos de imagem para este projeto. Você pode acrescentar novos arquivos jpeg ou png clicando no botão de pasta ao lado.';
			}
			
			// finalizando html e retornando
			retorno += this._htmlFim;
			return (retorno);
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * A tela ficou disponível.
		 */
		override protected function onStage(evt:Event):void 
		{
			super.onStage(evt);
			
			// criando html de listagem
			if (!this.pasta.isDirectory) this.pasta.createDirectory();
			var stream:FileStream = new FileStream();
			stream.open(this.pasta.resolvePath('lista.html'), FileMode.WRITE);
			stream.writeUTFBytes(this.conteudoHtml);
			stream.close();
			
			// abrindo listagem
			this._webview.loadURL(this.pasta.resolvePath('lista.html').url);
			
			// ajustando botões
			this._btabrir.width = this._btabrir.height = this._btok.width;
			this._btabrir.x = this._btok.x;
			this._btabrir.y = ((2 * (stage.stageHeight / 7)) / 6);
		}
		
		/**
		 * Clique no botão abrir imagem.
		 */
		private function onAbrir(evt:MouseEvent):void
		{
			this._webview.loadString(this._htmlIni + 'Acrescentando um arquivo de imagem...' + this._htmlFim);
			
			// camera roll?
			if (CameraRoll.supportsBrowseForImage) {
				// usar galeria do aparelho
				this._roll.browseForImage();
			} else {
				// usar navegador de arquivos do sistema
				this._navegador.browseForOpen('Importando imagem', [new FileFilter("imagens", "*.jpg;*.png")]);
			}
		}
		
		/**
		 * Navegação por arquivo terminada sem nenhuma escolha.
		 */
		private function onNavegadorFim(evt:Event):void
		{
			// criando html de listagem
			if (!this.pasta.isDirectory) this.pasta.createDirectory();
			var stream:FileStream = new FileStream();
			stream.open(this.pasta.resolvePath('lista.html'), FileMode.WRITE);
			stream.writeUTFBytes(this.conteudoHtml);
			stream.close();
			
			// abrindo listagem
			this._webview.loadURL(this.pasta.resolvePath('lista.html').url);
		}
		
		/**
		 * Recebendo um arquivo de imagem selecionado.
		 */
		private function onNavegadorSelect(evt:Event):void
		{
			// copiando o arquivo
			var nome:String = this._navegador.name;
			if (nome != null) {
				this._navegador.copyTo(this._pasta.resolvePath(nome), true);
			}
			
			// criando html de listagem
			if (!this.pasta.isDirectory) this.pasta.createDirectory();
			var stream:FileStream = new FileStream();
			stream.open(this.pasta.resolvePath('lista.html'), FileMode.WRITE);
			stream.writeUTFBytes(this.conteudoHtml);
			stream.close();
			
			// abrindo listagem
			this._webview.loadURL(this.pasta.resolvePath('lista.html').url);
		}
		
		/**
		 * Camera roll cancelado.
		 */
		private function onRollCancel(evt:Event):void
		{
			// criando html de listagem
			if (!this.pasta.isDirectory) this.pasta.createDirectory();
			var stream:FileStream = new FileStream();
			stream.open(this.pasta.resolvePath('lista.html'), FileMode.WRITE);
			stream.writeUTFBytes(this.conteudoHtml);
			stream.close();
			
			// abrindo listagem
			this._webview.loadURL(this.pasta.resolvePath('lista.html').url);
		}
		
		/**
		 * Arquivo recebido do camera roll.
		 */
		private function onRollSelect(evt:MediaEvent):void
		{
			// copiando o arquivo
			var arquivo:File = evt.data.file;
			if (arquivo.exists) {
				arquivo.copyTo(this.pasta.resolvePath(arquivo.name), true);
			}
			
			// criando html de listagem
			if (!this.pasta.isDirectory) this.pasta.createDirectory();
			var stream:FileStream = new FileStream();
			stream.open(this.pasta.resolvePath('lista.html'), FileMode.WRITE);
			stream.writeUTFBytes(this.conteudoHtml);
			stream.close();
			
			// abrindo listagem
			this._webview.loadURL(this.pasta.resolvePath('lista.html').url);
		}
	}

}