package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class JanelaIncluiImagem extends JanelaEscolha
	{
		
		// VARIÁVEIS PRIVADAS
		
		private var _biblioteca:Sprite;
		private var _minhasimagens:Sprite;
		private var _meutexto:Sprite;
		
		public function JanelaIncluiImagem() 
		{
			super(AreaApp.AREAWIDTH, AreaApp.AREAHEIGHT, 'Incluir imagem a partir de');
			
			this._biblioteca = Main.graficos.getSPGR('BTBibliotecaIm');
			this._minhasimagens = Main.graficos.getSPGR('BTMinhasImagens');
			this._meutexto = Main.graficos.getSPGR('BTTexto');
			
			var intervalo:Number = (this._bg.width - this._biblioteca.width - this._minhasimagens.width - this._meutexto.width) / 4;
			this._biblioteca.x = this._bg.x + intervalo;
			this._minhasimagens.x = this._biblioteca.x + this._biblioteca.width + intervalo;
			this._meutexto.x = this._minhasimagens.x + this._minhasimagens.width + intervalo;
			this._biblioteca.y = this._bg.y + this._bg.height - 50 - this._biblioteca.height;
			this._minhasimagens.y = this._bg.y + this._bg.height - 50 - this._minhasimagens.height;
			this._meutexto.y = this._bg.y + this._bg.height - 50 - this._meutexto.height;
			
			this.addChild(this._biblioteca);
			this.addChild(this._minhasimagens);
			this.addChild(this._meutexto);
			
			this._biblioteca.addEventListener(MouseEvent.CLICK, onBiblioteca);
			this._minhasimagens.addEventListener(MouseEvent.CLICK, onMinhasImagens);
			this._meutexto.addEventListener(MouseEvent.CLICK, onTexto);
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * Clique no botão biblioteca.
		 */
		private function onBiblioteca(evt:MouseEvent):void
		{
			parent.removeChild(this);
			this.dispatchEvent(new Event('biblioteca'));
		}
		
		/**
		 * Clique no botão minhas imagens.
		 */
		private function onMinhasImagens(evt:MouseEvent):void
		{
			parent.removeChild(this);
			this.dispatchEvent(new Event('minhasimagens'));
		}
		
		/**
		 * Clique no botão texto.
		 */
		private function onTexto(evt:MouseEvent):void
		{
			parent.removeChild(this);
			this.dispatchEvent(new Event('texto'));
		}
		
	}

}