package colabora.oaprendizagem.infografico.dados 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class Imagem extends Sprite
	{
		// VARIÁVEIS PRIVADAS
		
		private var _info:String;
		private var _tipo:String;
		private var _ordem:int;
		private var _fonte:String;
		private var _loader:Loader;
		private var _dados:Object;
		private var _valida:Boolean;
		private var _texto:TextField;
		private var _txbg:Shape;
		private var _link:String;
		
		public function Imagem(inf:String, tp:String, or:int, ft:String = '', dd:Object = null) 
		{
			// guardando informações
			this._info = inf;
			this._tipo = tp;
			this._ordem = or;
			this._fonte = ft;
			this._dados = dd;
			this._valida = false;
			this.mouseChildren = false;
			
			// aplicando cor e link
			if (dd != null) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, (dd.vermelho as Number), (dd.verde as Number), (dd.azul as Number));
				this._link = dd.link as String;
			} else {
				this._link = '';
			}

			// carregando conteúdo
			if (tp == 'tx') {
				// fundo do texto
				this._txbg = new Shape();
				this._txbg.graphics.beginFill(0, 0);
				this._txbg.graphics.drawRect(0, 0, 16, 16);
				this._txbg.graphics.endFill();
				this.addChild(this._txbg);
				
				// texto
				switch (ft) {
					case 'Averia':
					case 'Gamaliel':
					case 'CodeNewRoman':
						// não fazer nada
						break;
					default:
						ft = 'Pfennig';
						break;
				}
				this._fonte = ft;
				this._texto = new TextField();
				this._texto.embedFonts = true;
				this._texto.defaultTextFormat = new TextFormat(ft, 70, 0);
				this._texto.multiline = false;
				this._texto.wordWrap = false;
				this._texto.selectable = false;
				this._texto.autoSize = TextFieldAutoSize.LEFT;
				this._texto.text = inf;
				this.addChild(this._texto);
				
				// tamanho e posição do texto
				this._txbg.width = this._texto.width;
				this._txbg.height = this._texto.height;
				this._txbg.x = -this._txbg.width / 2;
				this._txbg.y = -this._txbg.height / 2;
				this._texto.x = -this._texto.width / 2;
				this._texto.y = -this._texto.height / 2;
				
				// posição inicial?
				if (this._dados != null) {
					this.x = this._dados.x as Number;
					this.y = this._dados.y as Number;
					this.scaleX = this.scaleY = this._dados.scale as Number;
					this.rotation = this._dados.rotation as Number;
					this._dados.info = null;
					this._dados.tipo = null;
					this._dados.fonte = null;
					this._dados = null;
				} else {
					// posicionar no centro da tela
					this.x = Main.conteudo.oWidth / 2;
					this.y = Main.conteudo.oHeight / 2;
				}
				
				this._valida = true;
				
			} else {
				
				// preparando loader
				this._loader = new Loader();
				this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
				this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
				
				if (tp == 'bb') {
					// carregando da biblioteca
					this._loader.load(new URLRequest(File.applicationDirectory.resolvePath('biblioteca/' + inf).url));
				} else {
					// carregando da pasta do projeto
					this._loader.load(new URLRequest(Main.projeto.pasta.resolvePath('imagens/' + inf).url));
				}
			}
		}
		
		// SOMENTE LEITURA
		
		/**
		 * Informações sobre a imagem.
		 */
		public function get dados():Object
		{
			var retorno:Object;
			if (this.valida) {
				var rot:Number = this.rotation;
				this.rotation = 0;
				retorno = new Object();
				retorno.x = this.x;
				retorno.y = this.y;
				retorno.scale = this.scaleX;
				retorno.width = this.width;
				retorno.height = this.height;
				retorno.rotation = rot;
				retorno.info = this._info;
				retorno.tipo = this._tipo;
				retorno.ordem = this._ordem;
				retorno.fonte = this._fonte;
				retorno.vermelho = this.transform.colorTransform.redOffset;
				retorno.verde = this.transform.colorTransform.greenOffset;
				retorno.azul = this.transform.colorTransform.blueOffset;
				retorno.link = this._link;
				this.rotation = rot;
			}
			return (retorno);
		}
		
		/**
		 * A ordem da imagem ns lista de display.
		 */
		public function get ordem():int
		{
			return (this._ordem);
		}
		
		/**
		 * O tipo de imagem.
		 */
		public function get tipo():String
		{
			return (this._tipo);
		}
		
		/**
		 * Informação sobre a imagem.
		 */
		public function get info():String
		{
			return (this._info);
		}
		
		/**
		 * Link da imagem.
		 */
		public function get link():String
		{
			return (this._link);
		}
		
		/**
		 * Texto da imagem.
		 */
		public function get texto():String
		{
			if (this._tipo == 'tx') {
				return (this._texto.text);
			} else {
				return ('');
			}
		}
		
		/**
		 * Fonte do texto da imagem.
		 */
		public function get fonte():String
		{
			return (this._fonte);
		}
		
		/**
		 * A imagem é válida? (arquivo carregado)
		 */
		public function get valida():Boolean
		{
			return (this._valida);
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Define o texto da imagem.
		 * @param	tx	texto
		 * @param	ft	fonte
		 */
		public function defineTexto(tx:String, ft:String):void
		{
			if (this._tipo == 'tx') {
				// texto
				this._texto.text = tx;
				// fonte
				switch (ft) {
					case 'Averia':
					case 'Gamaliel':
					case 'CodeNewRoman':
						// não fazer nada
						break;
					default:
						ft = 'Pfennig';
						break;
				}
				this._fonte = ft;
				this._texto.setTextFormat(new TextFormat(ft, 70, 0));
				// tamanho e posição do texto
				this._txbg.width = this._texto.width;
				this._txbg.height = this._texto.height;
				this._txbg.x = -this._txbg.width / 2;
				this._txbg.y = -this._txbg.height / 2;
				this._texto.x = -this._texto.width / 2;
				this._texto.y = -this._texto.height / 2;
			}
		}
		
		/**
		 * Libera recursos usados por este objeto.
		 */
		public function dispose():void
		{
			this.removeChildren();
			this._info = null;
			this._tipo = null;
			this._fonte = null;
			if (this._dados != null) {
				this._dados.info = null;
				this._dados.tipo = null;
				this._dados.fonte = null;
				this._dados = null;
			}
			if (this._loader != null) {
				if (this._loader.contentLoaderInfo.hasEventListener(Event.COMPLETE)) this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
				if (this._loader.contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR)) this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
				if (this._loader.content != null) this._loader.unload();
				this._loader = null;
			}
			if (this._texto != null) {
				this._texto = null;
			}
			if (this._txbg != null) {
				this._txbg.graphics.clear();
				this._txbg = null;
			}
		}
		
		/**
		 * Ajusta a ordem da imagem na tela.
		 * @param	nova	nova ordem da imagem
		 */
		public function ajustaOrdem(nova:int):void
		{
			this._ordem = nova;
		}
		
		/**
		 * Define o link da imagem.
		 * @param	lk	texto do link
		 */
		public function defineLink(lk:String):void
		{
			if (lk == '') {
				this._link = '';
			} else {
				var num:Number = Number(lk);
				if (isNaN(num)) {
					if ((lk.substr(0, 7).toLowerCase() == 'http://') || (lk.substr(0, 8).toLowerCase() == 'https://')) {
						this._link = lk;
					} else {
						this._link = 'http://' + lk;
					}
				} else {
					if (num >= 0) {
						this._link = String(int(Math.round(num)));
					} else {
						this._link = '0';
					}
				}
			}
		}
		
		/**
		 * Adiciona um grau de vermelho à imagem.
		 */
		public function adicionaVermelho():void
		{
			if (this.transform.colorTransform.redOffset < 250) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, (this.transform.colorTransform.redOffset + 50), this.transform.colorTransform.greenOffset, this.transform.colorTransform.blueOffset);
			} else {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, this.transform.colorTransform.greenOffset, this.transform.colorTransform.blueOffset);
			}
		}
		
		/**
		 * Retira um grau de vermleho da imagem.
		 */
		public function retiraVermelho():void
		{
			if (this.transform.colorTransform.redOffset > 250) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 200, this.transform.colorTransform.greenOffset, this.transform.colorTransform.blueOffset);
			} else if (this.transform.colorTransform.redOffset > 0) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, (this.transform.colorTransform.redOffset - 50), this.transform.colorTransform.greenOffset, this.transform.colorTransform.blueOffset);
			}
		}
		
		/**
		 * Adiciona um grau de verde à imagem.
		 */
		public function adicionaVerde():void
		{
			if (this.transform.colorTransform.greenOffset < 250) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, (this.transform.colorTransform.greenOffset + 50), this.transform.colorTransform.blueOffset);
			} else {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, 255, this.transform.colorTransform.blueOffset);
			}
		}
		
		/**
		 * Retira um grau de verde da imagem.
		 */
		public function retiraVerde():void
		{
			if (this.transform.colorTransform.greenOffset > 250) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, 200, this.transform.colorTransform.blueOffset);
			} else if (this.transform.colorTransform.greenOffset > 0) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, (this.transform.colorTransform.greenOffset - 50), this.transform.colorTransform.blueOffset);
			}
		}
		
		/**
		 * Adiciona um grau de azul à imagem.
		 */
		public function adicionaAzul():void
		{
			if (this.transform.colorTransform.blueOffset < 250) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, this.transform.colorTransform.greenOffset, (this.transform.colorTransform.blueOffset + 50));
			} else {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, this.transform.colorTransform.greenOffset, 255);
			}
		}
		
		/**
		 * Retira um grau de azul da imagem.
		 */
		public function retiraAzul():void
		{
			if (this.transform.colorTransform.blueOffset > 250) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, this.transform.colorTransform.greenOffset, 200);
			} else if (this.transform.colorTransform.blueOffset > 0) {
				this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, this.transform.colorTransform.redOffset, this.transform.colorTransform.greenOffset, (this.transform.colorTransform.blueOffset - 50));
			}
		}
		
		/**
		 * Redefinindo o tamanho, rotação e a posição da imagem.
		 */
		public function reset():void
		{
			this.scaleX = this.scaleY = 1;
			this.x = Main.conteudo.oWidth / 2;
			this.y = Main.conteudo.oHeight / 2;
			this.rotation = 0;
			this.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0);
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * Uma imagem acaba de ser carregada.
		 */
		private function onLoaderComplete(evt:Event):void
		{
			// preparando imagem recebida
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
			(this._loader.content as Bitmap).smoothing = true;
			this._loader.x = -this._loader.width / 2;
			this._loader.y = -this._loader.height / 2;
			this.addChild(this._loader);
			
			// posição inicial?
			if (this._dados != null) {
				this.x = this._dados.x as Number;
				this.y = this._dados.y as Number;
				this.scaleX = this.scaleY = this._dados.scale as Number;
				this.rotation = this._dados.rotation as Number;
				this._dados.info = null;
				this._dados.tipo = null;
				this._dados.fonte = null;
				this._dados = null;
			} else {
				// posicionar no centro da tela
				this.x = Main.conteudo.oWidth / 2;
				this.y = Main.conteudo.oHeight / 2;
			}

			// avisando
			this._valida = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Erro ao carregar uma imagem.
		 */
		private function onLoaderError(evt:Event):void
		{
			// preparando imagem recebida
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
			
			// avisando
			this.dispatchEvent(new Event(Event.CANCEL));
		}
		
	}

}