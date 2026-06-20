--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 盾碎  (ID: 30683373)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以场上1只守备表示怪兽为对象才能发动。那只守备表示怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--シールドクラッシュ
function c30683373.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c30683373.target)
	e1:SetOperation(c30683373.activate)
	c:RegisterEffect(e1)
end
function c30683373.filter(c)
	return c:IsDefensePos()
end
function c30683373.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c30683373.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c30683373.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c30683373.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c30683373.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsDefensePos() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
