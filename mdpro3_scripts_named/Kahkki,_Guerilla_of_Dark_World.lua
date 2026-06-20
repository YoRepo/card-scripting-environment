--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 暗黑界的刺客 卡其  (ID: 25847467)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 2
-- ATK 300 | DEF 500
-- Setcode: 6
--
-- Effect Text:
-- ①：这张卡被效果从手卡丢弃去墓地的场合，以场上1只怪兽为对象发动。那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--暗黒界の刺客 カーキ
function c25847467.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25847467,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c25847467.descon)
	e1:SetTarget(c25847467.destg)
	e1:SetOperation(c25847467.desop)
	c:RegisterEffect(e1)
end
function c25847467.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,0x4040)==0x4040
end
function c25847467.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c25847467.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
