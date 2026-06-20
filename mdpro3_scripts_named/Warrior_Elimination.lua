--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 战士抹杀  (ID: 90873992)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场上表侧表示存在的战士族怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--戦士抹殺
function c90873992.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c90873992.target)
	e1:SetOperation(c90873992.activate)
	c:RegisterEffect(e1)
end
function c90873992.filter(c)
	return c:IsRace(RACE_WARRIOR) and c:IsFaceup()
end
function c90873992.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90873992.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c90873992.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c90873992.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c90873992.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
