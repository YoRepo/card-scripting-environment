--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gagaga Magician  (ID: 26082117)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1500 | DEF 1000
-- Setcode: 0x54
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be used as Synchro Material.
-- You can only control 1 "Gagaga Magician".
-- Once per turn: You can declare a Level from 1 to 8; this card becomes that Level until the end of
-- this turn.
--[[ __CARD_HEADER_END__ ]]

--ガガガマジシャン
function c26082117.initial_effect(c)
	c:SetUniqueOnField(1,0,26082117)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26082117,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c26082117.tg)
	e1:SetOperation(c26082117.op)
	c:RegisterEffect(e1)
	--unsynchroable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c26082117.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local lv=e:GetHandler():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(26082117,1))
	e:SetLabel(Duel.AnnounceLevel(tp,1,8,lv))
end
function c26082117.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
