--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 风魔的波动  (ID: 2994495)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以场上1只表侧表示怪兽为对象才能发动。选和那只怪兽卡名不同并持有相同属性的场上1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--風魔の波動
function c2994495.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c2994495.target)
	e1:SetOperation(c2994495.activate)
	c:RegisterEffect(e1)
end
function c2994495.desfilter1(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c2994495.desfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c)
end
function c2994495.desfilter2(c,mc)
	return c:IsFaceup() and c:IsAttribute(mc:GetAttribute()) and not c:IsCode(mc:GetCode())
end
function c2994495.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c2994495.desfilter1(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c2994495.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c2994495.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	local g2=Duel.GetMatchingGroup(c2994495.desfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,g1,g1:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,1,0,0)
end
function c2994495.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c2994495.desfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc,tc)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
