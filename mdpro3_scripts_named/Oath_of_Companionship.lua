--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 战友的誓言  (ID: 99311109)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从额外卡组特殊召唤的怪兽不在自己场上存在的场合，选择对方场上表侧表示存在的1只从额外卡组特殊召唤的怪兽才能发动。选择的怪兽的控制权直到结束阶段时得到。这张卡发动的回合，自己不能把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--戦友の誓い
function c99311109.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c99311109.condition)
	e1:SetCost(c99311109.cost)
	e1:SetTarget(c99311109.target)
	e1:SetOperation(c99311109.activate)
	c:RegisterEffect(e1)
end
function c99311109.cfilter(c)
	return c:IsSummonLocation(LOCATION_EXTRA)
end
function c99311109.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c99311109.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c99311109.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c99311109.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:IsSummonLocation(LOCATION_EXTRA)
end
function c99311109.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c99311109.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99311109.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c99311109.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c99311109.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
