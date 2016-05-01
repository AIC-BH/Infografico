package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class TelaLink extends Sprite
	{
		/**
		 * Informações sobre link selecionado.
		 */
		public var selecionado:String;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		private var _bgTextArea:Bitmap;
		private var _titulo:TextField;
		
		private var _btcancel:Sprite;
		private var _btok:Sprite;
		
		public function TelaLink() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBG);
			this._bg.graphics.drawRect(0, 0, AreaApp.AREAWIDTH, AreaApp.AREAHEIGHT);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// área de texto
			this._bgTextArea = Main.graficos.getGR('AreaTextoLink');
			this.addChild(this._bgTextArea);
			
			// entrada de texto
			this._titulo = new TextField();
			this._titulo.defaultTextFormat = new TextFormat('_sans', 40, 0);
			this._titulo.multiline = false;
			this._titulo.wordWrap = false;
			this._titulo.type = TextFieldType.INPUT;
			this._titulo.needsSoftKeyboard = true;
			this.addChild(this._titulo);
			
			// botões ok/cancel
			this._btcancel = Main.graficos.getSPGR('BTCancel');
			this._btcancel.addEventListener(MouseEvent.CLICK, onCancel);
			this.addChild(this._btcancel);
			this._btok = Main.graficos.getSPGR('BTOk');
			this._btok.addEventListener(MouseEvent.CLICK, onOk);
			this.addChild(this._btok);
			
			// posição x
			var intervaloX:Number = (this._bg.width - (2 * this._btok.width)) / 3;
			this._bgTextArea.x = (this._bg.width - this._bgTextArea.width) / 2;
			this._btok.x = (this._bg.width / 2) + intervaloX;
			this._btcancel.x = (this._bg.width / 2) - intervaloX - this._btcancel.width;
			
			// posição y
			var intervaloY:Number = (this._bg.height - this._bgTextArea.height - this._btcancel.height) / 3;
			this._bgTextArea.y = intervaloY;
			this._btcancel.y = this._btok.y = this._bgTextArea.y + this._bgTextArea.height + intervaloY;
			
			// posicionando caixa de texto
			this._titulo.x = this._bgTextArea.x + 140;
			this._titulo.y = this._bgTextArea.y + 35;
			this._titulo.width = 740;
			this._titulo.height = 80;
			
			// retorno
			this.selecionado = '';
		}
		
		/**
		 * Mostra o link de uma imagem.
		 * @param	lk	o texto do link
		 */
		public function mostraLink(lk:String):void
		{
			this._titulo.text = lk;
		}
		
		// FUNÇÕES PRIVADAS
		
		
		/**
		 * Clique no botão cancel.
		 */
		private function onCancel(evt:MouseEvent):void
		{
			parent.removeChild(this);
			this.dispatchEvent(new Event(Event.CANCEL));
		}
		
		/**
		 * Clique no botão ok.
		 */
		private function onOk(evt:MouseEvent):void
		{
			parent.removeChild(this);
			this.selecionado = this._titulo.text;
			this.dispatchEvent(new Event(Event.SELECT));
		}
	}

}