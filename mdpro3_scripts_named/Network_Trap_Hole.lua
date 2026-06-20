--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 电网的落穴  (ID: 84640866)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 76
--
-- Effect Text:
-- ①：对方从卡组·墓地把怪兽特殊召唤时才能发动。那些怪兽里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--電網の落とし穴
function c84640866.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c84640866.target)
	e1:SetOperation(c84640866.activate)
	c:RegisterEffect(e1)
end
function c84640866.filter(c,tp)
	return c:IsSummonPlayer(1-tp) and c:IsSummonLocation(LOCATION_DECK+LOCATION_GRAVE)
		and c:IsAbleToRemove(tp,POS_FACEDOWN) and c:IsLocation(LOCATION_MZONE)
end
function c84640866.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c84640866.filter,nil,tp)
	local ct=g:GetCount()
	if chk==0 then return ct>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,ct,0,0)
end
function c84640866.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c84640866.filter,nil,tp):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
	end
end
