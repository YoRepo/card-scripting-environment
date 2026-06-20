--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 王家的牲祭  (ID: 72405967)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 当自己场上有「王家长眠之谷」存在时才能发动。双方玩家把手卡中的怪兽卡全部丢弃去墓地。
--[[ __CARD_HEADER_END__ ]]

--王家の生け贄
function c72405967.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c72405967.condition)
	e1:SetTarget(c72405967.target)
	e1:SetOperation(c72405967.activate)
	c:RegisterEffect(e1)
end
function c72405967.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(47355498,tp)
end
function c72405967.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,LOCATION_HAND,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,PLAYER_ALL,LOCATION_HAND)
end
function c72405967.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,LOCATION_HAND,nil,TYPE_MONSTER)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	end
end
