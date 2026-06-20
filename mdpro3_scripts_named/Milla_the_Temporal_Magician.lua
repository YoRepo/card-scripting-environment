--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 久远之魔术师 米拉  (ID: 33225925)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1800 | DEF 1000
-- Setcode: 152
--
-- Effect Text:
-- ①：这张卡召唤成功的场合，以对方场上1张里侧表示的卡为对象发动。把那张对方的卡确认。对方不能对应这个效果的发动把魔法·陷阱卡发动。
--[[ __CARD_HEADER_END__ ]]

--久遠の魔術師ミラ
function c33225925.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33225925,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33225925.target)
	e1:SetOperation(c33225925.operation)
	c:RegisterEffect(e1)
end
function c33225925.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and chkc:IsFacedown() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33225925,1))
	local g=Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetChainLimit(c33225925.chainlimit)
end
function c33225925.chainlimit(e,rp,tp)
	return tp==rp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c33225925.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ConfirmCards(tp,tc)
	end
end
