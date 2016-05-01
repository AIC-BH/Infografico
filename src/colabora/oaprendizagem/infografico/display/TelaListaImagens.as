package colabora.oaprendizagem.infografico.display 
{
	import art.ciclope.managana.net.Webview;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class TelaListaImagens extends Sprite
	{
		
		// VARIÁVEIS PRIVADAS
		
		protected var _webview:Webview;
		protected var _btcancel:Sprite;
		protected var _btok:Sprite;
		protected var _bg:Shape;
		protected var _selecionado:Object;
		protected var _pasta:File;
		
		public function TelaListaImagens() 
		{
			// fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(0x38332b);
			this._bg.graphics.drawRect(0, 0, 100, 100);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// webview
			this._webview = new Webview();
			this._webview.setCallback('select', onSelect);
			
			// cancel
			this._btcancel = Main.graficos.getSPGR('BTCancel');
			this._btcancel.addEventListener(MouseEvent.CLICK, onCancel);
			this.addChild(this._btcancel);
			
			// ok
			this._btok = Main.graficos.getSPGR('BTOk');
			this._btok.addEventListener(MouseEvent.CLICK, onOk);
			this.addChild(this._btok);
			
			// adicionado à tela
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onNoStage);
		}
		
		// VALORES SOMENTE LEITURA
		
		/**
		 * Informações sobre a imagem selecionada.
		 */
		public function get selecionado():Object
		{
			var retorno:Object;
			if (this._selecionado != null) {
				if ((this._selecionado.arquivo != null) && (this._selecionado.titulo != null)) {
					retorno = new Object();
					retorno.arquivo = this._selecionado.arquivo;
					retorno.titulo = this._selecionado.titulo;
				}
			}
			return (retorno);
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * A tela ficou disponível.
		 */
		protected function onStage(evt:Event):void
		{
			// fundo
			this._bg.width = stage.stageWidth;
			this._bg.height = stage.stageHeight;
			
			// tamanho dos botões
			var tamanho:Number = stage.stageHeight / 7;
			this._btcancel.width = this._btcancel.height = tamanho;
			this._btok.width = this._btok.height = tamanho;
			
			// intervalo
			var intervalo:Number = ((2 * (stage.stageHeight / 7)) / 6);
			
			// posições
			this._btcancel.x = stage.stageWidth - 10 - this._btcancel.width;
			this._btcancel.y = stage.stageHeight - intervalo - this._btcancel.height;
			this._btok.x = stage.stageWidth - 10 - this._btok.width;
			this._btok.y = this._btcancel.y - intervalo - this._btok.height;
			
			// webview
			this._webview.viewPort = new Rectangle(10, 10, (stage.stageWidth - 30 - this._btcancel.width), (stage.stageHeight - 20));
			this._webview.stage = this.stage;
		}
		
		/**
		 * Retirado da tela.
		 */
		private function onNoStage(evt:Event):void
		{
			this._webview.stage = null;
		}
		
		/**
		 * Clique no botão cancelar.
		 */
		private function onCancel(evt:MouseEvent):void
		{
			this._webview.stage = null;
			parent.removeChild(this);
			this.dispatchEvent(new Event(Event.CANCEL));
		}
		
		/**
		 * Clique no botão ok.
		 */
		private function onOk(evt:MouseEvent):void
		{
			if (this.selecionado != null) {
				this._webview.stage = null;
				parent.removeChild(this);
				this.dispatchEvent(new Event(Event.SELECT));
			}
		}
		
		/**
		 * Uma imagem foi selecionada na lista.
		 * @param	dados	informações sobre a imagem selecionada
		 */
		private function onSelect(dados:Object):void
		{
			this._selecionado = dados;
		}
		
	}

}