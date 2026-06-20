--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 蛇毒飞溅  (ID: 4466015)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 80
--
-- Effect Text:
-- 选择1只放置有毒指示物的怪兽发动。把那张卡的毒指示物取除，给与对方基本分取除的毒指示物数量×700的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ヴェノム・スプラッシュ
function c4466015.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c4466015.target)
	e1:SetOperation(c4466015.activate)
	c:RegisterEffect(e1)
end
function c4466015.filter(c)
	return c:GetCounter(0x1009)>0
end
function c4466015.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c4466015.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4466015.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c4466015.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetCounter(0x1009)*700)
end
function c4466015.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=tc:GetCounter(0x1009)
	if ct>0 then
		tc:RemoveCounter(tp,0x1009,ct,REASON_EFFECT)
		Duel.Damage(1-tp,ct*700,REASON_EFFECT)
	end
end
