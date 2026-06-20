--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 爆弹椿象  (ID: 57409948)
-- Type: Monster / Effect / Toon
-- Attribute: WIND
-- Race: Insect
-- Level 2
-- ATK 400 | DEF 900
--
-- Effect Text:
-- 反转：确认对方场上的1张里侧守备表示的怪兽卡。如果被确认的怪兽是效果怪兽的话破坏，（反转效果不会发动），其他情况被确认卡变回原来的情况。
--[[ __CARD_HEADER_END__ ]]

--爆弾かめ虫
function c57409948.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57409948,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c57409948.target)
	e1:SetOperation(c57409948.operation)
	c:RegisterEffect(e1)
end
function c57409948.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFacedown() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFacedown,tp,0,LOCATION_MZONE,1,1,nil)
end
function c57409948.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ConfirmCards(tp,tc)
		if tc:IsType(TYPE_EFFECT) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
