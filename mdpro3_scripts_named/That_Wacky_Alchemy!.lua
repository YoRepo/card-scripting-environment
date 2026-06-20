--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔力诱爆  (ID: 22869904)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方的魔法与陷阱卡区域表侧表示存在的魔法卡被送去墓地的场合才能发动。选择场上表侧表示存在的1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--魔力誘爆
function c22869904.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c22869904.condition)
	e1:SetTarget(c22869904.target)
	e1:SetOperation(c22869904.activate)
	c:RegisterEffect(e1)
end
function c22869904.cfilter(c,tp)
	return c:IsType(TYPE_SPELL) and c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousControler(1-tp) and c:GetPreviousSequence()~=5
end
function c22869904.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c22869904.cfilter,1,nil,tp)
end
function c22869904.filter(c)
	return c:IsFaceup()
end
function c22869904.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c22869904.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c22869904.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c22869904.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c22869904.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
