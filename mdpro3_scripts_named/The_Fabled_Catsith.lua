--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 魔轰神兽 凯希  (ID: 56399890)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Beast
-- Level 1
-- ATK 800 | DEF 600
-- Setcode: 53
--
-- Effect Text:
-- ①：这张卡从手卡丢弃去墓地的场合，以场上1张表侧表示卡为对象发动。那张表侧表示卡破坏。
--[[ __CARD_HEADER_END__ ]]

--魔轟神獣キャシー
function c56399890.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56399890,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c56399890.descon)
	e1:SetTarget(c56399890.destg)
	e1:SetOperation(c56399890.desop)
	c:RegisterEffect(e1)
end
function c56399890.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,REASON_DISCARD)~=0
end
function c56399890.filter(c)
	return c:IsFaceup()
end
function c56399890.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c56399890.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c56399890.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c56399890.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
