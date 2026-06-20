--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 重量超过  (ID: 63193536)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方对怪兽的特殊召唤成功时才能发动。场上的2星以下的怪兽全部从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--重量オーバー
function c63193536.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c63193536.condition)
	e1:SetTarget(c63193536.target)
	e1:SetOperation(c63193536.activate)
	c:RegisterEffect(e1)
end
function c63193536.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c63193536.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c63193536.cfilter,1,nil,1-tp)
end
function c63193536.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(2) and c:IsAbleToRemove()
end
function c63193536.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c63193536.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c63193536.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c63193536.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c63193536.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
